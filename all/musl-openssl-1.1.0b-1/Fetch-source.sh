#!/bin/bash

SRC=openssl-1.1.0b.tar.gz
DST=/var/spool/src/$SRC
SHA=637b09d0d74e25db6478bac5b92e279f83312cdf98d5572fad47d4bffa89aecf

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC
