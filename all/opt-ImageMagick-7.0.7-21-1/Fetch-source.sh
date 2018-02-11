#!/bin/bash

SRC=7.0.7-21.tar.gz
DST=/var/spool/src/ImageMagick-$SRC
SHA=1fd2f544bc5ec5f229a6b9984c0562fe5194b66474c06b7251104e72749c9f25

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/ImageMagick/ImageMagick/archive/$SRC
