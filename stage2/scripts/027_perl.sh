#!/bin/bash

source scripts/000_stage2.sh

cd $SOURCES/

PERL_VER=perl-5.36.0
tar -xf "${PERL_VER}.tar.xz"

cd "$PERL_VER"

sh Configure -des                                        \
                 -Dprefix=/usr                               \
                 -Dvendorprefix=/usr                         \
                 -Dprivlib=/usr/lib/perl5/5.36/core_perl     \
                 -Darchlib=/usr/lib/perl5/5.36/core_perl     \
                 -Dsitelib=/usr/lib/perl5/5.36/site_perl     \
                 -Dsitearch=/usr/lib/perl5/5.36/site_perl    \
                 -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl \
                 -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl
make
make install
