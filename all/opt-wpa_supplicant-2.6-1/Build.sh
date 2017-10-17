#!/bin/bash

SRCVER=wpa_supplicant-2.6
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
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
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install musl-openssl-1.0.1u-2 || exit 2
pkg_install musl-readline-6.1-2 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install musl-kernel-headers-4.5.0-2 || exit 2
pkg_install musl-libnl-3.2.25-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2

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
patch -p1 < $PKGDIR/rebased-v2.6-0001-hostapd-Avoid-key-reinstallation-in-FT-handshake.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0002-Prevent-reinstallation-of-an-already-in-use-group-ke.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0003-Extend-protection-of-GTK-IGTK-reinstallation-of-WNM-.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0004-Prevent-installation-of-an-all-zero-TK.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0005-Fix-PTK-rekeying-to-generate-a-new-ANonce.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0006-TDLS-Reject-TPK-TK-reconfiguration.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0007-WNM-Ignore-WNM-Sleep-Mode-Response-without-pending-r.patch || exit 1
patch -p1 < $PKGDIR/rebased-v2.6-0008-FT-Do-not-allow-multiple-Reassociation-Response-fram.patch || exit 1

#########
# Configure
OPTPREFIX=opt/$PKG
#B-configure-3 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
cd $BUILDDIR/wpa_supplicant || exit 1
cp $PKGDIR/config .config
make V=1 BINDIR=/opt/wpa_supplicant/bin LIBDIR=/opt/wpa_supplicant/lib || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST BINDIR=/opt/wpa_supplicant/bin LIBDIR=/opt/wpa_supplicant/lib
OPTDIR=$DST/opt/wpa_supplicant
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.data
mkdir -p $OPTDIR/rc.d
echo $PKG > $OPTDIR/etc/pkgversion
cp $PKGDIR/wpa_supplicant.conf $OPTDIR/etc/wpa_supplicant.conf.sample
cp $PKGDIR/psk.conf $OPTDIR/etc/psk.conf.sample
echo no > $OPTDIR/etc/config.flags/wpa_supplicant
cp -p $PKGDIR/rc.wpa_supplicant $OPTDIR/rc.d/rc.wpa_supplicant
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

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
