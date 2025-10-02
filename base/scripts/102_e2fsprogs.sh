#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf e2fsprogs-1.46.5.tar.gz
cd e2fsprogs-1.46.5
mkdir -vp build
cd       build
../configure --prefix=/usr   \
             --sysconfdir=/etc   \
             --enable-elf-shlibs \
             --disable-libblkid  \
             --disable-libuuid   \
             --disable-uuidd     \
             --disable-fsck
make
make install
rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a


