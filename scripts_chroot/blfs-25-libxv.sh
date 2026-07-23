set -e
cd /sources
rm -rf libXv-1.0.13
tar xf libXv-1.0.13.tar.xz
cd libXv-1.0.13
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXv-1.0.13
