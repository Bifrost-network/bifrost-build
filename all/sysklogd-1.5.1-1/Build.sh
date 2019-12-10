#!/bin/bash

SRCVER=sysklogd-1.5.1
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed "$1" $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
# Compile against musl:
pkg_install musl-1.1.18-1 || exit 2 
pkg_install musl-kernel-headers-4.5.0-2 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR) || exit 1
tar xf $SRC || exit 1

#########
# Patch
cd $BUILDDIR
libtool_fix-1
#patch -p1 < $PKGDIR/sysklogd-1.4.1-bifrost.pat
patch -p0 < $PKGDIR/makefile.pat || exit 1
patch -p0 < $PKGDIR/musl.pat || exit 1

#########
# Configure
#B-configure-1 --prefix=/usr || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
CFLAGS="-Wall -Os" LDFLAGS="-static -s" make syslogd || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "$DST/sbin"
cp -p syslogd "$DST/sbin"

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
strip sbin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
