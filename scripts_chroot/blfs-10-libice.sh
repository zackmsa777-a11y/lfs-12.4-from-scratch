set -e
cd /sources
rm -rf libICE-1.1.2
tar xf libICE-1.1.2.tar.xz
cd libICE-1.1.2
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libICE-1.1.2
