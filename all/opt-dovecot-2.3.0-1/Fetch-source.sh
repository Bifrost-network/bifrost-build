#!/bin/bash

SRC=dovecot-2.3.0.tar.gz
DST=/var/spool/src/$SRC
SHA=8af0e418aafbc08ced2eea1805544fde7a3737fd5525b886e6f5ca48305a8fc5

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://www.dovecot.org/releases/2.3/$SRC
