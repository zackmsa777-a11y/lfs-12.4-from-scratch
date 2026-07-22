set -e
cd /sources
rm -rf util-macros-1.20.1
tar xf util-macros-1.20.1.tar.xz
cd util-macros-1.20.1
./configure --prefix=/usr
make install
cd /sources
rm -rf util-macros-1.20.1
