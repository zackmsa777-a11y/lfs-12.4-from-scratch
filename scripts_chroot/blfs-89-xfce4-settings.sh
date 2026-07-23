set -e
cd /sources
rm -rf xfce4-settings-4.20.2
tar xf xfce4-settings-4.20.2.tar.bz2
cd xfce4-settings-4.20.2
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
cd /sources
rm -rf xfce4-settings-4.20.2
