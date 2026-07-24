set -e
cd /sources
rm -rf vte-0.80.3
tar xf vte-0.80.3.tar.xz
cd vte-0.80.3
# fast_float subproject needs git to auto-fetch; pre-populate it manually instead
rm -rf subprojects/fast_float
mkdir -p subprojects/fast_float
tar xf /sources/fast_float-6.1.6.tar.gz -C /tmp
cp -r /tmp/fast_float-6.1.6/* subprojects/fast_float/
cp subprojects/packagefiles/fast_float/meson.build subprojects/fast_float/meson.build
rm -rf /tmp/fast_float-6.1.6
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D _systemd=false -D gnutls=false -D vapi=false -D gtk4=false -D docs=false -D icu=false -D gir=false ..
ninja -j17
ninja install
rm -fv /etc/profile.d/vte.* || true
cd /sources
rm -rf vte-0.80.3
