#!/bin/bash
f2c f1.f
f2c f2.f #Currently an issue here where f2c declares a subroutine as an int but it is defined as a void.
sed -i 's/int s_copy/void s_copy/g' f2.c
cobc -x -C main.cbl -K f_ -K ff_ -K emscripten_run_script
sed -i 's/cob_u64_t/cob_u32_t/g' main.c #How do modify main.cbl so type is 32 bit?
emcc f1.c f2.c main.c -lgmp -lcob -lf2c -o example.js
