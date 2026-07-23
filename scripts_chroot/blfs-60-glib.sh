set -e
cd /sources
rm -rf glib-2.84.4
tar xf glib-2.84.4.tar.xz
cd glib-2.84.4
if [ -e /usr/include/glib-2.0 ]; then rm -rf /usr/include/glib-2.0.old && mv -vf /usr/include/glib-2.0{,.old}; fi
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D introspection=disabled \
  -D glib_debug=disabled \
  -D man-pages=disabled \
  -D sysprof=disabled \
  -D tests=false
ninja -j17
ninja install
cd /sources
rm -rf glib-2.84.4 /usr/include/glib-2.0.old
