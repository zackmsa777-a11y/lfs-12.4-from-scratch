set -e
cd /sources
rm -rf xorgproto-2024.1
tar xf xorgproto-2024.1.tar.xz
cd xorgproto-2024.1
mkdir build
cd build
meson setup --prefix=/usr -Dbuildtype=release ..
ninja
ninja install
cd /sources
rm -rf xorgproto-2024.1
