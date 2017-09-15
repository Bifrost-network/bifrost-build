#!/bin/bash

SRC=libseccomp-2.3.2.tar.gz
DST=/var/spool/src/$SRC
SHA=5cb7d344b77dfe6327a5fcf07ab4bda47ec24d1366ead0c0f304b3c7e7520497

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/seccomp/libseccomp/releases/download/v2.3.2/$SRC
