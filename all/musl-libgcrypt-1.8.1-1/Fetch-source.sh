#!/bin/bash

SRC=libgcrypt-1.8.1.tar.bz2
DST=/var/spool/src/$SRC
SHA=6c3ef6f9071a83acc8cfb65c2fc2ba0fcb0d552df87fa996969b461652c262fc

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://gnupg.org/ftp/gcrypt/libgcrypt/$SRC

