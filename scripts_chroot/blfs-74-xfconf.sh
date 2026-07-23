set -e
cd /sources
rm -rf xfconf-4.20.0
tar xf xfconf-4.20.0.tar.bz2
cd xfconf-4.20.0
./configure --prefix=/usr
make -j17
make install
cd /sources
rm -rf xfconf-4.20.0
