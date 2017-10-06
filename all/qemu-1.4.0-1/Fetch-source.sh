#!/bin/bash

SRC=qemu-1.4.0.tar.bz2
DST=/var/spool/src/$SRC
SHA=17dbabb2a807e6fdec8256d1c54eb2773902c73442dd14d6ae94615f5566e741

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://wiki.qemu-project.org/download/$SRC
