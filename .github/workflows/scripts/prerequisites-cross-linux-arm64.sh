#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

EXTRA_APT_SOURCES="
deb [arch=arm64] http://ports.ubuntu.com/ focal main restricted
deb [arch=arm64] http://ports.ubuntu.com/ focal-updates main restricted
deb [arch=arm64] http://ports.ubuntu.com/ focal universe
deb [arch=arm64] http://ports.ubuntu.com/ focal-updates universe
deb [arch=arm64] http://ports.ubuntu.com/ focal multiverse
deb [arch=arm64] http://ports.ubuntu.com/ focal-updates multiverse
deb [arch=arm64] http://ports.ubuntu.com/ focal-backports main restricted universe multiverse
"

dpkg --add-architecture arm64
echo -e "$EXTRA_APT_SOURCES" > /etc/apt/sources.list.d/arm-cross-compile-sources.list
echo DBG1
cat /etc/apt/sources.list.d/arm-cross-compile-sources.list
sed -E -i 's/deb (http|file|mirror)/deb [arch=amd64] \1/' /etc/apt/sources.list
echo DBG2
cat /etc/apt/sources.list | grep -v "^#"
echo DBG3 /etc/apt/apt-mirrors.txt
test -f /etc/apt/apt-mirrors.txt && cat /etc/apt/apt-mirrors.txt | grep -v "^#"

apt-get update \
&& apt-get install -y -q --no-install-recommends \
  git \
  build-essential \
  ninja-build \
  python3-pip \
  crossbuild-essential-arm64 \
  gcc-aarch64-linux-gnu \
  binutils-aarch64-linux-gnu \
  libglib2.0-0:arm64 \
  libglib2.0-dev:arm64 \
  libgpg-error-dev:arm64 \
  libgcrypt20-dev:arm64 \
  libpixman-1-dev:arm64 \
  libslirp-dev:arm64 \
  zlib1g-dev:arm64 \
&& :

# ?
/usr/bin/pip3 install meson
