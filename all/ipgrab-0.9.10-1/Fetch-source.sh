#!/bin/bash

SRC=ipgrab-0.9.10.tar.gz
DST=/var/spool/src/$SRC
SHA=7b0c73321d3fa129cbfa1f175114ed766e5752039e217e2b4130bddb448bbea6

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.sourceforge.net/project/ipgrab/ipgrab/0.9.10/$SRC
