set -e
cd /sources
tar xf zlib-1.3.1.tar.gz
cd zlib-1.3.1
./configure --prefix=/usr
make
make install
rm -fv /usr/lib/libz.a
cd /sources
