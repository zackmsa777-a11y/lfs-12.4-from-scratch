set -e
cd /sources
rm -rf gtk-3.24.50
tar xf gtk-3.24.50.tar.xz
cd gtk-3.24.50
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D man=false \
  -D broadway_backend=true
export LD_LIBRARY_PATH="$PWD/gdk:$PWD/gtk:$LD_LIBRARY_PATH"
ninja -j17
ninja install
cd /sources
rm -rf gtk-3.24.50
