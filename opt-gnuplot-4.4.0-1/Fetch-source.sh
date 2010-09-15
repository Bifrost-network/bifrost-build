#!/bin/bash

SRC=gnuplot-4.4.0.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sourceforge.net/projects/gnuplot/files/gnuplot/4.4.0/$SRC
