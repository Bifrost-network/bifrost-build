#!/bin/bash

SRC=dovecot-2.2.25.tar.gz
DST=/var/spool/src/$SRC
SHA=404be390ed87688b736f3d7fc84fd7d0ac520ccd94324534133c2818eaf57341

pkg_install tarmd-1.2-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST wget -O- http://www.dovecot.org/releases/2.2/$SRC
