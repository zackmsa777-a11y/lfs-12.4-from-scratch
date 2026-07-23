set -e
cd /sources
rm -rf libxcvt-0.1.3
tar xf libxcvt-0.1.3.tar.xz
cd libxcvt-0.1.3
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release ..
ninja
ninja install
cd /sources
rm -rf libxcvt-0.1.3
