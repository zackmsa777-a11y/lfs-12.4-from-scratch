set -e
cd /sources
rm -rf libXmu-1.3.1
tar xf libXmu-1.3.1.tar.xz
cd libXmu-1.3.1
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXmu-1.3.1
