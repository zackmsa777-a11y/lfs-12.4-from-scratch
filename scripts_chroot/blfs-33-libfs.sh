set -e
cd /sources
rm -rf libFS-1.0.10
tar xf libFS-1.0.10.tar.xz
cd libFS-1.0.10
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libFS-1.0.10
