set -e
cd /sources
rm -rf libxml2-2.14.5
tar xf libxml2-2.14.5.tar.xz
cd libxml2-2.14.5
./configure --prefix=/usr \
  --sysconfdir=/etc \
  --disable-static \
  --with-history \
  PYTHON=/usr/bin/python3 \
  --docdir=/usr/share/doc/libxml2-2.14.5
make -j17
make install
rm -vf /usr/lib/libxml2.la
sed '/libs=/s/xml2.*/xml2"/' -i /usr/bin/xml2-config
cd /sources
rm -rf libxml2-2.14.5
