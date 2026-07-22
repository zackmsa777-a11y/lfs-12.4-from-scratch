set -e
cd /sources
rm -rf libXtst-1.2.5
tar xf libXtst-1.2.5.tar.xz
cd libXtst-1.2.5
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXtst-1.2.5
