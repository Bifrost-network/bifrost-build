#!/bin/bash

SRC=iptables-1.6.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.iptables.org/projects/iptables/files/$SRC
