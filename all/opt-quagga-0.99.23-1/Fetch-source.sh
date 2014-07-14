#!/bin/bash

SRC=quagga-0.99.23.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/quagga/$SRC
