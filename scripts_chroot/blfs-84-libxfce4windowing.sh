set -e
cd /sources
rm -rf libxfce4windowing-4.20.4
tar xf libxfce4windowing-4.20.4.tar.bz2
cd libxfce4windowing-4.20.4
./configure --prefix=/usr --sysconfdir=/etc --enable-x11 --disable-debug
make -j17
make install
cd /sources
rm -rf libxfce4windowing-4.20.4
