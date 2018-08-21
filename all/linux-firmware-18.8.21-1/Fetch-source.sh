#!/bin/bash

VER=linux-firmware-18.8.21
SRC=$VER.tar.gz
DST=/var/spool/src/$SRC
SHA=8ad6e682f70a1080400bc0f928ee9353cf7889f493354283706076b56c9f7590

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout c2e0d1420339eead90149be10447ff83ff60b6b3 || exit 1
    rm -rf .git
    cd /tmp
    tar czf - $VER| tarmd $SHA $DST 
    rc=$?
    rm -rf $VER
    [ $rc = 0 ] || exit 1
fi
