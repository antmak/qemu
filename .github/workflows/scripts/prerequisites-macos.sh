#!/usr/bin/env bash

set -euo pipefail

brew install \
  glib \
  libgcrypt \
  ninja \
  pixman \
  pkg-config \
&& :

# workaround if deprecated module 'distutils.version' is missing
# https://peps.python.org/pep-0632/#migration-advice
# https://pypi.org/project/looseversion/
PYFIX_FILE=/usr/local/Cellar/glib/2.78.1/share/glib-2.0/codegen/utils.py
if [ -f "${PYFIX_FILE}" ] ; then
  python3 -m pip install --upgrade pip
  python3 -m pip install looseversion

  sed -i='' "s/distutils.version/looseversion/" "${PYFIX_FILE}"
fi

# dbg
command -v python3
python3 --version
python3 -m pip freeze
