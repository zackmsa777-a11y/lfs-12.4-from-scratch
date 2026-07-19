set -e
cd /sources
tar xf gmp-6.3.0.tar.xz
cd gmp-6.3.0

sed -i '/long long t1;/,+1s/()/(...)/' configure

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0

make
command -v makeinfo >/dev/null 2>&1 && make html || true
make install
command -v makeinfo >/dev/null 2>&1 && make install-html || true

cd /sources
