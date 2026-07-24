set -e
cd /sources
rm -rf xf86-video-dummy-0.4.1
tar xf xf86-video-dummy-0.4.1.tar.xz
cd xf86-video-dummy-0.4.1
./configure --prefix=/usr
make -j17
make install
test -f /usr/lib/xorg/modules/drivers/dummy_drv.so
cd /sources
rm -rf xf86-video-dummy-0.4.1
