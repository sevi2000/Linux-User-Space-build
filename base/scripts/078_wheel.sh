#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf wheel-0.37.1.tar.gz
cd wheel-0.37.1
pip3 install --no-index $PWD
