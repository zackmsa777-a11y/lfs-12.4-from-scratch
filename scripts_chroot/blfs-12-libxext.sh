set -e
cd /sources
rm -rf libXext-1.3.7
tar xf libXext-1.3.7.tar.xz
cd libXext-1.3.7
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXext-1.3.7
