#!/bin/bash

SRC=musl-1.1.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC
