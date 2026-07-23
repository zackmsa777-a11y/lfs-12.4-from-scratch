set -e
cd /sources
rm -rf xfwm4-4.20.0
tar xf xfwm4-4.20.0.tar.bz2
cd xfwm4-4.20.0
./configure --prefix=/usr
make -j17
make install
cd /sources
rm -rf xfwm4-4.20.0
