set -e
cd /sources
rm -rf libwnck-43.2
tar xf libwnck-43.2.tar.xz
cd libwnck-43.2
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D introspection=disabled ..
ninja -j17
ninja install
cd /sources
rm -rf libwnck-43.2
