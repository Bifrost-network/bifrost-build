#!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/$SRC
SHA=be9cf8d2af3c552905cbb5b50b9557aefaedfc9f1a985c04b1f057f6fe258852

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/strace/strace/4.5.20/$SRC
