#!/bin/bash

SRC=libgpg-error-1.27.tar.bz2
DST=/var/spool/src/$SRC
SHA=15bc8fd329c93bba587d5607ff1b028bd83a89ae20790ecd1058fd00b02ac186

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://gnupg.org/ftp/gcrypt/libgpg-error/$SRC
