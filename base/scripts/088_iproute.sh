#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf iproute2-5.19.0.tar.xz
cd iproute2-5.19.0
sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8
make NETNS_RUN_DIR=/run/netns
make SBINDIR=/usr/sbin install

