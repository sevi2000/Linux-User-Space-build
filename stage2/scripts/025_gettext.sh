#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/

GETTEXT_VER=gettext-0.21
tar -xf "${GETTEXT_VER}.tar.xz"
cd "$GETTEXT_VER"

./configure \
        --disable-shared
make
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
