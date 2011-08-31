#!/bin/bash

V=0.6.3
VER=lxc-$V
SRC=lxc-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://lxc.git.sourceforge.net/gitroot/lxc/lxc $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout lxc_0_6_3 || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
