#!/bin/bash

SRCVER=bash-4.1
PKG=$SRCVER-8 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install musl-readline-6.1-2 || exit 2
pkg_install musl-ncurses-lib-5.7-3 || exit 2
pkg_install musl-0.9.10-1 || exit 2 
pkg_install patch-2.7.1-1 || exit 2
pkg_install bison-2.4.2-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
patch -p0 < $PKGDIR/echo.pat || exit 1

function dopatch {
	echo Apply patch $2
	patch $1 < $PKGDIR/$2
}

dopatch -p0 bash41-001 || exit 1
dopatch -p0 bash41-002 || exit 1
dopatch -p0 bash41-003 || exit 1
dopatch -p0 bash41-004 || exit 1
dopatch -p0 bash41-005 || exit 1
dopatch -p0 bash41-006 || exit 1
dopatch -p0 bash41-007 || exit 1
dopatch -p0 bash41-008 || exit 1
dopatch -p0 bash41-009 || exit 1
dopatch -p0 bash41-010 || exit 1
dopatch -p0 bash41-011 || exit 1
dopatch -p0 bash41-012 || exit 1
dopatch -p0 bash41-013 || exit 1
dopatch -p0 bash41-014 || exit 1
dopatch -p0 bash41-015 || exit 1
dopatch -p0 bash41-016 || exit 1
dopatch -p0 bash41-017 || exit 1

#########
# Configure
B-configure-3 --prefix=/ --enable-static-link || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
##echo '#define WCONTINUED_BROKEN 1' >> config.h
##echo '#undef CAN_REDEFINE_GETENV' >> config.h

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -rf share
rm -f bin/bashbug
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

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
