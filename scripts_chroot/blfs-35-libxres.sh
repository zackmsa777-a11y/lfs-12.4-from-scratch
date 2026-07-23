set -e
cd /sources
rm -rf libXres-1.2.3
tar xf libXres-1.2.3.tar.xz
cd libXres-1.2.3
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXres-1.2.3
