#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf flex-2.6.4.tar.gz
cd flex-2.6.4
./configure --prefix=/usr \
                --docdir="/usr/share/doc/flex-2.6.4" \
                --disable-static
make
make install
ln -sv flex /usr/bin/lex

