#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf XML-Parser-2.46.tar.gz
cd XML-Parser-2.46
perl Makefile.PL
make
make install
