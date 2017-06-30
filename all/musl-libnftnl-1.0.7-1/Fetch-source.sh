#!/bin/bash

SRC=libnftnl-1.0.7.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.netfilter.org/pub/libnftnl/$SRC

