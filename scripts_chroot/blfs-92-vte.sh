set -e
cd /sources
rm -rf vte-0.80.3
tar xf vte-0.80.3.tar.gz
cd vte-0.80.3
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D _systemd=false -D gnutls=false -D vapi=false -D gtk4=false -D docs=false -D icu=false ..
ninja -j17
ninja install
rm -fv /etc/profile.d/vte.* || true
cd /sources
rm -rf vte-0.80.3
