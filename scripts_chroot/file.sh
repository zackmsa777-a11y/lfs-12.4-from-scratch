set -e
cd /sources
tar xf file-5.46.tar.gz
cd file-5.46
./configure --prefix=/usr
make
make install
cd /sources
