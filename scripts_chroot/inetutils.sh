#!/bin/bash
set -e
cd /sources
tar xf inetutils-2.6.tar.xz
cd inetutils-2.6
sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c
./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers    \
            --disable-ifconfig
make
make install
if [ -f /usr/bin/ifconfig ]; then
  mv -v /usr/{,s}bin/ifconfig
fi
cd /sources
