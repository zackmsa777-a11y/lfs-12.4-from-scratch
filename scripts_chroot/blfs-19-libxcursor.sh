set -e
cd /sources
rm -rf libXcursor-1.2.3
tar xf libXcursor-1.2.3.tar.xz
cd libXcursor-1.2.3
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXcursor-1.2.3
