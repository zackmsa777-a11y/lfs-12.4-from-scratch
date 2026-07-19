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
# symlinks for fd/stdin/stdout/stderr -> /proc/self/fd, done ONCE by
# 07-chroot-prep.sh (or manually). /proc and /sys are NOT mounted (no
# procfs/sysfs available) — most Chapter 8 package builds don't hard-depend
# on them when test suites are skipped (which we always do). If a
# specific package's build/configure hard-requires /proc, handle it
# as a special case in that package's script.
LFS=/app/lfs_build
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
