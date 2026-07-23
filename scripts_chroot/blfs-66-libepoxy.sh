set -e
cd /sources
rm -rf libepoxy-1.5.10
tar xf libepoxy-1.5.10.tar.xz
cd libepoxy-1.5.10
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja -j17
ninja install
cd /sources
rm -rf libepoxy-1.5.10
