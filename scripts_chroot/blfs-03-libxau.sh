set -e
cd /sources
rm -rf libXau-1.0.11
tar xf libXau-1.0.11.tar.xz
cd libXau-1.0.11
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXau-1.0.11
