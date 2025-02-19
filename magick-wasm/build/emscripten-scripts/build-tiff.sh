#!/bin/bash

source emscripten-scripts/base.sh

mkdir -p $PREFIX/src
cd $PREFIX/src
rm -rf tiff 
git clone https://github.com/ImageMagick/tiff.git
cd tiff

autoreconf -fiv
export CHOST=emcc && emconfigure ./configure --prefix=$PREFIX CFLAGS="$FLAGS" \
  --disable-shared PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
testExitCode "libtiff configure" $?

emcmake make install CFLAGS="$CFLAGS" 
testExitCode "libtiff make install" $?


