#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf tcl8.6.12-src.tar.gz
cd tcl8.6.12
SRCDIR=$PWD
cd unix
./configure --prefix=/usr           \
                --mandir=/usr/share/man
make

sed -e "s|$SRCDIR/unix|/usr/lib|" \
        -e "s|$SRCDIR|/usr/include|"  \
        -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.3|/usr/lib/tdbc1.1.3|" \
        -e "s|$SRCDIR/pkgs/tdbc1.1.3/generic|/usr/include|"    \
        -e "s|$SRCDIR/pkgs/tdbc1.1.3/library|/usr/lib/tcl8.6|" \
        -e "s|$SRCDIR/pkgs/tdbc1.1.3|/usr/include|"            \
        -i pkgs/tdbc1.1.3/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.2|/usr/lib/itcl4.2.2|" \
        -e "s|$SRCDIR/pkgs/itcl4.2.2/generic|/usr/include|"    \
        -e "s|$SRCDIR/pkgs/itcl4.2.2|/usr/include|"            \
        -i pkgs/itcl4.2.2/itclConfig.sh

unset SRCDIR

make install

make install-private-headers

ln -sfv tclsh8.6 /usr/bin/tclsh

mv /usr/share/man/man3/{Thread,Tcl_Thread}.3
