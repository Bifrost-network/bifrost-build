#!/bin/bash

SRC=dialog-1.1-20100428.tgz
DST=/var/spool/src/$SRC
SHA=bde67490bc540e9e6396728dcf1499261e6b0bc9668360744020ecdb83f811cf

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://invisible-mirror.net/archives/dialog/$SRC


