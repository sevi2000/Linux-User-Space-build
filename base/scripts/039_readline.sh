#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"
tar -xf readline-8.1.2.tar.gz
cd readline-8.1.2
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr    \
                --disable-static \
                --with-curses    \
                --docdir="/usr/share/doc/readline-8.1.2"
make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw"  install
