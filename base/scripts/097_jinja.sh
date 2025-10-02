#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf Jinja2-3.1.2.tar.gz
cd Jinja2-3.1.2
pip3 wheel                \
         -w dist              \
         --no-build-isolation \
         --no-deps            \
         $PWD
pip3 install      \
         --no-index   \
         --no-user    \
         --find-links \
         dist Jinja2

