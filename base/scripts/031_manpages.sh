#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

MANPAGES_VER=man-pages-5.13
tar -xf "${MANPAGES_VER}.tar.xz"

cd "$MANPAGES_VER"

make            \
        prefix=/usr \
        install
