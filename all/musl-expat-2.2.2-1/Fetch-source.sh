#!/bin/bash

SRC=expat-2.2.2.tar.bz2
DST=/var/spool/src/$SRC
SHA=02773fc436befa86e72977d586a4d6a77bb5e8bff3ad124c3c31c294443a6423

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://downloads.sourceforge.net/project/expat/expat/2.2.2/$SRC
