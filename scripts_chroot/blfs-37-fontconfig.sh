set -e
cd /sources
rm -rf fontconfig-2.15.0
tar xf fontconfig-2.15.0.tar.xz
cd fontconfig-2.15.0
./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-docs \
    --docdir=/usr/share/doc/fontconfig-2.15.0
make
make install
cd /sources
rm -rf fontconfig-2.15.0
