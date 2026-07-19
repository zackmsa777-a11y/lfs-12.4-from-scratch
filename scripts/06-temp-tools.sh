#!/bin/bash
# LFS 12.4 - Chapter 6: Cross Compiling Temporary Tools
set -e
set -o pipefail

export LFS=/app/lfs_build
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=$LFS/tools/bin:$PATH
export CONFIG_SITE=$LFS/usr/share/config.site
unset CFLAGS CXXFLAGS
export MAKEFLAGS="-j17"

SRC=$LFS/sources
LOG=$LFS/build.log

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a $LOG; }
step_done() { touch $LFS/.stamps/$1; }
already_done() { [ -f $LFS/.stamps/$1 ]; }
mkdir -p $LFS/.stamps

cd $SRC

########################################
# M4
########################################
if ! already_done m4; then
  log "=== M4 ==="
  rm -rf m4-1.4.20
  tar xf m4-1.4.20.tar.xz
  cd m4-1.4.20
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done m4
else
  log "M4 already done"
fi

########################################
# Ncurses
########################################
if ! already_done ncurses; then
  log "=== Ncurses ==="
  rm -rf ncurses-6.5-20250809
  tar xf ncurses-6.5-20250809.tgz
  cd ncurses-6.5-20250809
  sed -i s/mawk// configure

  mkdir -v build
  pushd build
    ../configure
    make -C include
    make -C progs tic
  popd

  ./configure --prefix=/usr                \
              --host=$LFS_TGT              \
              --build=$(./config.guess)    \
              --mandir=/usr/share/man      \
              --with-manpage-format=normal \
              --with-shared                \
              --without-normal             \
              --with-cxx-shared            \
              --without-debug              \
              --without-ada                \
              --disable-stripping          \
              --enable-widec 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install 2>&1 | tee -a $LOG

  ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
  sed -e 's/^#if.*XOPEN.*$/#if 1/' -i $LFS/usr/include/curses.h
  cd $SRC
  step_done ncurses
else
  log "Ncurses already done"
fi

########################################
# Bash
########################################
if ! already_done bash; then
  log "=== Bash ==="
  rm -rf bash-5.3
  tar xf bash-5.3.tar.gz
  cd bash-5.3
  ./configure --prefix=/usr                          \
              --build=$(sh support/config.guess)     \
              --host=$LFS_TGT                        \
              --without-bash-malloc                  \
              bash_cv_strtold_broken=no 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  ln -sv bash $LFS/bin/sh
  cd $SRC
  step_done bash
else
  log "Bash already done"
fi

########################################
# Coreutils
########################################
if ! already_done coreutils; then
  log "=== Coreutils ==="
  rm -rf coreutils-9.7
  tar xf coreutils-9.7.tar.xz
  cd coreutils-9.7
  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --enable-install-program=hostname  \
              --enable-no-install-program=kill,uptime \
              gl_cv_macro_MB_CUR_MAX_good=y 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG

  mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
  mkdir -pv $LFS/usr/share/man/man8
  mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
  sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
  cd $SRC
  step_done coreutils
else
  log "Coreutils already done"
fi

########################################
# Diffutils
########################################
if ! already_done diffutils; then
  log "=== Diffutils ==="
  rm -rf diffutils-3.12
  tar xf diffutils-3.12.tar.xz
  cd diffutils-3.12
  gl_cv_func_strcasecmp_works=yes \
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(./build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done diffutils
else
  log "Diffutils already done"
fi

########################################
# File
########################################
if ! already_done file; then
  log "=== File ==="
  rm -rf file-5.46
  tar xf file-5.46.tar.gz
  cd file-5.46
  mkdir -v build
  pushd build
    ../configure --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib
    make
  popd
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess) 2>&1 | tee -a $LOG
  make FILE_COMPILE=$(pwd)/build/src/file 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  rm -v $LFS/usr/lib/libmagic.la
  cd $SRC
  step_done file
else
  log "File already done"
fi

########################################
# Findutils
########################################
if ! already_done findutils; then
  log "=== Findutils ==="
  rm -rf findutils-4.10.0
  tar xf findutils-4.10.0.tar.xz
  cd findutils-4.10.0
  ./configure --prefix=/usr                   \
              --localstatedir=/var/lib/locate \
              --host=$LFS_TGT                 \
              --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done findutils
else
  log "Findutils already done"
fi

########################################
# Gawk
########################################
if ! already_done gawk; then
  log "=== Gawk ==="
  rm -rf gawk-5.3.2
  tar xf gawk-5.3.2.tar.xz
  cd gawk-5.3.2
  sed -i 's/extras//' Makefile.in
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done gawk
else
  log "Gawk already done"
fi

########################################
# Grep
########################################
if ! already_done grep; then
  log "=== Grep ==="
  rm -rf grep-3.12
  tar xf grep-3.12.tar.xz
  cd grep-3.12
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(./build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done grep
else
  log "Grep already done"
fi

########################################
# Gzip
########################################
if ! already_done gzip; then
  log "=== Gzip ==="
  rm -rf gzip-1.14
  tar xf gzip-1.14.tar.xz
  cd gzip-1.14
  ./configure --prefix=/usr --host=$LFS_TGT 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done gzip
else
  log "Gzip already done"
fi

########################################
# Make
########################################
if ! already_done make; then
  log "=== Make ==="
  rm -rf make-4.4.1
  tar xf make-4.4.1.tar.gz
  cd make-4.4.1
  ./configure --prefix=/usr       \
              --without-guile     \
              --host=$LFS_TGT     \
              --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done make
else
  log "Make already done"
fi

########################################
# Patch
########################################
if ! already_done patch; then
  log "=== Patch ==="
  rm -rf patch-2.8
  tar xf patch-2.8.tar.xz
  cd patch-2.8
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done patch
else
  log "Patch already done"
fi

########################################
# Sed
########################################
if ! already_done sed; then
  log "=== Sed ==="
  rm -rf sed-4.9
  tar xf sed-4.9.tar.xz
  cd sed-4.9
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(./build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done sed
else
  log "Sed already done"
fi

########################################
# Tar
########################################
if ! already_done tar; then
  log "=== Tar ==="
  rm -rf tar-1.35
  tar xf tar-1.35.tar.xz
  cd tar-1.35
  ./configure --prefix=/usr --host=$LFS_TGT --build=$(build-aux/config.guess) 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  cd $SRC
  step_done tar
else
  log "Tar already done"
fi

########################################
# Xz
########################################
if ! already_done xz; then
  log "=== Xz ==="
  rm -rf xz-5.8.1
  tar xf xz-5.8.1.tar.xz
  cd xz-5.8.1
  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --disable-static                  \
              --docdir=/usr/share/doc/xz-5.8.1 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  rm -v $LFS/usr/lib/liblzma.la
  cd $SRC
  step_done xz
else
  log "Xz already done"
fi

########################################
# Binutils Pass 2
########################################
if ! already_done binutils-pass2; then
  log "=== Binutils Pass 2 ==="
  rm -rf binutils-2.45
  tar xf binutils-2.45.tar.xz
  cd binutils-2.45
  mkdir -v build
  cd build

  ../configure                   \
      --prefix=/usr                \
      --build=$(../config.guess)    \
      --host=$LFS_TGT                \
      --disable-nls                   \
      --enable-shared                  \
      --enable-gprofng=no                \
      --disable-werror                    \
      --enable-64-bit-bfd                  \
      --enable-new-dtags                    \
      --enable-default-hash-style=gnu 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG
  rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la} 2>/dev/null || true
  cd $SRC
  step_done binutils-pass2
else
  log "Binutils Pass 2 already done"
fi

########################################
# GCC Pass 2
########################################
if ! already_done gcc-pass2; then
  log "=== GCC Pass 2 ==="
  rm -rf gcc-15.2.0
  tar xf gcc-15.2.0.tar.xz
  cd gcc-15.2.0

  tar -xf ../mpfr-4.2.2.tar.xz && mv -v mpfr-4.2.2 mpfr
  tar -xf ../gmp-6.3.0.tar.xz && mv -v gmp-6.3.0 gmp
  tar -xf ../mpc-1.3.1.tar.gz && mv -v mpc-1.3.1 mpc

  case $(uname -m) in
    x86_64)
      sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
    ;;
  esac

  mkdir -v build
  cd build

  ../configure                                       \
      --build=$(../config.guess)                       \
      --host=$LFS_TGT                                   \
      --target=$LFS_TGT                                  \
      LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc            \
      --prefix=/usr                                         \
      --with-build-sysroot=$LFS                              \
      --enable-default-pie                                    \
      --enable-default-ssp                                     \
      --disable-nls                                             \
      --disable-multilib                                         \
      --disable-libatomic                                         \
      --disable-libgomp                                            \
      --disable-libquadmath                                         \
      --disable-libsanitizer                                         \
      --disable-libssp                                                \
      --disable-libvtv                                                 \
      --enable-languages=c,c++ 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG

  ln -sv gcc $LFS/usr/bin/cc
  cd $SRC
  step_done gcc-pass2
else
  log "GCC Pass 2 already done"
fi

log "=== CHAPTER 6 (temporary tools) COMPLETE ==="
