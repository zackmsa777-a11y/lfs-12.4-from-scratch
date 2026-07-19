set -e
cd /sources
tar xf mpfr-4.2.2.tar.xz
cd mpfr-4.2.2

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.2
make
make html
make install
make install-html

cd /sources
