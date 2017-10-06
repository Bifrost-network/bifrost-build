#!/bin/bash

SRC=libnet-1.1.4.tar.gz
DST=/var/spool/src/$SRC
SHA=ac5051a9f3b2e30f5b989df8cf7fe300c9165a0f35e4a679c9c3d1ffa92f3c92

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.sourceforge.net/project/libnet-dev/$SRC
