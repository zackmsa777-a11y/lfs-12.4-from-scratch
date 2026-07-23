set -e
cd /sources
rm -rf pixman-0.43.4
tar xf pixman-0.43.4.tar.gz
cd pixman-0.43.4
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja
ninja install
cd /sources
rm -rf pixman-0.43.4
