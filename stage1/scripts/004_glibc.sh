#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

GLIBC_VER=glibc-2.36

wget -nc "https://ftp.gnu.org/gnu/glibc/${GLIBC_VER}.tar.xz"
tar -xf "${GLIBC_VER}.tar.xz"

cd "$GLIBC_VER"

mkdir -vp build
cd       build

../configure                                        \
        --host="$UPC_TARGET"                            \
        --prefix=/usr                                   \
        --build=$(../scripts/config.guess)              \
        --enable-kernel=3.2                             \
        --with-headers="$UPC/usr/include" \
        libc_cv_slibdir=/usr/lib
make

make               \
        DESTDIR="$UPC" \
        install

export CONFIG_SHELL=/bin/bash
"$UPC/tools/libexec/gcc/$UPC_TARGET/12.2.0/install-tools/mkheaders"
unset CONFIG_SHELL
