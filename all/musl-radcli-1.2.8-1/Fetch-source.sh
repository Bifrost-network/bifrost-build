#!/bin/bash

SRC=radcli-1.2.8.tar.gz
DST=/var/spool/src/$SRC
SHA=be92d0d2cff0bfa8c56a63f23e7b2689c191ae27cc9aa94fb33774c6b27ac5ca

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/radcli/radcli/releases/download/1.2.8/$SRC
