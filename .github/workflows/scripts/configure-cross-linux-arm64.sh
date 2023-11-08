#!/usr/bin/env bash

set -euo pipefail

echo "DBG configure TARGET: ${TARGET:-}"
TARGET=${TARGET:-xtensa-softmmu}

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
    --prefix=$PWD/install/qemu \
    --target-list=$TARGET \
    --with-pkgversion="esp_13.1.1_20231107" \
|| { cat meson-logs/meson-log.txt && false; }
