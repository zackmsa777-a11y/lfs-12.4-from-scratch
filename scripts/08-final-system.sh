#!/bin/bash
# LFS 12.4 - Chapter 8: Building the final system (via real chroot)
#
# HISTORY: originally attempted via proot (ptrace-based fake chroot) because
# we assumed real mount()+chroot() were both blocked by gVisor. Only mount()
# is blocked — plain chroot() works fine. Dropped proot entirely on
# 2026-07-19 after it turned out to have a ptrace race that intermittently
# made execve() resolve to HOST binaries instead of guest ones (symptom:
# "libacl.so.1/libpcre2-8.so.0: cannot open shared object file", since only
# HOST sed/grep need those libs). Real chroot has shown zero such corruption.
# /proc and /sys are NOT available (no procfs/sysfs, real mount() blocked) —
# most package builds are fine without them since we always skip test suites.
#
# NOTE: bison is built early (before glibc) because glibc's configure needs
# it. gettext/perl/texinfo/util-linux are built early (right after libcap,
# before libxcrypt) because the real LFS book's Chapter 7 builds temporary
# versions of these for exactly this reason (libxcrypt's configure hard-
# requires Perl >= 5.14). Our scripts_chroot/{gettext,perl,texinfo,util-linux}.sh
# are already the FULL/final Chapter 8 versions, so we just build them once,
# early — the later run_pkg calls at their "official" book position are
# harmless no-ops (idempotent via .stamps8/).
set -e
set -o pipefail
export LFS=/app/lfs_build
LOG=$LFS/build_ch8.log
mkdir -p $LFS/.stamps8

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a $LOG; }
step_done() { touch $LFS/.stamps8/$1; }
already_done() { [ -f $LFS/.stamps8/$1 ]; }

run_pkg() {
  local name=$1
  if already_done "$name"; then
    log "$name already done"
    return 0
  fi
  local attempt=1
  local max_attempts=3
  while [ $attempt -le $max_attempts ]; do
    log "=== $name (attempt $attempt/$max_attempts) ==="
    bash $LFS/scripts/chroot-run.sh /scripts_chroot/preclean.sh > /tmp/preclean.log 2>&1 || true
    if bash $LFS/scripts/chroot-run.sh "/scripts_chroot/$name.sh" > /tmp/pkgout_$name.log 2>&1; then
      cat /tmp/pkgout_$name.log >> $LOG
      step_done "$name"
      log "=== $name DONE ==="
      return 0
    else
      local rc=$?
      cat /tmp/pkgout_$name.log >> $LOG
      log "$name: FAILED (exit $rc), retrying..."
      attempt=$((attempt+1))
    fi
  done
  log "!!! $name FAILED after $max_attempts attempts — STOPPING BUILD !!!"
  exit 1
}

run_pkg man-pages
run_pkg iana-etc
run_pkg bison
run_pkg python-bootstrap
run_pkg glibc
run_pkg zlib
run_pkg bzip2
run_pkg xz
run_pkg lz4
run_pkg zstd
run_pkg file
run_pkg readline
run_pkg m4
run_pkg bc
run_pkg flex
run_pkg tcl
run_pkg expect
run_pkg dejagnu
run_pkg pkgconf
run_pkg binutils
run_pkg gmp
run_pkg mpfr
run_pkg mpc
run_pkg attr
run_pkg acl
run_pkg libcap
run_pkg gettext
run_pkg perl
run_pkg texinfo
run_pkg util-linux
run_pkg libxcrypt
run_pkg shadow
run_pkg gcc
run_pkg ncurses
run_pkg sed
run_pkg psmisc
run_pkg gettext
run_pkg bison
run_pkg grep
run_pkg bash
run_pkg libtool
run_pkg gdbm
run_pkg gperf
run_pkg expat
run_pkg inetutils
run_pkg less
run_pkg perl
run_pkg xml-parser
run_pkg intltool
run_pkg autoconf
run_pkg automake
run_pkg openssl
run_pkg libelf
run_pkg libffi
run_pkg python
run_pkg flit-core
run_pkg packaging
run_pkg wheel
run_pkg setuptools
run_pkg ninja
run_pkg meson
run_pkg kmod
run_pkg coreutils
run_pkg diffutils
run_pkg gawk
run_pkg findutils
run_pkg groff
run_pkg gzip
run_pkg iproute2
run_pkg kbd
run_pkg libpipeline
run_pkg make
run_pkg patch
run_pkg tar
run_pkg texinfo
run_pkg vim
run_pkg markupsafe
run_pkg jinja2
run_pkg udev
run_pkg man-db
run_pkg procps
run_pkg util-linux
run_pkg e2fsprogs
run_pkg sysklogd
run_pkg sysvinit

log "=== CHAPTER 8 COMPLETE ==="
