set -e
cd /sources
rm -rf libXfont2-2.0.7
tar xf libXfont2-2.0.7.tar.xz
cd libXfont2-2.0.7
./configure --prefix=/usr --disable-static --disable-devel-docs
make
make install
cd /sources
rm -rf libXfont2-2.0.7
