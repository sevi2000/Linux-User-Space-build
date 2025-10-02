#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf systemd-251.tar.gz
cd systemd-251
patch -Np1 -i ../systemd-251-glibc_2.36_fix-1.patch
sed -i                                   \
        -e 's/GROUP="render"/GROUP="video"/' \
        -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in
mkdir -pv build
cd build
meson --prefix=/usr                 \
          --buildtype=release           \
          -Ddefault-dnssec=no           \
          -Dfirstboot=false             \
          -Dinstall-tests=false         \
          -Dldconfig=false              \
          -Dsysusers=false              \
          -Drpmmacrosdir=no             \
          -Dhomed=false                 \
          -Duserdb=false                \
          -Dman=false                   \
          -Dmode=release                \
          -Dpamconfdir=no               \
          -Ddocdir=/usr/share/doc/systemd-251 \
          ..
ninja
ninja install

systemd-machine-id-setup
systemctl preset-all
systemctl disable systemd-sysupdate

