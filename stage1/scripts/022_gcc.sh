#!/bin/bash

source scripts/000_setup.sh
MPFR_VER=mpfr-4.1.0
GMP_VER=gmp-6.2.1
MPC_VER=mpc-1.2.1
GCC_VER=gcc-12.2.0

cd "$SOURCES"

rm -fR "$GCC_VER"
tar -xf "$GCC_VER.tar.xz"

cd "$GCC_VER/"

tar -xf "../${MPFR_VER}.tar.xz"
mv -v "$MPFR_VER" mpfr

tar -xf "../${GMP_VER}.tar.xz"
mv -v "$GMP_VER" gmp

tar -xf "../${MPC_VER}.tar.gz"
mv -v "$MPC_VER" mpc

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -pv build
cd       build

../configure                                       \
        --build=$(../config.guess)                     \
        --host="$UPC_TARGET"                           \
        --target="$UPC_TARGET"                         \
        LDFLAGS_FOR_TARGET=-L"$PWD/$UPC_TARGET/libgcc" \
        --prefix=/usr                                  \
        --with-build-sysroot="$UPC"                    \
        --enable-initfini-array                        \
        --disable-nls                                  \
        --disable-multilib                             \
        --disable-decimal-float                        \
        --disable-libatomic                            \
        --disable-libgomp                              \
        --disable-libquadmath                          \
        --disable-libssp                               \
        --disable-libvtv                               \
        --disable-gcov                                 \
        --enable-languages=c,c++
make
make               \
        DESTDIR="$UPC" \
        install
ln -sv gcc "$UPC/usr/bin/cc"
