#!/usr/bin/env bash

set -euo pipefail

brew install \
  ninja \
  libgcrypt \
  glib \
  pixman \
  pkg-config \
&& :
