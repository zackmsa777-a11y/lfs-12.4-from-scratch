set -e
cd /sources
rm -rf at-spi2-core-2.56.4
tar xf at-spi2-core-2.56.4.tar.xz
cd at-spi2-core-2.56.4
mkdir build && cd build
meson setup .. \
  --prefix=/usr \
  --buildtype=release \
  -D gtk2_atk_adaptor=false \
  -D systemd_user_dir=/tmp
ninja -j17
ninja install
rm -f /tmp/at-spi-dbus-bus.service
cd /sources
rm -rf at-spi2-core-2.56.4
