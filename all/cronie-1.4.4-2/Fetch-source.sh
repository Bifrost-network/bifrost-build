#!/bin/bash

SRC=cronie-1.4.4.tar.gz
DST=/var/spool/src/$SRC
SHA=8f0ff0dc98582981f93b077527daf87d45dfd0a9f2e9294480d5fbb510317427

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://people.redhat.com/tmraz/cronie/$SRC
