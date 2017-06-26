#!/bin/bash

SRC=openvpn-2.4.3.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://swupdate.openvpn.org/community/releases/$SRC
