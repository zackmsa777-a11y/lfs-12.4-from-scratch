set -e
cd /sources
rm -rf xfce4-session-4.20.3
tar xf xfce4-session-4.20.3.tar.bz2
cd xfce4-session-4.20.3
./configure --prefix=/usr --sysconfdir=/etc --disable-legacy-sm
make -j17
make install
cd /sources
rm -rf xfce4-session-4.20.3
