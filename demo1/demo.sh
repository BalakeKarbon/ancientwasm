#!/bin/bash
echo "Building Demo..."
echo "Native..."
./compile-native.sh
echo "Web Assembly..."
./compile-wasm.sh
echo "Running Demo..."
echo "Native:"
./demo
echo "Web Assembly:"
node demo.js
