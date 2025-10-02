#!/bin/bash

# Launch this to run all stage 2 and base scripts

set -u -e -o pipefail

cd stage2
../do-everything.sh
cd ../base
../do-everything.sh
