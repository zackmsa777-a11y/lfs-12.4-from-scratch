set -e
cd /sources
rm -rf cairo-1.18.4
tar xf cairo-1.18.4.tar.xz
cd cairo-1.18.4
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja -j17
ninja install
cd /sources
rm -rf cairo-1.18.4
