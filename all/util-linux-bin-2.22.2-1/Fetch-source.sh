#!/bin/bash

SRC=util-linux-2.22.2.tar.bz2
DST=/var/spool/src/$SRC
SHA=f4453349e51e2d55ae32eddf6ce9ba5ecbd391ffa591f95e62f511ccb9458b9a

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/linux/utils/util-linux/v2.22/$SRC

