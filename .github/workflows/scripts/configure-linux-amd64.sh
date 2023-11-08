#!/usr/bin/env bash

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
    --prefix=$PWD/install/qemu \
    --target-list=xtensa-softmmu \
    --with-pkgversion="esp_13.1.1_20231107" \
|| { cat meson-logs/meson-log.txt && false; }
