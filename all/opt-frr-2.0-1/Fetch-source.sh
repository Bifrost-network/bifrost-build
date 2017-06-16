#!/bin/bash

SRC=frr-2.0.tar.gz
DST=/var/spool/src/$SRC
SHA=c584785e81ee0d357d93d735e0f01626f422c65cc35484f8f0ca5867761c4b99

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/FRRouting/frr/releases/download/frr-2.0/frr-2.0.tar.gz
