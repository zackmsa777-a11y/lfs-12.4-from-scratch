set -e
cd /sources
tar xf mpfr-4.2.2.tar.xz
cd mpfr-4.2.2

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.2
make
command -v makeinfo >/dev/null 2>&1 && make html || true
make install
command -v makeinfo >/dev/null 2>&1 && make install-html || true

cd /sources
