set -e
cd /sources
rm -rf libXpm-3.5.19
tar xf libXpm-3.5.19.tar.xz
cd libXpm-3.5.19
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXpm-3.5.19
