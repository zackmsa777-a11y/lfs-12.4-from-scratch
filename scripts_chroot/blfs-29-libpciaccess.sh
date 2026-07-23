set -e
cd /sources
rm -rf libpciaccess-0.19
tar xf libpciaccess-0.19.tar.xz
cd libpciaccess-0.19
mkdir -p build
meson setup build --prefix=/usr --buildtype=release
ninja -C build
ninja -C build install
cd /sources
rm -rf libpciaccess-0.19
