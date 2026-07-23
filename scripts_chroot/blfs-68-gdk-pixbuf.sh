set -e
cd /sources
rm -rf gdk-pixbuf-2.42.12
tar xf gdk-pixbuf-2.42.12.tar.xz
cd gdk-pixbuf-2.42.12
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D others=enabled \
  -D man=false \
  -D tests=false \
  --wrap-mode=nofallback
ninja -j17
ninja install
cd /sources
rm -rf gdk-pixbuf-2.42.12
