set -e
cd /sources
rm -rf libpng-1.6.50
tar xf libpng-1.6.50.tar.xz
cd libpng-1.6.50
./configure --prefix=/usr --disable-static
make -j17
make install
mkdir -pv /usr/share/doc/libpng-1.6.50
cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.50 || true
cd /sources
rm -rf libpng-1.6.50
