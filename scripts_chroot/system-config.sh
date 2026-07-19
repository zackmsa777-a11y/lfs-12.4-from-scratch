set -e

echo "lfs" > /etc/hostname

cat > /etc/hosts << EOF
127.0.0.1 localhost.localdomain localhost
::1       localhost.localdomain localhost ipv6-localhost ipv6-loopback
EOF

cat > /etc/resolv.conf << EOF
domain mydomain.com
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

mkdir -pv /etc/sysconfig
cat > /etc/sysconfig/clock << EOF
UTC=1
CLOCKPARAMS=
EOF

cat > /etc/inittab << EOF
id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

S0:2345:respawn:/sbin/agetty -L 115200 ttyS0 vt100
EOF

cat > /etc/profile << EOF
export LANG=C.UTF-8
EOF

cat > /etc/inputrc << EOF
# Begin /etc/inputrc
set bell-style none
set meta-flag on
set input-meta on
set convert-meta off
set output-meta on
set keymap emacs
\$if mode=emacs
Control-Left: backward-word
Control-Right: forward-word
Control-Delete: kill-word
"\e[3;5~": kill-word
"\e[1;5D": backward-word
"\e[1;5C": forward-word
\$endif
# End /etc/inputrc
EOF

cat > /etc/shells << EOF
/bin/sh
/bin/bash
EOF

echo "root:lfs" | chpasswd
