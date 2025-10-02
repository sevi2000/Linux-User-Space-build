#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf Python-3.10.6.tar.xz
cd Python-3.10.6
./configure --prefix=/usr          \
                --enable-shared        \
                --with-system-expat    \
                --with-system-ffi      \
                --enable-optimizations
make
make install
cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF
