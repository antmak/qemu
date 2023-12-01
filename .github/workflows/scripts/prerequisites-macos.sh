#!/usr/bin/env bash

set -euo pipefail

brew install \
  ninja \
  libgcrypt \
  glib \
  pixman \
  pkg-config \
&& :

PYFIX_FILE=/usr/local/Cellar/glib/2.78.1/share/glib-2.0/codegen/utils.py
if [ -f "${PYFIX_FILE}" ] ; then
  python3 -m pip install --upgrade pip
  python3 -m pip install packaging
  python3 -m pip freeze

  sed -i='' "s/import distutils.version/import packaging/" "${PYFIX_FILE}"
  grep -v "^#" "${PYFIX_FILE}" | head
fi
