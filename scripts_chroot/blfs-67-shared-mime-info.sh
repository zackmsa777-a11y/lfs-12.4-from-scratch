set -e
cd /sources
rm -rf shared-mime-info-2.4
tar xf shared-mime-info-2.4.tar.gz
cd shared-mime-info-2.4
mkdir build && cd build
meson setup --prefix=/usr --buildtype=release -D update-mimedb=true ..
ninja -j17
ninja install
cd /sources
rm -rf shared-mime-info-2.4
