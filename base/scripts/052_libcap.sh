#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf libcap-2.65.tar.xz
cd libcap-2.65
sed -i '/install -m.*STA/d' libcap/Makefile
make prefix=/usr lib=lib
make prefix=/usr lib=lib install
