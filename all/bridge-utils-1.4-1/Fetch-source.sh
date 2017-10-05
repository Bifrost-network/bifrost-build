#!/bin/bash

SRC=bridge-utils-1.4.tar.gz
DST=/var/spool/src/$SRC
SHA=e66664747f23655433d44fb0cff5efde4c7914ed99c29ebf326e498b9b5ee73d

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k $DST http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-1.4/$SRC
