#!/bin/bash

SRC=wpa_supplicant-2.6.tar.gz
DST=/var/spool/src/$SRC
SHA=6ee8ab895c93fa79897ca61ca33afe8eb8315d3397c074a063c81ee8583a1a0d

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://w1.fi/releases/$SRC
