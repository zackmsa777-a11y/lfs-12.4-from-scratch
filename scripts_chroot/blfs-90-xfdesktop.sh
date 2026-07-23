set -e
cd /sources
rm -rf xfdesktop-4.20.1
tar xf xfdesktop-4.20.1.tar.bz2
cd xfdesktop-4.20.1
./configure --prefix=/usr
make -j17
make install
cd /sources
rm -rf xfdesktop-4.20.1
