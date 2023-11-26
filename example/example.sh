#!/bin/bash
echo "Building Example..."
echo "Native..."
./compile-native.sh
echo "Web Assembly..."
./compile-wasm.sh
echo "Running Example..."
echo "Native:"
./example
echo "Web Assembly:"
node example.js
