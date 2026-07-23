set -e
cd /sources
rm -rf garcon-4.20.0
tar xf garcon-4.20.0.tar.bz2
cd garcon-4.20.0
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
cd /sources
rm -rf garcon-4.20.0
