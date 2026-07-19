set -e
cd /sources
tar xf grep-3.12.tar.xz
cd grep-3.12

sed -i "s/echo/#echo/" src/egrep.sh

./configure --prefix=/usr

make

make install

cd /sources
