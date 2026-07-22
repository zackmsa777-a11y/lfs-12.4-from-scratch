set -e
cd /sources
rm -rf libXcomposite-0.4.7
tar xf libXcomposite-0.4.7.tar.xz
cd libXcomposite-0.4.7
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXcomposite-0.4.7
