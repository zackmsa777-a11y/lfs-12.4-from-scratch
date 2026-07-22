set -e
cd /sources
rm -rf libxcb-1.17.0
tar xf libxcb-1.17.0.tar.xz
cd libxcb-1.17.0
./configure --prefix=/usr --without-doxygen
make
make install
cd /sources
rm -rf libxcb-1.17.0
