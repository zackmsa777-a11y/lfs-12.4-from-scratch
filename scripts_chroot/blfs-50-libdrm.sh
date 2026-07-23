set -e
cd /sources
rm -rf libdrm-2.4.134
tar xf libdrm-2.4.134.tar.xz
cd libdrm-2.4.134
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D udev=true -D valgrind=disabled ..
ninja -j17
ninja install
test -f /usr/include/xf86drm.h
test -f /usr/include/xf86drmMode.h
cd /sources
rm -rf libdrm-2.4.134
