#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

ZSTD_VER=zstd-1.5.2

tar -xf "${ZSTD_VER}.tar.gz"

cd "$ZSTD_VER"

patch -Np1 -i ../zstd-1.5.2-upstream_fixes-1.patch

    make prefix=/usr
    make prefix=/usr install
    rm -v /usr/lib/libzstd.a
