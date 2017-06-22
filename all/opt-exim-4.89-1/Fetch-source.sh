#!/bin/bash

SRC=exim-4.89.tar.bz2
DST=/var/spool/src/$SRC
SHA=402f8f0a498af54c9a2d6f222caf0d7b2cd41b68b3a97fd9a63bea837d43bb03

pkg_install tarmd-1.2-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/$SRC || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/old/$SRC
