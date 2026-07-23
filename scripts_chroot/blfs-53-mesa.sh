set -e
export XORG_PREFIX=/usr
cd /sources
rm -rf mesa-mesa-26.1.3
tar xf mesa-26.1.3.tar.gz
cd mesa-mesa-26.1.3
mkdir build && cd build
meson setup .. \
  --prefix=$XORG_PREFIX \
  --buildtype=release \
  -D platforms=x11 \
  -D gallium-drivers=softpipe \
  -D vulkan-drivers= \
  -D valgrind=disabled \
  -D video-codecs= \
  -D libunwind=disabled \
  -D llvm=disabled \
  -D glx=dri \
  -D gles1=disabled \
  -D gles2=disabled \
  -D osmesa=true
ninja -j17
ninja install
cd /sources
rm -rf mesa-mesa-26.1.3
