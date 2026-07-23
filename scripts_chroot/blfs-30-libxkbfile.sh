set -e
cd /sources
rm -rf libxkbfile-1.2.0
tar xf libxkbfile-1.2.0.tar.xz
cd libxkbfile-1.2.0
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libxkbfile-1.2.0
