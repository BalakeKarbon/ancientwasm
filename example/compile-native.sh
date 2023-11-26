#!/bin/bash
f2c subf.f
cobc -x -C main.cbl -K r_
gcc subf.c main.c -lgmp -lcob -o example
