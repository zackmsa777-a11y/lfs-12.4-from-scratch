set -e
cd /sources
rm -rf libXft-2.3.9
tar xf libXft-2.3.9.tar.xz
cd libXft-2.3.9
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXft-2.3.9
