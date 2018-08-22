#!/bin/bash

SRC=libnl-1.1.tar.gz
DST=/var/spool/src/$SRC
SHA=4fc1a182f3afdae0db1c89ef94c3c47dffcc87252676c36951c3b4a6f203f515

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.infradead.org/~tgr/libnl/files/$SRC

