set -e
cd /sources
rm -rf thunar-4.20.4
tar xf thunar-4.20.4.tar.bz2
cd thunar-4.20.4
sed -i 's/\tinstall-systemd_userDATA/\t/' Makefile.in || true
./configure --prefix=/usr --sysconfdir=/etc --docdir=/usr/share/doc/thunar-4.20.4
make -j17
make install
cd /sources
rm -rf thunar-4.20.4
