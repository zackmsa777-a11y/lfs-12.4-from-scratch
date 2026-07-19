set -e
cd /sources
tar xf mpc-1.3.1.tar.gz
cd mpc-1.3.1
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1
make
command -v makeinfo >/dev/null 2>&1 && make html || true
make install
command -v makeinfo >/dev/null 2>&1 && make install-html || true
cd /sources
