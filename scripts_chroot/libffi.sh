set -e
cd /sources
tar xf libffi-3.5.2.tar.gz
cd libffi-3.5.2
./configure --prefix=/usr    \
            --disable-static \
            --with-gcc-arch=native
make
make install
cd /sources
rm -rf libffi-3.5.2
