#!/bin/bash

SRC=iproute2-4.9.0.tar.gz
DST=/var/spool/src/$SRC
SHA=82f3c693496a3168124ae00f99f29ce9f12d521bba1ffac4192fd8ec7ff64eab

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/linux/utils/net/iproute2/$SRC
