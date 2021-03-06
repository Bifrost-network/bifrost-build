#!/bin/bash

SRCVER=ocserv-0.11.8
PKG=opt-$SRCVER-2 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.xz
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
# Fetch sources
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 2
pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install xz-5.0.3-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2
pkg_install musl-nettle-3.3-1 || exit 2
pkg_install musl-gnutls-3.5.15-1 || exit 2
pkg_install musl-libev-4.24-1 || exit 2
pkg_install musl-readline-6.1-2 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install musl-gmp-6.1.2-1 || exit 2
pkg_install musl-kernel-headers-4.5.0-2 || exit 2
pkg_install musl-libseccomp-2.3.2-1 || exit 2
pkg_install musl-libnl-3.2.25-1 || exit 2
pkg_install musl-radcli-1.2.8-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.16-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
OPTPREFIX=opt/ocserv
LIBS="-lreadline -lncurses -lhogweed -lgmp" $PKGDIR/B-configure-3 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/$OPTPREFIX
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/ocserv
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.ocserv
chmod +x $OPTDIR/rc.d/rc.ocserv
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR
cp doc/sample.config $OPTDIR/etc/sample.config || exit 1

#########
# Convert man-pages
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
[ -d $OPTPREFIX/bin ] && strip $OPTPREFIX/bin/*
[ -d $OPTPREFIX/sbin ] && strip $OPTPREFIX/sbin/*
[ -d $OPTPREFIX/usr/bin ] && strip $OPTPREFIX/usr/bin/*

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
