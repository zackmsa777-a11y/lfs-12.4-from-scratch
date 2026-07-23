set -e
cd /sources
rm -rf libxslt-1.1.43
tar xf libxslt-1.1.43.tar.xz
cd libxslt-1.1.43
./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/libxslt-1.1.43
make -j17
make install
cd /sources
rm -rf libxslt-1.1.43
