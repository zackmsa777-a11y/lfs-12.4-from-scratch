set -e
cd /sources
rm -rf libXxf86dga-1.1.7
tar xf libXxf86dga-1.1.7.tar.xz
cd libXxf86dga-1.1.7
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXxf86dga-1.1.7
