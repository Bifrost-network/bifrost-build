#!/bin/bash

SRC=tcp_wrappers_7.6.tar.gz
DST=/var/spool/src/$SRC
SHA=82bd9584b20f0f3d2a2af9100acd63ddfd9f123aa2546c7be5007550bfbcaa10

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k ftp://ftp.porcupine.org/pub/security/$SRC
