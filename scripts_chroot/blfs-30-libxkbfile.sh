set -e
cd /sources
rm -rf libxkbfile-1.2.0
tar xf libxkbfile-1.2.0.tar.xz
cd libxkbfile-1.2.0
mkdir -p build
meson setup build --prefix=/usr --buildtype=release
ninja -C build
ninja -C build install
cd /sources
rm -rf libxkbfile-1.2.0
