set -e
cd /sources
rm -rf libxfce4util-4.20.1
tar xf libxfce4util-4.20.1.tar.bz2
cd libxfce4util-4.20.1
./configure --prefix=/usr
make -j17
make install
cd /sources
rm -rf libxfce4util-4.20.1
