#!/bin/bash

SRC=exim-4.90.1.tar.bz2
DST=/var/spool/src/$SRC
SHA=d63a8637e39412e3c979f3196b7f5243dcf2d370542ea6346e53b50c378f7280

pkg_install tarmd-1.2-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/$SRC || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/old/$SRC
