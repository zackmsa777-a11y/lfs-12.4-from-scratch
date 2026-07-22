set -e
cd /sources
rm -rf libXi-1.8.3
tar xf libXi-1.8.3.tar.xz
cd libXi-1.8.3
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXi-1.8.3
