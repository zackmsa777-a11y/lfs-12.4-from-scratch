set -e
cd /sources
rm -rf xcb-util-cursor-0.1.6
tar xf xcb-util-cursor-0.1.6.tar.xz
cd xcb-util-cursor-0.1.6
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf xcb-util-cursor-0.1.6
