#!/bin/bash
# Usage: chroot-run.sh /scripts_chroot/somefile.sh
LFS=/app/lfs_build

heal_dev() {
  local dir="$LFS/dev"
  mkdir -p "$dir"
  [ -c "$dir/console" ] || { rm -f "$dir/console"; mknod -m 622 "$dir/console" c 5 1; }
  [ -c "$dir/null" ]    || { rm -f "$dir/null";    mknod -m 666 "$dir/null" c 1 3; }
  [ -c "$dir/zero" ]    || { rm -f "$dir/zero";    mknod -m 666 "$dir/zero" c 1 5; }
  [ -c "$dir/random" ]  || { rm -f "$dir/random";  mknod -m 666 "$dir/random" c 1 8; }
  [ -c "$dir/urandom" ] || { rm -f "$dir/urandom"; mknod -m 666 "$dir/urandom" c 1 9; }
  [ -c "$dir/tty" ]     || { rm -f "$dir/tty";     mknod -m 666 "$dir/tty" c 5 0; }
  [ -L "$dir/fd" ]      || { rm -f "$dir/fd";      ln -s /proc/self/fd "$dir/fd"; }
  [ -L "$dir/stdin" ]   || { rm -f "$dir/stdin";   ln -s /proc/self/fd/0 "$dir/stdin"; }
  [ -L "$dir/stdout" ]  || { rm -f "$dir/stdout";  ln -s /proc/self/fd/1 "$dir/stdout"; }
  [ -L "$dir/stderr" ]  || { rm -f "$dir/stderr";  ln -s /proc/self/fd/2 "$dir/stderr"; }
  [ -L "$LFS/lib64" ]   || { rm -rf "$LFS/lib64";  ln -s lib "$LFS/lib64"; }
  [ -L "$LFS/lib" ]     || { rm -rf "$LFS/lib";    ln -s usr/lib "$LFS/lib"; }
  [ -L "$LFS/bin" ]     || { rm -rf "$LFS/bin";    ln -s usr/bin "$LFS/bin"; }
  [ -L "$LFS/sbin" ]    || { rm -rf "$LFS/sbin";   ln -s usr/sbin "$LFS/sbin"; }
}
heal_dev

SCRIPT="$1"
chroot "$LFS" /usr/bin/env -i \
  HOME=/root \
  TERM="${TERM:-xterm}" \
  PS1='(lfs chroot) \u:\w\$ ' \
  PATH=/usr/bin:/usr/sbin \
  MAKEFLAGS="-j17" \
  TESTSUITEFLAGS="-j17" \
  /usr/bin/bash "$SCRIPT"
exit $?
