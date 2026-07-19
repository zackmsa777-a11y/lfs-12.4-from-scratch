set -e
cd /sources
tar xf tar-1.35.tar.xz
cd tar-1.35
FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr
make
make install
command -v makeinfo >/dev/null 2>&1 && make -C doc install-html docdir=/usr/share/doc/tar-1.35 || true
cd /sources
