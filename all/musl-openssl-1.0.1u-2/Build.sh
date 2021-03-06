#!/bin/bash

SRCVER=openssl-1.0.1u
PKG=musl-$SRCVER-2 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install perl-5.10.1-3 || exit 2
pkg_install musl-1.1.16-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR || exit 1
tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER || exit 1
#libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
patch -p0 < $PKGDIR/openssl.pat || exit 1
patch -p0 < $PKGDIR/default_ciphers.pat || exit 1

#########
# Configure
# MAKEDEPPROG=musl-gcc
./Configure linux-elf --prefix=/opt/musl --openssldir=/etc/ssl no-shared no-bf no-cast no-md2 no-mdc2 no-rc2 no-rc4 no-rc5 no-idea no-ripemd no-dso no-jpake no-srp no-ssl2

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
sed 's/-O3/-Os -march=i586/g' Makefile > /tmp/config.$$
cp -f /tmp/config.$$ Makefile
rm -f /tmp/config.$$
sed -i 's/$${LDCMD} $${LDFLAGS} -o/$${LDCMD} $${LDFLAGS} -static -o/g' Makefile.shared

sed -i 's/MAKEDEPPROG=makedepend/MAKEDEPPROG=musl-gcc/' Makefile

#########
# Compile
make depend
LDFLAGS="-static" make
rc=$?
echo Make result: $rc
[ "$rc" = 0 ] || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make INSTALL_PREFIX=$DST install

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/musl/bin/openssl|grep -qs "not a dynamic executable") || exit 1
mkdir -p usr/bin || exit 1
mv opt/musl/bin/openssl usr/bin || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf etc/ssl/man
rm -rf etc/ssl/misc
# rm -rf usr/share usr/man
#[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
