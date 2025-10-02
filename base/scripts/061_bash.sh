#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf bash-5.1.16.tar.gz
cd bash-5.1.16
./configure --prefix=/usr                       \
                --docdir="/usr/share/doc/bash-5.1.16" \
                --without-bash-malloc               \
                --with-installed-readline
make
make install
