#!/bin/bash

set -u -e -o pipefail

#./dependencies.sh

export UPC="$PWD/upc"
export SOURCES="$PWD/sources"

mkdir -pv "$UPC" "$SOURCES"

set +h
umask 022

export LC_ALL=POSIX
export PATH="$UPC/tools/bin:$PATH"
export CONFIG_SITE="$UPC/usr/share/config.site"

export UPC_FLOAT="hard"
export UPC_FPU="vfpv4"
export UPC_TARGET="arm-upc-linux-gnueabihf"
export UPC_ARCH="arm"
export UPC_ARM_ARCH="armv7l"

mkdir -pv "$UPC"/{etc,var} "$UPC"/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  [ -e "$UPC/$i" ] || ln -sfv "usr/$i" "$UPC/$i"
done

mkdir -pv "$UPC/tools"
mkdir -pv "$UPC/tools/$UPC_TARGET"

if nproc; then
  export MAKEFLAGS="-j$(nproc)"
else
  export MAKEFLAGS="-j4"
fi
echo "Using export MAKEFLAGS=$MAKEFLAGS"
