set -e
cd /sources
rm -rf libXvMC-1.0.15
tar xf libXvMC-1.0.15.tar.xz
cd libXvMC-1.0.15
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXvMC-1.0.15
