set -e
cd /sources
rm -rf libXdmcp-1.1.5
tar xf libXdmcp-1.1.5.tar.xz
cd libXdmcp-1.1.5
./configure --prefix=/usr --disable-static
make
make install
cd /sources
rm -rf libXdmcp-1.1.5
