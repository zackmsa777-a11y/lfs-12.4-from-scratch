set -e
cd /sources
tar xf expect5.45.4.tar.gz
cd expect5.45.4

patch -Np1 -i ../expect-5.45.4-gcc15-1.patch

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --disable-rpath         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

cd /sources
