set -e
cd /sources
rm -rf pcre2-10.45
tar xf pcre2-10.45.tar.bz2
cd pcre2-10.45
./configure --prefix=/usr \
  --docdir=/usr/share/doc/pcre2-10.45 \
  --enable-unicode \
  --enable-jit \
  --enable-pcre2-16 \
  --enable-pcre2-32 \
  --enable-pcre2grep-libz \
  --enable-pcre2grep-libbz2 \
  --disable-static
make -j17
make install
cd /sources
rm -rf pcre2-10.45
