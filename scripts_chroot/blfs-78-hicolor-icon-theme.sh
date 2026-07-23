set -e
cd /sources
rm -rf hicolor-icon-theme-0.18
tar xf hicolor-icon-theme-0.18.tar.xz
cd hicolor-icon-theme-0.18
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja -j17
ninja install
cd /sources
rm -rf hicolor-icon-theme-0.18
