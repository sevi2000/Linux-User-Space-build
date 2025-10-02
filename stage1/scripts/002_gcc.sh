#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

MPFR_VER=mpfr-4.1.0
GMP_VER=gmp-6.2.1
MPC_VER=mpc-1.2.1
GCC_VER=gcc-12.2.0

wget -nc "https://ftp.gnu.org/gnu/mpfr/${MPFR_VER}.tar.xz"
wget -nc "https://ftp.gnu.org/gnu/gmp/${GMP_VER}.tar.xz"
wget -nc "https://ftp.gnu.org/gnu/mpc/${MPC_VER}.tar.gz"
wget -nc "https://ftp.gnu.org/gnu/gcc/${GCC_VER}/${GCC_VER}.tar.xz"

tar -xf "${GCC_VER}.tar.xz"
cd "$GCC_VER/"

[ -e mpfr ] || {
    tar -xf "../${MPFR_VER}.tar.xz"
    mv -v "$MPFR_VER" mpfr
}
[ -e gmp ] || {
    tar -xf "../${GMP_VER}.tar.xz"
    mv -v "$GMP_VER" gmp
}
[ -e mpc ] || {
    tar -xf "../${MPC_VER}.tar.gz"
    mv -v "$MPC_VER" mpc
}

mkdir -pv build
cd       build

../configure                                \
        --target="$UPC_TARGET"                  \
        --prefix="$UPC/tools"                   \
        --with-sysroot="$UPC" \
        --with-glibc-version=2.36               \
        --with-newlib                           \
        --without-headers                       \
        --disable-nls                           \
        --disable-shared                        \
        --disable-multilib                      \
        --disable-decimal-float                 \
        --disable-threads                       \
        --disable-libatomic                     \
        --disable-libgomp                       \
        --disable-libquadmath                   \
        --disable-libssp                        \
        --disable-libvtv                        \
        --disable-libstdcxx                     \
        --disable-gcov                          \
        --enable-languages=c,c++

make

make install
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
        `dirname $($UPC_TARGET-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
