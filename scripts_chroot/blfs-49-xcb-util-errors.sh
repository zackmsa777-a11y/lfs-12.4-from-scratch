set -e
cd /sources
rm -rf xcb-util-errors-1.0.1
tar xf xcb-util-errors-1.0.1.tar.xz
cd xcb-util-errors-1.0.1
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf xcb-util-errors-1.0.1
