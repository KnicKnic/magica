#!/bin/bash

# tests generataed .wasm files using magica test suite. 
source emscripten-scripts/base.sh

WASM_IMAGEMAGICK_DIR=$PREFIX/wasm
MAGICA_DIR=$PREFIX/wasm/magica-test

rm -rf $MAGICA_DIR
mkdir -p $MAGICA_DIR
cd $MAGICA_DIR
git clone https://github.com/cancerberoSgx/magica.git
cd magica
npm i && npm run build && npm test
testExitCode "magica test failed with its own wasm - not our fault" $?
npm run clean
rm src/imageMagick/compiled/*
cp $WASM_IMAGEMAGICK_DIR/magick.wasm $WASM_IMAGEMAGICK_DIR/magick.js src/imageMagick/compiled/
npm run build && npm test
testExitCode "magica test failed with new wasm" $?
