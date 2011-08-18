#!/bin/bash

SRC=emacs-23.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/emacs/$SRC || wget -O $DST ftp://ftp.sunet.se/pub/gnu/emacs/emacs-23.2a.tar.gz
