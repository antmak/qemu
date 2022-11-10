FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir/qemu
COPY * ./

RUN ./configure --prefix=/opt/qemu --static --target-list=xtensa-softmmu --extra-cflags=-Werror --enable-debug --disable-strip --disable-user --disable-capstone --disable-vnc --disable-sdl --disable-gtk --enable-gcrypt

