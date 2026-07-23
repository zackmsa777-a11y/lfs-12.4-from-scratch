set -e
cd /sources
rm -rf xcb-util-image-0.4.1
tar xf xcb-util-image-0.4.1.tar.xz
cd xcb-util-image-0.4.1
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf xcb-util-image-0.4.1
