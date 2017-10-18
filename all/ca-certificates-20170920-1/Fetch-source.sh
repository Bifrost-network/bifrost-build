#!/bin/bash

SRC=cacert-2017-09-20.pem
DST=/var/spool/src/$SRC
SHA=b50ee9dc259dac8309b342a3b97cf21aada827a6

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
if [ ! -s "$DST" ]; then
	curl -L -k -o $DST.unverified https://curl.haxx.se/ca/$SRC
	if [ $(sha1sum $DST.unverified|cut -d ' ' -f 1) = $SHA ]; then
		mv $DST.unverified $DST
	else
		rm $DST.unverified
	fi
fi
