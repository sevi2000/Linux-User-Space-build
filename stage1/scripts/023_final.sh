#!/bin/bash

source scripts/000_setup.sh

date +"%Y-%m-%d %H:%M:%S" > "$UPC/time.txt"

find "$SOURCES" -mindepth 1 -maxdepth 1 -type d -exec rm -rf -- {} +

cd "$SOURCES"

cp ../023_final_deps/load.txt .
cd "$SOURCES" && grep -v '^#' ./load.txt | wget -nc -i -

cp ../023_final_deps/chroot.sh "$UPC"

# sur le board : créer une nouvelle partition avec cgdisk, éteindre puis démarrer le board, puis configure la partition en ext4 avec mkfs.ext4

# brancher la carte SD à votre ordinateur personnel et transférez les fichiers de votre ordinateur à la carte SD montée dans le répertoire $MNT :

# export MNT=???
# cp -r $SOURCES/ $MNT
# cp -r $UPC/. $MNT
