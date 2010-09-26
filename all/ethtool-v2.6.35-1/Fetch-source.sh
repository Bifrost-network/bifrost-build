#!/bin/bash

V=v2.6.35
VER=ethtool-$V
SRC=ethtool-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 1
    pkg_install git-1.7.1-2 || exit 1
    pkg_install openssh-5.5p1-1 || exit 1
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone http://www.kernel.org/pub/scm/network/ethtool/ethtool.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout $V || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi

