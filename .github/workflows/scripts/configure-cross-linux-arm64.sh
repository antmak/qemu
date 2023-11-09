#!/usr/bin/env bash

set -euo pipefail

echo "DBG configure TARGET: ${TARGET:-}"
TARGET=${TARGET:-xtensa-softmmu}

echo "DBG configure VERSION: ${VERSION:-}"
VERSION=${VERSION:-dev}

# replace libgcrypt method to 'pkg-config'
sed -z -i "s/\(.*dependency('libgcrypt'.*method: '\)config-tool\('.*\)/\1pkg-config\2/g" -- meson.build

./configure \
    --cross-prefix=aarch64-linux-gnu- \
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
