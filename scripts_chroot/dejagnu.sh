set -e
cd /sources
tar xf dejagnu-1.6.3.tar.gz
cd dejagnu-1.6.3

mkdir -v build
cd       build
../configure --prefix=/usr
command -v makeinfo >/dev/null 2>&1 && makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi || true
command -v makeinfo >/dev/null 2>&1 && makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi || true

make install
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3 2>/dev/null || true

cd /sources
