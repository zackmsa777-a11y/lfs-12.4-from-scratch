set -e
cd /sources
rm -rf libpthread-stubs-0.5
tar xf libpthread-stubs-0.5.tar.xz
cd libpthread-stubs-0.5
./configure --prefix=/usr
make
make install
cd /sources
rm -rf libpthread-stubs-0.5
