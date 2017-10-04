#!/bin/bash

SRC=expat-2.0.1.tar.gz
DST=/var/spool/src/$SRC
SHA=b6e5a9979d9652f00fed657357ad41306927f51e526a9b6105633d519f2fc1df

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.sourceforge.net/project/expat/expat/2.0.1/$SRC
