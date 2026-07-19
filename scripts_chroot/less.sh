#!/bin/bash
set -e
cd /sources
tar xf less-679.tar.gz
cd less-679
./configure --prefix=/usr --sysconfdir=/etc
make
make install
cd /sources
