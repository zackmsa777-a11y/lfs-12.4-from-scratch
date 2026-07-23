set -e
cd /sources
rm -rf tumbler-4.20.0
tar xf tumbler-4.20.0.tar.bz2
cd tumbler-4.20.0
./configure --prefix=/usr --sysconfdir=/etc
make -j17
make install
rm -fv /usr/lib/systemd/user/tumblerd.service || true
cd /sources
rm -rf tumbler-4.20.0
