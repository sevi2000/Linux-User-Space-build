#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
rm -fR gettext-0.21/
tar -xf gettext-0.21.tar.xz
cd gettext-0.21
./configure --prefix=/usr    \
                --disable-static \
                --docdir="/usr/share/doc/gettext-0.21"
make
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
