#!/bin/bash
# LFS 12.4 - Chapter 7: Entering Chroot (adapted for proot since gVisor blocks real mount/chroot)
set -e
export LFS=/app/lfs_build
cd $LFS

mkdir -pv $LFS/{dev,proc,sys,run,tmp} >/dev/null

# 7.5 Creating Directories
mkdir -pv $LFS/{boot,home,mnt,opt,srv}
mkdir -pv $LFS/etc/{opt,sysconfig}
mkdir -pv $LFS/lib/firmware
mkdir -pv $LFS/media/{floppy,cdrom}
mkdir -pv $LFS/usr/{,local/}{include,src}
mkdir -pv $LFS/usr/lib/locale
mkdir -pv $LFS/usr/local/{bin,lib,sbin}
mkdir -pv $LFS/usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv $LFS/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv $LFS/usr/{,local/}share/man/man{1..8}
mkdir -pv $LFS/var/{cache,local,log,mail,opt,spool}
mkdir -pv $LFS/var/lib/{color,misc,locate}
ln -sfv /run $LFS/var/run
ln -sfv /run/lock $LFS/var/lock
install -dv -m 0750 $LFS/root
install -dv -m 1777 $LFS/tmp $LFS/var/tmp
mkdir -pv $LFS/run/lock
chmod 1777 $LFS/tmp $LFS/var/tmp

# 7.6 Creating Essential Files and Symlinks
ln -sfv /proc/self/mounts $LFS/etc/mtab

cat > $LFS/etc/hosts << HOSTSEOF
127.0.0.1  localhost lfs
::1        localhost
HOSTSEOF

cat > $LFS/etc/passwd << "PASSWDEOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
PASSWDEOF

cat > $LFS/etc/group << "GROUPEOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
GROUPEOF

echo "lfs" > $LFS/etc/hostname

mkdir -pv $LFS/dev/pts $LFS/dev/shm
chmod 1777 $LFS/dev/shm

touch $LFS/var/log/btmp $LFS/var/log/lastlog $LFS/var/log/faillog $LFS/var/log/wtmp
chgrp 13 $LFS/var/log/lastlog 2>/dev/null || true
chmod 664 $LFS/var/log/lastlog
chmod 600 $LFS/var/log/btmp

echo "=== CHAPTER 7 PREP COMPLETE ==="
