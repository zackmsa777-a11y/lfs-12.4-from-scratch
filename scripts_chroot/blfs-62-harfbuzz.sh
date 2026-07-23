set -e
cd /sources
rm -rf harfbuzz-11.4.1
tar xf harfbuzz-11.4.1.tar.xz
cd harfbuzz-11.4.1
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D graphite2=enabled
ninja -j17
ninja install
cd /sources
rm -rf harfbuzz-11.4.1
