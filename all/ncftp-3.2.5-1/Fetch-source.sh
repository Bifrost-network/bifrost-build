#!/bin/bash

SRC=ncftp-3.2.5-src.tar.gz
DST=/var/spool/src/$SRC
SHA=e0b749bba3bd5faa2c7a61697444b78d79774e9092b13379c4d27ee2f18bc837

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k ftp://ftp.ncftp.com/ncftp/older_versions/$SRC


