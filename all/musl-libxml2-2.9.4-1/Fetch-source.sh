#!/bin/bash

SRC=libxml2-2.9.4.tar.gz
DST=/var/spool/src/$SRC
SHA=11fdd7d1b234026b7d19a61a2c0f00af1be9ee93220db2c017ab61c3fba8cb2e

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k ftp://xmlsoft.org/libxml2/$SRC
