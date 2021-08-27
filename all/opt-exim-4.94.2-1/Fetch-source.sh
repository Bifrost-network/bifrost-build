#!/bin/bash

SRC=exim-4.94.2.tar.bz2
DST=/var/spool/src/$SRC
SHA=fd91f096a59c8e22a19d1569db7eff7545b0664f983540b2d12c9865489b0b12

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.exim.org/exim4/$SRC
