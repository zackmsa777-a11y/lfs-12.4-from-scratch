set -e
cd /sources
rm -rf libXScrnSaver-1.2.5
tar xf libXScrnSaver-1.2.5.tar.xz
cd libXScrnSaver-1.2.5
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXScrnSaver-1.2.5
