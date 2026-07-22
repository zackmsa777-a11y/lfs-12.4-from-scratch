set -e
cd /sources
rm -rf libXinerama-1.1.6
tar xf libXinerama-1.1.6.tar.xz
cd libXinerama-1.1.6
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXinerama-1.1.6
