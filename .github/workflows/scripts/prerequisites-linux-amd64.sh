#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update \
&& apt-get install -y -q --no-install-recommends \
    build-essential \
    git \
    libgcrypt-dev \
    libglib2.0-dev \
    libpixman-1-dev \
    libslirp-dev \
    ninja-build \
    python3-pip \
    wget \
    zlib1g-dev \
&& :

/usr/bin/pip3 install meson==1.2.3
