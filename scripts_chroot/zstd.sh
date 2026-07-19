set -e
cd /sources
tar xf zstd-1.5.7.tar.gz
cd zstd-1.5.7
make prefix=/usr
make prefix=/usr install
rm -v /usr/lib/libzstd.a
cd /sources
