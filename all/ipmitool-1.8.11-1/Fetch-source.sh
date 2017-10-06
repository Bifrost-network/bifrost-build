#!/bin/bash

SRC=ipmitool-1.8.11.tar.gz
DST=/var/spool/src/$SRC
SHA=3079f596772fe1e586d02abd75e28b12e57998cfe1e7bcc7c56bc3d23294b7df

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/ipmitool/ipmitool/1.8.11/$SRC
