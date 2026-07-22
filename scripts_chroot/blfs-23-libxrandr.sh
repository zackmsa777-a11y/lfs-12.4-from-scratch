set -e
cd /sources
rm -rf libXrandr-1.5.5
tar xf libXrandr-1.5.5.tar.xz
cd libXrandr-1.5.5
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXrandr-1.5.5
