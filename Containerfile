FROM debian

RUN apt-get update
RUN apt-get -y install wget lzip xz-utils gcc make f2c gnucobol git unzip python3
WORKDIR /root
RUN wget https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz && wget https://phoenixnap.dl.sourceforge.net/project/gnucobol/gnucobol/3.2/gnucobol-3.2.tar.lz && wget https://www.netlib.org/f2c/libf2c.zip && git clone https://github.com/emscripten-core/emsdk.git

#emsdk
WORKDIR /root/emsdk
RUN ./emsdk install latest
RUN ./emsdk activate latest
ENV PATH="${PATH}:/root/emsdk:/root/emsdk/upstream/emscripten:/root/emsdk/node/16.20.0_64bit/bin"
ENV EMSDK="/root/emsdk"
ENV EMSDK_NODE="/root/emsdk/node/16.20.0_64bit/bin/node"

#gmp
WORKDIR /root
RUN tar -xf gmp-6.3.0.tar.xz
WORKDIR /root/gmp-6.3.0
RUN emconfigure ./configure --host none
RUN emmake make 

#gnucobol
WORKDIR /root
RUN lzip -d gnucobol-3.2.tar.lz
RUN tar -xf gnucobol-3.2.tar
WORKDIR /root/gnucobol-3.2
RUN ["/bin/bash", "-c", "export CFLAGS='-I/root/gmp-6.3.0/'; export LDFLAGS='-L/root/gmp-6.3.0/.libs'; emconfigure ./configure --without-db --host none; cd libcob; emmake make"]

#libf2c
RUN mkdir libf2c
WORKDIR /root/libf2c
RUN unzip /root/libf2c.zip
RUN cp makefile.u makefile
RUN emmake make

WORKDIR /root

#get demo
ADD demo /root/demo
