#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf findutils-4.9.0.tar.xz
cd findutils-4.9.0
TIME_T_32_BIT_OK=yes ./configure \
                         --prefix=/usr \
                         --localstatedir=/var/lib/locate
make
make install

