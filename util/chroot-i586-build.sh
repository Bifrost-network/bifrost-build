[ $(id -u) == 0 ] || { printf "\n  Oops, needs wo be run as root due to chroot\n\n"; exit 1; }

BASEDIR=$( dirname $( readlink -f $0 ) )

mkdir -p $BASEDIR/mini-native-i586/var/lib
cp /etc/resolv.conf $BASEDIR/mini-native-i586/etc
cp /etc/hosts $BASEDIR/mini-native-i586/etc
setarch i586 chroot $BASEDIR/mini-native-i586 /bin/chroot-build.sh "${@}"
