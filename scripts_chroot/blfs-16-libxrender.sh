set -e
cd /sources
rm -rf libXrender-0.9.12
tar xf libXrender-0.9.12.tar.xz
cd libXrender-0.9.12
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXrender-0.9.12
