set -e
cd /sources
tar xf Python-3.13.7.tar.xz
cd Python-3.13.7
# Minimal bootstrap build: only need a working python3 in PATH to satisfy
# glibc's configure-time check. SSL/tk/etc modules will just be skipped
# since their libs aren't built yet in this chroot - that's fine, we don't
# need them for the build process itself.
# --with-ensurepip=no: ensurepip needs zlib (not built yet at this point in
# Chapter 8) to unzip its bundled pip wheel; we don't need pip at all for
# a build-time bootstrap python, so skip it entirely.
./configure --prefix=/usr --disable-test-modules --with-ensurepip=no
make
make install
cd /sources
