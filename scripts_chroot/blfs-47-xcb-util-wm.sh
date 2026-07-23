set -e
cd /sources
rm -rf xcb-util-wm-0.4.2
tar xf xcb-util-wm-0.4.2.tar.xz
cd xcb-util-wm-0.4.2
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf xcb-util-wm-0.4.2
