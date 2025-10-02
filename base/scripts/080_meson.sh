#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf meson-0.63.1.tar.gz
cd meson-0.63.1
pip3 wheel \
         -w dist \
         --no-build-isolation \
         --no-deps \
         $PWD
pip3 install \
         --no-index \
         --find-links \
         dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
