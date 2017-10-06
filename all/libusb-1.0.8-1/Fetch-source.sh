#!/bin/bash

SRC=libusb-1.0.8.tar.bz2
DST=/var/spool/src/$SRC
SHA=10016452e272a35a6576e605d1cdef2764a3147c56cd5a37863c9d948c18188e

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/$SRC
