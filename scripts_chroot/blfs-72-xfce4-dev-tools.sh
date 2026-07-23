set -e
cd /sources
rm -rf xfce4-dev-tools-4.20.0
tar xf xfce4-dev-tools-4.20.0.tar.bz2
cd xfce4-dev-tools-4.20.0
./configure --prefix=/usr
make -j17
make install
cd /sources
rm -rf xfce4-dev-tools-4.20.0
