set -e
cd /sources
rm -rf pango-1.56.4
tar xf pango-1.56.4.tar.xz
cd pango-1.56.4
mkdir build && cd build
meson setup --prefix=/usr \
  --buildtype=release \
  --wrap-mode=nofallback \
  -D introspection=disabled \
  ..
ninja -j17
ninja install
cd /sources
rm -rf pango-1.56.4
