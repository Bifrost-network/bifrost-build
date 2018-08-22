#!/bin/bash

SRC=hostapd-2.6.tar.gz
DST=/var/spool/src/$SRC
SHA=79d7ffc7f70fadd670f21c775899ed10ab86417ba3bd45e33e056b407ef96b9b

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://w1.fi/releases/$SRC
