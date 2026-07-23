set -e
cd /sources
rm -rf glib-2.84.4
tar xf glib-2.84.4.tar.xz
cd glib-2.84.4
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D introspection=disabled \
  -D glib_debug=disabled \
  -D man-pages=disabled \
  -D sysprof=disabled
ninja -j17
ninja install
cd /sources
rm -rf glib-2.84.4
