#!/bin/bash

# Run this once on your PC before stage 1

set -u -e -o pipefail

lsb_release -a | grep -i ubuntu

# uname -a; cmds=(bash ld bison yacc chown diff gawk gcc g++ grep gzip m4 make patch perl python3 sed tar makeinfo xz); for i in ${cmds[@]}; do echo -n "$i: "; "$i" --version | grep . | head -1; done

# TODO Install linux-headers glibc libstdc++ ncurses file
cmds=(bash ld       bison yacc  chown     diff      gawk gcc g++ grep gzip m4 make patch perl python3 sed tar makeinfo xz)
pkgs=(bash binutils bison bison coreutils diffutils gawk gcc g++ grep gzip m4 make patch perl python3 sed tar texinfo  xz-utils)

for i in $( seq 0 $(( ${#cmds[@]} - 1 )) ); do
    ver=$("${cmds[i]}" --version | grep -m1 .)
    if [ "$ver" ]; then
        echo "${cmds[i]} already present: $ver"
    else
        echo "Installing ${cmds[i]} from package ${pkgs[i]}:"
        sudo apt install -y -- "${pkgs[i]}"
    fi
done
