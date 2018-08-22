#!/bin/bash

SRC=openssl-1.1.0i.tar.gz
DST=/var/spool/src/$SRC
SHA=02329a88963b10ec2c8325703aa1c471a6f989a6c023bec805b111d6a273999c

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC
