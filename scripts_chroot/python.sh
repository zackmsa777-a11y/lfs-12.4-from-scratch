set -e
cd /sources
tar xf Python-3.13.7.tar.xz
cd Python-3.13.7

./configure --prefix=/usr          \
            --enable-shared        \
            --with-system-expat    \
            --without-static-libpython \
            --with-ensurepip=install

make
make install

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

install -v -dm755 /usr/share/doc/python-3.13.7/html

if [ -f ../python-3.13.7-docs-html.tar.bz2 ]; then
  tar --strip-components=1  \
      --no-same-owner       \
      --no-same-permissions \
      -C /usr/share/doc/python-3.13.7/html \
      -xvf ../python-3.13.7-docs-html.tar.bz2
fi

cd /sources
