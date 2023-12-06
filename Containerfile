FROM fedora

RUN dnf -y update
RUN dnf -y install lzip xz gcc make f2c gnucobol git unzip python
WORKDIR /usr/src
RUN curl https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz --output gmp-6.3.0.tar.xz 
RUN curl https://phoenixnap.dl.sourceforge.net/project/gnucobol/gnucobol/3.2/gnucobol-3.2.tar.lz --output gnucobol-3.2.tar.lz 
RUN curl https://www.netlib.org/f2c/libf2c.zip --output libf2c.zip 

#emsdk
WORKDIR /usr/share/
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR /usr/share/emsdk
RUN ./emsdk install latest
RUN ./emsdk activate latest
ENV PATH="${PATH}:/usr/share/emsdk:/usr/share/emsdk/upstream/emscripten:/usr/share/emsdk/node/16.20.0_64bit/bin"
ENV EMSDK="/usr/share/emsdk"
ENV EMSDK_NODE="/usr/share/emsdk/node/16.20.0_64bit/bin/node"

#gmp
WORKDIR /usr/src
RUN tar -xf gmp-6.3.0.tar.xz
WORKDIR /usr/src/gmp-6.3.0
RUN mkdir build
WORKDIR /usr/src/gmp-6.3.0/build
RUN emconfigure ../configure --host none
RUN emmake make 
RUN mkdir /usr/libwasm
RUN yes | cp -f *.h /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/
RUN cp .libs/* /usr/share/emsdk/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten/

#gnucobol
WORKDIR /usr/src
RUN lzip -d gnucobol-3.2.tar.lz
RUN tar -xf gnucobol-3.2.tar
WORKDIR /usr/src/gnucobol-3.2
#RUN ["/bin/bash", "-c", "export CFLAGS='-I/usr/src/gmp-6.3.0/build'; export LDFLAGS='-L/usr/libwasm'; emconfigure ./configure --without-db --host none; cd libcob; emmake make"]
RUN ["/bin/bash", "-c", "emconfigure ./configure --without-db --host none; cd libcob; emmake make"]
RUN cp -f *.h /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/
WORKDIR /usr/src/gnucobol-3.2/libcob
RUN mkdir /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/libcob
RUN cp *.h /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/libcob
RUN cp *.def /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/libcob
RUN cp .libs/* /usr/share/emsdk/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten/

#libf2c
WORKDIR /usr/src
RUN mkdir libf2c
WORKDIR /usr/src/libf2c
RUN unzip /usr/src/libf2c.zip
RUN cp makefile.u makefile
RUN emmake make
RUN cp *.a /usr/share/emsdk/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten/
RUN yes | cp -f *.h /usr/share/emsdk/upstream/emscripten/cache/sysroot/include/

WORKDIR /root

#get demo
ADD example /root/example
