set -e
cd /sources
tar xf bc-7.0.3.tar.xz
cd bc-7.0.3
CC='gcc -std=c99' ./configure --prefix=/usr -G -O3 -r
make
make install
cd /sources
