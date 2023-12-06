#!/bin/bash
f2c subf.f
cobc -x -C main.cbl -K r_
#emcc subf.c main.c -I/root/gmp-6.3.0/ -I/root/gnucobol-3.2/ -I/root/libf2c -L/root/gmp-6.3.0/.libs/ -L/root/gnucobol-3.2/libcob/.libs/ -lgmp -lcob -o example.js
emcc subf.c main.c -lgmp -lcob -o example.js
