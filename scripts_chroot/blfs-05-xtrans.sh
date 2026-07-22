set -e
cd /sources
rm -rf xtrans-1.5.2
tar xf xtrans-1.5.2.tar.xz
cd xtrans-1.5.2
./configure --prefix=/usr
make install
cd /sources
rm -rf xtrans-1.5.2
