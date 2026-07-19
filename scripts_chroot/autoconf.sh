set -e
cd /sources
tar xf autoconf-2.72.tar.xz
cd autoconf-2.72
./configure --prefix=/usr
make
make install
cd /sources
rm -rf autoconf-2.72
