#!/bin/bash

SRC=linux-adtool-1.3.4.tar.gz
DST=/var/spool/src/$SRC
SHA=365a5ed67a6f13b1809243d923b27f69ee169b2fafc5d84c40f7026b7fb3f2b0

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/jelaas/linux-adtool/releases/download/v1.3.4/$SRC
