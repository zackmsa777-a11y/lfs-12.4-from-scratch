set -e
cd /sources
rm -rf libSM-1.2.6
tar xf libSM-1.2.6.tar.xz
cd libSM-1.2.6
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libSM-1.2.6
