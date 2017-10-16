#!/bin/bash

SRC=dovecot-2.2.33.1.tar.gz
DST=/var/spool/src/$SRC
SHA=d923e97c9b3841e2993cae42700df4f8fa3be927a4fe86f26ec0d58dbda60cd9

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.dovecot.org/releases/2.2/$SRC
