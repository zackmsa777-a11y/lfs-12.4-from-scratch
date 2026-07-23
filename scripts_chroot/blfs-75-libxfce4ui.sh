set -e
cd /sources
rm -rf libxfce4ui-4.20.2
tar xf libxfce4ui-4.20.2.tar.bz2
cd libxfce4ui-4.20.2
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
cd /sources
rm -rf libxfce4ui-4.20.2
