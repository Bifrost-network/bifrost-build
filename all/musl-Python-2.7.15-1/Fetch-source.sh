#!/bin/bash

SRC=Python-2.7.15.tgz
DST=/var/spool/src/$SRC
SHA=33d317775c1a2940c8989ed4306bdf9943569f2db419bce5687803dab6410802

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.python.org/ftp/python/2.7.15/$SRC
