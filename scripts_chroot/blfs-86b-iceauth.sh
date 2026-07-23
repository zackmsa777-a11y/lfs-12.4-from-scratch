set -e
cd /sources
rm -rf iceauth-1.0.10
tar xf iceauth-1.0.10.tar.xz
cd iceauth-1.0.10
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
make -j17
make install
cd /sources
rm -rf iceauth-1.0.10
