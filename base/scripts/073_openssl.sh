#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf openssl-3.0.5.tar.gz
cd openssl-3.0.5
./config --prefix=/usr         \
             --openssldir=/etc/ssl \
             --libdir=lib          \
             shared                \
             zlib-dynamic
make
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install
mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.0.5
