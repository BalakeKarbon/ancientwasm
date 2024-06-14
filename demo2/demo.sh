#!/bin/bash
f2c f1.f
f2c f2.f 
sed -i 's/int s_copy/void s_copy/g' f2.c
cobc -x -C main.cbl -K f_ -K ff_ -K emscripten_run_script
emcc f1.c f2.c main.c -lgmp -lcob -lf2c -o demo.js
echo "Running demo..."
node demo.js
