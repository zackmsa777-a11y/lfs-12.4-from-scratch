set -e
cd /sources
rm -rf libdisplay-info-0.3.0
tar xf libdisplay-info-0.3.0.tar.xz
cd libdisplay-info-0.3.0
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja -j17
ninja install
cd /sources
rm -rf libdisplay-info-0.3.0
