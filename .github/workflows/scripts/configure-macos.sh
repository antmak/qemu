#!/usr/bin/env bash

set -euo pipefail

TARGET=${TARGET:-xtensa-softmmu}
VERSION=${VERSION:-dev}

sed -i='' "s/project('qemu', \['c'\],/project('qemu', \['c', 'objc'\],/" meson.build

# workaround for some headers
sed -i='' "s/common_user_inc = \[\]/common_user_inc = \['include', 'build'\]/" meson.build

echo DBG
./configure --help

./configure \
    --bindir=bin \
    --datadir=share/qemu \
    --disable-capstone \
    --disable-cocoa \
    --disable-coreaudio \
    --disable-docs \
    --disable-sdl \
    --disable-user \
    --disable-vnc \
    --enable-gcrypt \
    --enable-slirp \
    --prefix=$PWD/install/qemu \
    --python=python3 \
    --target-list=${TARGET} \
    --with-pkgversion="${VERSION}" \
    --with-suffix="" \
|| { cat meson-logs/meson-log.txt && false; }
