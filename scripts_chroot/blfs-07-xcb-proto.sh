set -e
cd /sources
rm -rf xcb-proto-1.17.0
tar xf xcb-proto-1.17.0.tar.xz
cd xcb-proto-1.17.0
PYTHON=python3 ./configure --prefix=/usr
make install
cd /sources
rm -rf xcb-proto-1.17.0
