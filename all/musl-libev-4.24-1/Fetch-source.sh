#!/bin/bash

SRC=libev-4.24.tar.gz
DST=/var/spool/src/$SRC
SHA=73234689577ac4163d3a14148bdd2e3102edee2459b76fc77afd98fc867a3e76

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://dist.schmorp.de/libev/Attic/$SRC
