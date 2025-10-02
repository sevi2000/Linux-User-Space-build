#!/bin/bash

source scripts/000_base.sh

cd "$SOURCES/"

IANAETC_VER=iana-etc-20220812
tar -xf "${IANAETC_VER}.tar.gz"

cd "$IANAETC_VER"

cp services protocols /etc
