#!/usr/bin/env bash

set -euo pipefail

TARGET=${TARGET:-xtensa-softmmu}
VERSION=${VERSION:-dev}

echo DBG0
#find / -name distutils -or -name gdbus-codegen 2>/dev/null || true

#export PATH=$(brew --prefix python)/bin:$PATH
which -a python3
command -v python3
python3 --version
head -n 1 /usr/local/Cellar/glib/2.78.1/bin/gdbus-codegen || true

sed -i='' "s/project('qemu', \['c'\],/project('qemu', \['c', 'objc'\],/" meson.build

sed -i='' "s/common_user_inc = \[\]/common_user_inc = \['include', 'build'\]/" meson.build

PYFIX_FILE=/usr/local/Cellar/glib/2.78.1/share/glib-2.0/codegen/utils.py
if [ -f "${PYFIX_FILE}" ] ; then
    sed -i='' "s/import distutils.version/import packaging/" "${PYFIX_FILE}"
    grep -v "^#" "${PYFIX_FILE}" | head
fi

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


