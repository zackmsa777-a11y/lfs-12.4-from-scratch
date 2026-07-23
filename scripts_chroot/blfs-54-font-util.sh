set -e
export XORG_PREFIX="/usr"
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
cd /sources
rm -rf font-util-1.4.1
tar xf font-util-1.4.1.tar.xz
cd font-util-1.4.1
./configure $XORG_CONFIG
make -j17
make install
cd /sources
rm -rf font-util-1.4.1
