set -e
cd /sources
rm -rf libXpresent-1.0.2
tar xf libXpresent-1.0.2.tar.xz
cd libXpresent-1.0.2
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXpresent-1.0.2
