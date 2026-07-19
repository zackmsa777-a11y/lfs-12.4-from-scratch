#!/bin/bash
set -e
cd /sources
tar xf gdbm-1.26.tar.gz
cd gdbm-1.26
./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat
make
make install
cd /sources
