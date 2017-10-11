#!/bin/bash

SRC=util-linux-2.26.2.tar.gz
DST=/var/spool/src/$SRC
SHA=c8f7f71bd9a6cd1ade6df15d352f2ac9c576dc95b9d2945f079bb33db3eeb3fb

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/linux/utils/util-linux/v2.26/$SRC
