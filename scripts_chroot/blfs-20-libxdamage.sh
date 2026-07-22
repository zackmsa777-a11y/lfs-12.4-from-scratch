set -e
cd /sources
rm -rf libXdamage-1.1.7
tar xf libXdamage-1.1.7.tar.xz
cd libXdamage-1.1.7
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXdamage-1.1.7
