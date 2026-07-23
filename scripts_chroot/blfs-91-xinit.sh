set -e
cd /sources
rm -rf xinit-1.4.4
tar xf xinit-1.4.4.tar.xz
cd xinit-1.4.4
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static --with-xinitdir=/etc/X11/app-defaults
make -j17
make install
ldconfig
cd /sources
rm -rf xinit-1.4.4
