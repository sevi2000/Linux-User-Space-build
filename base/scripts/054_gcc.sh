#!/bin/bash

source scripts/000_base.sh

cd /
tar -xvpf /unix-2023/base/054_gcc_deps/gcc-binary.tar.gz

cp -vf /usr/bin/armv7l-unknown-linux-gnueabi-gcc /usr/bin/gcc
cp -vf /usr/bin/armv7l-unknown-linux-gnueabi-gcc-ar /usr/bin/gcc-ar
cp -vf /usr/bin/armv7l-unknown-linux-gnueabi-gcc-nm /usr/bin/gcc-nm
cp -vf /usr/bin/armv7l-unknown-linux-gnueabi-gcc-ranlib /usr/bin/gcc-ranlib
