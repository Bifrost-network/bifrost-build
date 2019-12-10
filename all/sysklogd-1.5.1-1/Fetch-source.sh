#!/bin/bash

SRC=sysklogd-1.5.1.tar.gz
DST=/var/spool/src/$SRC
SHA=5c6fbe8a2b34e2e7e89f6c7092ccfb074e6f0a8f978d35fcb79b07547dfa6ffc

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.infodrom.org/projects/sysklogd/download/$SRC
