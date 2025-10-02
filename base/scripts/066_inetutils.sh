#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf inetutils-2.3.tar.xz
cd inetutils-2.3
./configure --prefix=/usr        \
                --bindir=/usr/bin    \
                --localstatedir=/var \
                --disable-logger     \
                --disable-whois      \
                --disable-rcp        \
                --disable-rexec      \
                --disable-rlogin     \
                --disable-rsh        \
                --disable-servers
make
make install
mv -v /usr/{,s}bin/ifconfig
