#!/bin/bash

SRC=e2fsprogs-1.42.5.tar.gz
DST=/var/spool/src/$SRC
SHA=af9cd311b65c9a352d5e15365af658515953cdca116a3975bfd4df3ffa716ea3

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.5/$SRC
