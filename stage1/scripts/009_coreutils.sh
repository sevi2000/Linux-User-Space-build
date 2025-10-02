#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

COREUTILS_VER=coreutils-9.1

wget -nc "https://ftp.gnu.org/gnu/coreutils/${COREUTILS_VER}.tar.xz"
tar -xf "${COREUTILS_VER}.tar.xz"

cd "$COREUTILS_VER"

./configure --prefix=/usr                           \
                --host="$UPC_TARGET"                    \
                --build=$(build-aux/config.guess)       \
                --enable-install-program=hostname       \
                --enable-no-install-program=kill,uptime
make
make               \
        DESTDIR="$UPC" \
        install

mv -v "$UPC/usr/bin/chroot"              "$UPC/usr/sbin"
mkdir -pv "$UPC/usr/share/man/man8"
mv -v "$UPC/usr/share/man/man1/chroot.1" "$UPC/usr/share/man/man8/chroot.8"
sed -i 's/"1"/"8"/'                    "$UPC/usr/share/man/man8/chroot.8"
