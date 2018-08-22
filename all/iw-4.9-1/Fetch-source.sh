#!/bin/bash

SRC=iw-4.9.tar.gz
DST=/var/spool/src/$SRC
SHA=2d8b54faf685da47fc58dc8f44d21c60a2207206d1f3e2bf25ae3f2f1dcd0238

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://mirrors.edge.kernel.org/pub/software/network/iw/$SRC

