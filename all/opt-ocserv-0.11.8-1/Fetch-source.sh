#!/bin/bash

SRC=ocserv-0.11.8.tar.xz
DST=/var/spool/src/$SRC
SHA=622005c585380a2341f27fac66140775185ae87e1aa9a68ea6cb8aa10223044c

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k ftp://ftp.infradead.org/pub/ocserv/$SRC
