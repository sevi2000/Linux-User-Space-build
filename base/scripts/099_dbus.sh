#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf dbus-1.14.4.tar.xz
cd dbus-1.14.4
./configure --prefix=/usr                        \
                --sysconfdir=/etc                    \
                --localstatedir=/var                 \
                --runstatedir=/run                   \
                --disable-static                     \
                --disable-doxygen-docs               \
                --disable-xml-docs                   \
                --docdir="/usr/share/doc/dbus-1.14.4" \
                --with-system-socket=/run/dbus/system_bus_socket
make
make install
ln -sfv /etc/machine-id /var/lib/dbus

