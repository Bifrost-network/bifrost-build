#!/bin/bash

SRC=arpwatch-2.1a15.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.ee.lbl.gov/$SRC
