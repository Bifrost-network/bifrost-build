#!/bin/bash

SRC=dhcpcd-4.0.15.tar.bz2
DST=/var/spool/src/$SRC
SHA=79a8d5bd4e2316de163c91130eb53d31cdea5b0c11be020569036adb564735bc

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://roy.marples.name/downloads/dhcpcd/$SRC
