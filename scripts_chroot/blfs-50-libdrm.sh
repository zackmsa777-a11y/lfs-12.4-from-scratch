set -e
cd /sources
rm -rf libdrm-2.4.134
tar xf libdrm-2.4.134.tar.xz
cd libdrm-2.4.134
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D udev=true -D valgrind=disabled ..
ninja
ninja install
cd /sources
rm -rf libdrm-2.4.134
