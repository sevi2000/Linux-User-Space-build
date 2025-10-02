#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf MarkupSafe-2.1.1.tar.gz
cd MarkupSafe-2.1.1
pip3 wheel                \
         -w dist              \
         --no-build-isolation \
         --no-deps            \
         $PWD
pip3 install      \
         --no-index   \
         --no-user    \
         --find-links \
         dist         \
         Markupsafe

