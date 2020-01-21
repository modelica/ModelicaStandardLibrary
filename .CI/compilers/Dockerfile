ARG ARCH
FROM ${ARCH}ubuntu:bionic

WORKDIR /workdir

RUN sed -i s,http://archive.ubuntu.com/ubuntu/,mirror://mirrors.ubuntu.com/mirrors.txt, /etc/apt/sources.list \
 && apt-get update \
 && apt-get -qyy --no-install-recommends install git gcc-4.8 gcc-5 gcc-6 gcc-7 gcc-8 clang-3.9 clang-4.0 clang-5.0 clang-6.0 clang-7 gcc-mingw-w64-x86-64 gcc-mingw-w64-i686 make ca-certificates autoconf automake libtool pkg-config libhdf5-dev \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /workdir/*

RUN apt-get update \
 && apt-get -qyy --install-recommends install gcc-arm-linux-gnueabi \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /workdir/*
