set -e
cd /sources
tar xf sed-4.9.tar.xz
cd sed-4.9

./configure --prefix=/usr

make
command -v makeinfo >/dev/null 2>&1 && make html || true

make install
if [ -f doc/sed.html ]; then
  install -d -m755           /usr/share/doc/sed-4.9
  install -m644 doc/sed.html /usr/share/doc/sed-4.9
fi

cd /sources
