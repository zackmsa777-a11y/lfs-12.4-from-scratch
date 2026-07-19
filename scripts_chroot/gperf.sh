#!/bin/bash
set -e
cd /sources
tar xf gperf-3.3.tar.gz
cd gperf-3.3
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.3
make
make install
cd /sources
