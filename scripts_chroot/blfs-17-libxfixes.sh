set -e
cd /sources
rm -rf libXfixes-6.0.2
tar xf libXfixes-6.0.2.tar.xz
cd libXfixes-6.0.2
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXfixes-6.0.2
