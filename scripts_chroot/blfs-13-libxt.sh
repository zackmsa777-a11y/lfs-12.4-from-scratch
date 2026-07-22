set -e
cd /sources
rm -rf libXt-1.3.1
tar xf libXt-1.3.1.tar.xz
cd libXt-1.3.1
./configure --prefix=/usr --disable-static --sysconfdir=/etc --with-appdefaultdir=/etc/X11/app-defaults
make
make install
cd /sources
rm -rf libXt-1.3.1
