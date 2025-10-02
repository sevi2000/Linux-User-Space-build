#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/
UTILLINUX_VER=util-linux-2.38.1
tar -xf "${UTILLINUX_VER}.tar.xz"

cd "$UTILLINUX_VER"

mkdir -pv /var/lib/hwclock
./configure                                   \
        ADJTIME_PATH=/var/lib/hwclock/adjtime     \
        --libdir=/usr/lib                         \
        --docdir=/usr/share/doc/util-linux-2.38.1 \
        --disable-chfn-chsh                       \
        --disable-login                           \
        --disable-nologin                         \
        --disable-su                              \
        --disable-setpriv                         \
        --disable-runuser                         \
        --disable-pylibmount                      \
        --disable-static                          \
        --without-python                          \
        runstatedir=/run
make
make install
