set -e
cd /sources
rm -rf xfce4-terminal-1.2.0
tar xf xfce4-terminal-1.2.0.tar.xz
cd xfce4-terminal-1.2.0
# work around gtk-layer-shell (not built, optional) usage
sed -e '570i #ifdef HAVE_GTK_LAYER_SHELL' \
    -e '574a #endif' \
    -i terminal/terminal-window-dropdown.c || true
mkdir build && cd build
meson setup .. --prefix=/usr --buildtype=release
ninja -j17
ninja install
cd /sources
rm -rf xfce4-terminal-1.2.0
