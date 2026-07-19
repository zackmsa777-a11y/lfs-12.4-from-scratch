set -e
cd /sources
tar xf m4-1.4.20.tar.xz
cd m4-1.4.20
./configure --prefix=/usr
make
make install
cd /sources
