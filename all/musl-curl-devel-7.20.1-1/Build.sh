#!/bin/bash

SRCVER=curl-devel-7.20.1
PKG=musl-$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/curl-7.20.1.tar.bz2
BUILDDIR=/var/tmp/src/curl-7.20.1
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install musl-openssl-0.9.8y-1 || exit 2
pkg_install musl-zlib-1.2.7-1 || exit 2
pkg_install musl-0.9.10-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/opt/musl --bindir=/usr/bin --without-ca-bundle --with-ca-path=/etc/ssl/certs || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
chmod +x $DST/usr/bin/curl-config

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -f usr/bin/curl
rm -rf opt/musl/share
#[ -d bin ] && strip bin/*
#[ -d usr/bin ] && strip usr/bin/*

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
