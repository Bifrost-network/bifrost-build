#!/bin/bash

SRC=bison-3.0.5.tar.gz
DST=/var/spool/src/$SRC
SHA=46c7876ed6404068a2a74091568a7575d601c11673cb3ede98086bc61bd2822c

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://ftp.gnu.org/gnu/bison/$SRC
