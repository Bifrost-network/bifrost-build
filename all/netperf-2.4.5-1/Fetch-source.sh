#!/bin/bash

SRC=netperf-2.4.5.tar.gz
DST=/var/spool/src/$SRC
SHA=185ee337fa297e54ef005502b78974bcf78d686d7ef49caa19838f8af580d467

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://github.com/HewlettPackard/netperf/archive/$SRC
