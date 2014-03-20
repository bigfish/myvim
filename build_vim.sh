#!/bin/bash
hg clone https://bitbucket.org/ZyX_I/vim
cd vim
hg update 8abaeea8b2e5
cd src && make autoconf && cd ..

./configure \
  --enable-gui=no \
  --without-x \
  --enable-multibyte \
  --with-tlib=ncurses \
  --enable-cscope \
  --with-features=huge \
  --disable-nls \
  --enable-perlinterp \
  --enable-pythoninterp \
  --with-python-config-dir=/usr/lib/python2.7/config \
  --enable-rubyinterp \
  --enable-termtruecolor

make
#make install

