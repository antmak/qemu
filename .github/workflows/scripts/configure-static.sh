#!/usr/bin/env bash

set -euo pipefail

TARGET=${TARGET:-xtensa-softmmu}
VERSION=${VERSION:-dev}

# Force enable libiconv. It's a workaround for a transitive dependency of libintl. Disabling with configure options doesn't work. Enable it for consistent.
# (only for MinGW static build)

sed -z -i "s/qemu_ldflags = \[\]/qemu_ldflags = \['-liconv','-Wl,--allow-multiple-definition'\]/g" -- meson.build

echo DBG
./configure --help

./configure \
    --bindir=bin \
    --datadir=share/qemu \
    --disable-capstone \
    --disable-docs \
    --disable-gettext \
    --disable-gtk \
    --disable-qga-vss \
    --disable-user \
    --disable-vnc \
    --enable-gcrypt \
    --enable-iconv \
    --enable-sdl \
    --enable-slirp \
    --extra-cflags=-Werror \
    --prefix=${PWD}/install/qemu \
    --static \
    --target-list=${TARGET} \
    --with-pkgversion="${VERSION}" \
    --with-suffix="" \
|| { cat meson-logs/meson-log.txt && false; }
