#!/bin/bash
# Usage: chroot-run.sh /scripts_chroot/somefile.sh
# Runs the given script (path INSIDE the chroot) natively inside the LFS
# chroot via a PLAIN, REAL chroot() syscall.
#
# HISTORY (see memory): we spent a long time on proot (ptrace-based fake
# chroot) because real mount() is blocked by gVisor in this sandbox and we
# assumed real chroot() would be blocked too. It is NOT — only mount() is
# blocked. Confirmed 2026-07-19: plain `chroot $LFS /usr/bin/bash -c ...`
# works perfectly, runs gcc/sed/grep/make/bash with zero corruption —
# unlike proot, which had a ptrace race that intermittently made execve()
# resolve to HOST binaries instead of guest ones (recognizable via errors
# like "libacl.so.1: cannot open shared object file", since only the
# HOST's sed/grep need libacl/libpcre2, not our from-scratch versions).
# Dropping proot entirely eliminates that whole class of flakiness.
#
# Since real mount() is still blocked, /dev is populated with manually
# mknod'd device nodes (null, zero, random, urandom, tty, console) plus
# symlinks for fd/stdin/stdout/stderr -> /proc/self/fd. /proc and /sys are
# NOT mounted (no procfs/sysfs available) — most Chapter 8 package builds
# don't hard-depend on them when test suites are skipped (which we always do).
#
# SELF-HEALING: the sandbox periodically reverts filesystem state between
# sessions, which flattens mknod'd device nodes back into empty regular
# files. This script re-creates them on EVERY invocation (cheap, idempotent,
# no-op if already correct) so the build never silently breaks on that.
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
