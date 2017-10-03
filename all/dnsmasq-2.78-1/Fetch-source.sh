#!/bin/bash

SRC=dnsmasq-2.78.tar.gz
DST=/var/spool/src/$SRC
SHA=b57e10f38ee2d9a37f5f37e07371bcb4cbe2f4f6b55270ff78287be17cb8372c

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.thekelleys.org.uk/dnsmasq/$SRC

