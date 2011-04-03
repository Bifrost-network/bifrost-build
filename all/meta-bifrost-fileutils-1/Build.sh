#!/bin/bash

#
# Non-essential networking support
#

SRCVER=meta-bifrost-fileutils
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
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
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:

#########
# Install into dir under /var/tmp/install
function untar {
    if [ ! -f /var/spool/pkg/$1.tar.gz ]; then
	pkg_build $1
	exit 2
    fi
	tar xvf /var/spool/pkg/$1.tar.gz $2
}
rm -rf "$DST"
mkdir -p "$DST"
cd $DST

untar bzip2-bin-1.0.5-1 ./bin/bzip2
untar bzip2-bin-1.0.5-1 ./bin/bzgrep
untar bzip2-bin-1.0.5-1 ./bin/bzmore
untar bzip2-bin-1.0.5-1 ./bin/bzdiff
ln -s /bin/bzip2 ./bin/bunzip2
ln -s /bin/bzip2 ./bin/bzcat
untar diffutils-3.0-1
untar file-5.04-1
untar findutils-4.4.2-1
untar grep-2.6.3-1
untar gzip-1.4-1
untar less-436-1
untar lsof-4.84-1
untar tar-1.23-1
untar which-2.20-1


#########
# Clean up
cd $DST

function p {
    while read F; do
	basename $F
    done
}

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
