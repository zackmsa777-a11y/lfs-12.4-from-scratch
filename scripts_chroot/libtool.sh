set -e
cd /sources
tar xf libtool-2.5.4.tar.xz
cd libtool-2.5.4

./configure --prefix=/usr

make

make install
rm -fv /usr/lib/libltdl.a

cd /sources
