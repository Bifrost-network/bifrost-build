#!/bin/bash

SRC=gnu-efi_3.0w.orig.tar.gz
DST=/var/spool/src/$SRC
SHA=31bbc46eed17e08c48cfbf72947350c92e96c23cc6272f4bf3d7cd1a88a4e94f

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.sourceforge.net/project/gnu-efi/$SRC
