set -e
cd /sources
rm -rf dbus-1.16.2
tar xf dbus-1.16.2.tar.xz
cd dbus-1.16.2
mkdir build && cd build
meson setup --prefix=/usr \
  --buildtype=release \
  --wrap-mode=nofallback \
  -D systemd=disabled \
  ..
ninja -j17
ninja install
chown -v root:root /usr/libexec/dbus-daemon-launch-helper 2>&1 || true
chmod -v 4750 /usr/libexec/dbus-daemon-launch-helper 2>&1 || true
dbus-uuidgen --ensure
cd /sources
rm -rf dbus-1.16.2
