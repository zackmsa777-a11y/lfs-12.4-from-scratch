set -e
cd /sources
rm -rf xfce4-panel-4.20.5
tar xf xfce4-panel-4.20.5.tar.bz2
cd xfce4-panel-4.20.5
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
cd /sources
rm -rf xfce4-panel-4.20.5
