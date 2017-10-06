#!/bin/bash

SRC=sysfsutils-2.1.0.tar.gz
DST=/var/spool/src/$SRC
SHA=cc8732f44dcbc6293c2b04e3c3340de2451043ada31586e0e945a0732237b8f9

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/linux-diag/sysfsutils/2.1.0/$SRC
