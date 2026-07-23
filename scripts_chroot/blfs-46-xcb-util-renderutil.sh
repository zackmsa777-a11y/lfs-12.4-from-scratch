set -e
cd /sources
rm -rf xcb-util-renderutil-0.3.10
tar xf xcb-util-renderutil-0.3.10.tar.xz
cd xcb-util-renderutil-0.3.10
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf xcb-util-renderutil-0.3.10
