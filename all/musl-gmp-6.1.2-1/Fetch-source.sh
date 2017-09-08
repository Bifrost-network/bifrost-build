#!/bin/bash

SRC=gmp-6.1.2.tar.bz2
DST=/var/spool/src/$SRC
SHA=3e4dafe4a936748a2b398f06adb6b5c2ddd794451ce611a6030b3ef1bfc4c577

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://ftp.gnu.org/gnu/gmp/$SRC
