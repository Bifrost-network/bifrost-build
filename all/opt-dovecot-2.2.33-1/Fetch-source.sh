#!/bin/bash

SRC=dovecot-2.2.33.tar.gz
DST=/var/spool/src/$SRC
SHA=868d8c60de4088af994a9dcbaa62d884a249017082da8ff4c2459bb56696bb25

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.dovecot.org/releases/2.2/$SRC
