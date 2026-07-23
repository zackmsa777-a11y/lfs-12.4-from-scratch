set -e
export XORG_PREFIX="/usr"
cd /sources
rm -rf xorg-server-21.1.18
tar xf xorg-server-21.1.18.tar.xz
cd xorg-server-21.1.18
mkdir build && cd build
meson setup .. \
  --prefix=$XORG_PREFIX \
  --localstatedir=/var \
  -D glamor=false \
  -D systemd_logind=false \
  -D secure-rpc=false \
  -D suid_wrapper=false \
  -D xephyr=false \
  -D xkb_output_dir=/var/lib/xkb
ninja -j17
ninja install
mkdir -pv /etc/X11/xorg.conf.d
install -v -d -m1777 /tmp/.ICE-unix /tmp/.X11-unix
cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF
cd /sources
rm -rf xorg-server-21.1.18
