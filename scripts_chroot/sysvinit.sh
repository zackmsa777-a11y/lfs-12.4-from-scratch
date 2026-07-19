set -e
cd /sources
tar xf sysvinit-3.14.tar.xz
cd sysvinit-3.14
patch -Np1 -i ../sysvinit-3.14-consolidated-1.patch
make
make install
cd /sources
