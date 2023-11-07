#!/usr/bin/env bash

# replace libgcrypt method to 'pkg-config'
sed -z -i "s/\(.*dependency('libgcrypt'.*method: '\)config-tool\('.*\)/\1pkg-config\2/g" -- meson.build

./configure \
    --prefix=$PWD/install/qemu \
    --target-list=xtensa-softmmu \
    --with-pkgversion="esp_13.1.1_20231107" \
    --enable-gcrypt \
    --enable-slirp \
    --disable-user \
    --disable-capstone \
    --disable-vnc \
    --disable-sdl \
    --disable-docs \
    --disable-gtk \
    --cross-prefix=aarch64-linux-gnu- \
&& :


    #(cat meson-logs/meson-log.txt && false)
