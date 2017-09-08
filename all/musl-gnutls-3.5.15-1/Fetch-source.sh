#!/bin/bash

SRC=gnutls-3.5.15.tar.xz
DST=/var/spool/src/$SRC
SHA=0c24f6021a9fafb146aead280dff3ded7235d60de9f5f53ab8fd09904e052d35

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/$SRC
