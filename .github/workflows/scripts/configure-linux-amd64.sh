#!/usr/bin/env bash

set -euo pipefail

echo "DBG configure TARGET: ${TARGET:-}"
TARGET=${TARGET:-xtensa-softmmu}

echo "DBG configure VERSION: ${VERSION:-}"
VERSION=${VERSION:-dev}

# Building with -Werror only on Linux as that breaks some features detection in meson on macOS.

#FIXME ? disable-docs
./configure \
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
|| { cat meson-logs/meson-log.txt && false; }
