#!/bin/bash

SRC=dnsmasq-2.79.tar.gz
DST=/var/spool/src/$SRC
SHA=e89a7dfa0be39885cf75cb4412afabe31b2fa227ccb94222c8e610c48d09512e

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.thekelleys.org.uk/dnsmasq/$SRC

