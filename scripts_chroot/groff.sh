set -e
cd /sources
tar xf groff-1.23.0.tar.gz
cd groff-1.23.0
PAGE=letter ./configure --prefix=/usr
make
make install
cd /sources
