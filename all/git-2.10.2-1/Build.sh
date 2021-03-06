#!/bin/bash

SRCVER=git-2.10.2
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install musl-openssl-1.0.1u-1 || exit 2
pkg_install musl-zlib-1.2.8-1 || exit 2
pkg_install musl-curl-devel-7.48.0-1 || exit 2
pkg_install musl-1.1.15-1 || exit 2 
pkg_install autoconf-2.65-1 || exit 2
pkg_install automake-1.11.1-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install perl-5.10.1-3 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
autoconf || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
LIBS="-lz -lssl -lcrypto" CXXFLAGS="-march=i586 -Os -g" CFLAGS="-march=i586 -Os -g" LDFLAGS="-static -lssl -lcrypto" ./configure --prefix=/usr --with-curl || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
echo "NO_PERL=YesPlease" >> config.mak
echo "NO_NSEC=YesPlease" >> config.mak
#echo "NO_PTHREADS=YesPlease" >> config.mak
echo "NO_TCLTK=YesPlease" >> config.mak
echo "NO_PYTHON=YesPlease" >> config.mak
echo "NO_GETTEXT=YesPlease" >> config.mak
#echo "NO_=YesPlease" >> config.mak

sed -i 's/-lcurl/-lcurl -lssl -lcrypto/g' Makefile
sed -i 's/xof/xf/g' templates/Makefile

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
NO_INSTALL_HARDLINKS=YES make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm usr/bin/git-shell usr/bin/git-cvsserver usr/libexec/git-core/git-imap-send usr/libexec/git-core/git-shell usr/libexec/git-core/git-daemon
rm usr/libexec/git-core/git-quiltimport usr/libexec/git-core/git-archimport usr/libexec/git-core/git-cvsexportcommit usr/libexec/git-core/git-cvsimport usr/libexec/git-core/git-cvsserver usr/libexec/git-core/git-svn usr/libexec/git-core/git-send-email usr/libexec/git-core/git-instaweb 

rm usr/bin/git-receive-pack && ln -s git usr/bin/git-receive-pack 
rm usr/bin/git-upload-archive && ln -s git usr/bin/git-upload-archive
rm usr/libexec/git-core/git-upload-pack && ln -s /usr/bin/git-upload-pack usr/libexec/git-core/git-upload-pack
rm usr/bin/git && ln -s ../libexec/git-core/git usr/bin/git

strip usr/bin/*
strip usr/libexec/git-core/*

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
