set -e
cd /sources
tar xf lz4-1.10.0.tar.gz
cd lz4-1.10.0
make BUILD_STATIC=no PREFIX=/usr
make BUILD_STATIC=no PREFIX=/usr install
cd /sources
