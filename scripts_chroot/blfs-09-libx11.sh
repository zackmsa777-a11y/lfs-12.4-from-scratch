set -e
cd /sources
rm -rf libX11-1.8.13
tar xf libX11-1.8.13.tar.xz
cd libX11-1.8.13
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libX11-1.8.13
