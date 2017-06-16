#!/bin/bash

SRC=json-c-0.12.1-20160607.tar.gz
DST=/var/spool/src/$SRC
SHA=e77c694dbbd98aa5253379bbbd8c3a5d5ce5160d490985b8cf2763538eb9c1d9

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/json-c/json-c/archive/$SRC
