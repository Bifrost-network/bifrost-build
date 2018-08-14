#!/bin/bash

SRCVER=frr-5.0.1
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/frr-$SRCVER
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
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install gawk-3.1.8-1 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install musl-readline-6.1-2 || exit 2
pkg_install perl-5.10.1-3 || exit 2
pkg_install musl-1.1.16-1 || exit 2 
pkg_install musl-kernel-headers-4.5.0-1 || exit 2
pkg_install musl-json-c-0.12.1-20160607-1 || exit 2
pkg_install musl-queue-1 || exit 2
pkg_install autoconf-2.65-1 || exit 2
pkg_install automake-1.14.1-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install libtool-2.4-1 || exit 2
pkg_install musl-Python-2.7.15-1 || exit 2
pkg_install bison-3.0.5-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
cp -f $PKGDIR/compat_if.h lib || exit 1

for f in */*h */*c; do
	sed -i 's,<net/if.h>,"compat_if.h",' $f
	sed -i 's,net/ethernet,linux/if_ether,' $f
	sed -i 's,netinet/if_ether,linux/if_ether,' $f
done

#########
# Configure

autoreconf -i || exit 1
PYTHON_LIBS="-lpython2.7" PYTHON_CFLAGS="-I/opt/musl/include/python2.7" \
$PKGDIR/B-configure-3 --prefix=/opt/frr --disable-shared --disable-irdp --enable-static=no --enable-rtadv \
 --enable-vtysh \
 --enable-user=root --enable-group=root --enable-multipath=64 --localstatedir=/var/run \
 --disable-nhrpd \
 --disable-capabilities --disable-doc || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
export PYTHONHOME=/opt/musl
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
mkdir -p $DST/opt/frr/etc/config.flags
mkdir -p $DST/opt/frr/rc.d
echo $PKG > $DST/opt/frr/pkgversion
echo yes > $DST/opt/frr/etc/config.flags/frr
cp -p $PKGDIR/rc.frr $DST/opt/frr/rc.d
cp -p $PKGDIR/README $DST/opt/frr

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/frr/sbin/zebra|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/frr/include opt/frr/lib
strip opt/frr/sbin/*
strip opt/frr/bin/*

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
