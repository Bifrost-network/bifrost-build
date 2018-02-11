#!/bin/bash
SRC=jpegsrc.v9.tar.gz
DST=/var/spool/src/$SRC
SHA=577548aca8ca5140872cba68dafa7469ca5761f03d2776e273c1ecac675e1fc9

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.ijg.org/files/$SRC
