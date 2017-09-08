#!/bin/bash

SRC=nettle-3.3.tar.gz
DST=/var/spool/src/$SRC
SHA=c86ef2f6c9cec4691bbc833e56d9d09e2d13b572fb99ab27fc45563328a1f926

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://ftp.gnu.org/gnu/nettle/$SRC
