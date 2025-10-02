#!/bin/bash

source scripts/000_setup.sh

cd "$SOURCES"

LINUX_VER=linux-5.15.80
wget -nc "https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/${LINUX_VER}.tar.xz"
tar -xf "${LINUX_VER}.tar.xz"

cd "$LINUX_VER"

make mrproper
make                            \
        ARCH=${UPC_ARCH}            \
        headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $UPC/usr
