#!/bin/bash

SRC=util-linux-2.20.1.tar.bz2
DST=/var/spool/src/$SRC
SHA=082306ec5d0ca0279778ee4f79b3cef876f2bc6cdf105d7bc50cc6f1de667f3f

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/linux/utils/util-linux/v2.20/$SRC
