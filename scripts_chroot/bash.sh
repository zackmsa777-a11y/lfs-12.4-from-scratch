set -e
cd /sources
tar xf bash-5.3.tar.gz
cd bash-5.3

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.3

make

make install

cd /sources
