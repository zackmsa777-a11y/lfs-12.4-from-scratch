set -e
cd /sources
rm -rf libxshmfence-1.3.3
tar xf libxshmfence-1.3.3.tar.xz
cd libxshmfence-1.3.3
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libxshmfence-1.3.3
