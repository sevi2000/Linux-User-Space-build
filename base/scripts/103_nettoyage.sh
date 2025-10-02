#!/bin/bash

# Deletes temporary files
rm -rf /tmp/*

# Deletes static archives
find /usr/lib /usr/libexec -name \*.la -delete

# Deletes bootstrapped GCC
find /usr -depth -name arm-upc-linux-gnu\* | xargs rm -rf
