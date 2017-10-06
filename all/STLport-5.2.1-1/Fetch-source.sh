#!/bin/bash

SRC=STLport-5.2.1.tar.bz2
DST=/var/spool/src/$SRC
SHA=f067e82736bc0f24646e1cfc59e5f80d67b1f5f66e3d7fb704b62fa5f6a83e41

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/stlport/STLport/STLport-5.2.1/$SRC
