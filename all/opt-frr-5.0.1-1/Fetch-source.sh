#!/bin/bash

SRC=frr-5.0.1.tar.gz
DST=/var/spool/src/$SRC
SHA=d4d415f38ce13eec3affe5846cbee2b3bfa2aebc7ec780524bf3042668216278

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/FRRouting/frr/archive/$SRC
