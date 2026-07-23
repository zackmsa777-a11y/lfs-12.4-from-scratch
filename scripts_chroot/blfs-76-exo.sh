set -e
cd /sources
rm -rf exo-4.20.0
tar xf exo-4.20.0.tar.bz2
cd exo-4.20.0
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
cd /sources
rm -rf exo-4.20.0
