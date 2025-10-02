#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
rm -fR texinfo-6.8
tar -xf texinfo-6.8.tar.xz
cd texinfo-6.8
./configure --prefix=/usr
make
make install
make \
        TEXMF=/usr/share/texmf \
        install-tex
pushd /usr/share/info
rm -v dir
for f in *
do install-info $f dir 2>/dev/null
done
popd

