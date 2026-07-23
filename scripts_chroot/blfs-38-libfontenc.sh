set -e
cd /sources
rm -rf libfontenc-1.1.8
tar xf libfontenc-1.1.8.tar.xz
cd libfontenc-1.1.8
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libfontenc-1.1.8
