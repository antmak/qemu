#!/usr/bin/env bash

set -euo pipefail

TARGET=${TARGET:-xtensa-softmmu}
VERSION=${VERSION:-dev}

echo DBG
./configure --help

# Building with -Werror only on Linux as that breaks some features detection in meson on macOS.
# Defining --bindir, --datadir, etc - to have the same directory tree on Linux and Windows
#   also adding --with-suffix="" to avoid doubled "qemu/qemu" path.


#FIXME ? disable-docs
./configure \
    --bindir=bin \
    --datadir=share/qemu \
    --disable-capstone \
    --disable-docs \
    --disable-gtk \
    --disable-sdl \
    --disable-user \
    --disable-vnc \
    --enable-gcrypt \
    --enable-slirp \
    --extra-cflags=-Werror \
    --prefix=${PWD}/install/qemu \
    --target-list=${TARGET} \
    --with-pkgversion="${VERSION}" \
    --with-suffix="" \
|| { cat meson-logs/meson-log.txt && false; }
