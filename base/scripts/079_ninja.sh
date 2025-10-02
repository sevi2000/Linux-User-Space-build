#!/bin/bash

source scripts/000_base.sh

cd $SOURCES
tar -xf ninja-1.11.0.tar.gz
cd ninja-1.11.0
python3 configure.py --bootstrap
install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
