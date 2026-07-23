set -e
cd /sources
rm -rf fribidi-1.0.16
tar xf fribidi-1.0.16.tar.xz
cd fribidi-1.0.16
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja -j17
ninja install
cd /sources
rm -rf fribidi-1.0.16
