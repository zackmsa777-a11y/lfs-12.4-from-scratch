#!/bin/bash
# LFS 12.4 - Chapter 5: Constructing a Temporary System (cross toolchain)
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
mkdir -p $(dirname $LOG)

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a $LOG; }

step_done() {
  touch $LFS/.stamps/$1
}
already_done() {
  [ -f $LFS/.stamps/$1 ]
}
mkdir -p $LFS/.stamps

cd $SRC

########################################
# Binutils Pass 1
########################################
if ! already_done binutils-pass1; then
  log "=== Binutils Pass 1 ==="
  rm -rf binutils-2.45
  tar xf binutils-2.45.tar.xz
  cd binutils-2.45
  mkdir -v build && cd build
  ../configure --prefix=$LFS/tools \
               --with-sysroot=$LFS \
               --target=$LFS_TGT   \
               --disable-nls       \
               --enable-gprofng=no \
               --disable-werror    \
               --enable-new-dtags  \
               --enable-default-hash-style=gnu 2>&1 | tee -a $LOG
  make 2>&1 | tee -a $LOG
  make install 2>&1 | tee -a $LOG
  cd $SRC
  step_done binutils-pass1
else
  log "Binutils Pass 1 already done, skipping"
fi

########################################
# GCC Pass 1
########################################
if ! already_done gcc-pass1; then
  log "=== GCC Pass 1 ==="
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

  mkdir -v build && cd build

  ../configure                  \
      --target=$LFS_TGT           \
      --prefix=$LFS/tools          \
      --with-glibc-version=2.42    \
      --with-sysroot=$LFS           \
      --with-newlib                  \
      --without-headers               \
      --enable-default-pie             \
      --enable-default-ssp              \
      --disable-nls                      \
      --disable-shared                    \
      --disable-multilib                   \
      --disable-threads                     \
      --disable-libatomic                    \
      --disable-libgomp                       \
      --disable-libquadmath                    \
      --disable-libssp                          \
      --disable-libvtv                           \
      --disable-libstdcxx                         \
      --enable-languages=c,c++ 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make install 2>&1 | tee -a $LOG
  cd $SRC
  step_done gcc-pass1
else
  log "GCC Pass 1 already done, skipping"
fi

########################################
# Linux API Headers
########################################
if ! already_done linux-headers; then
  log "=== Linux API Headers ==="
  rm -rf linux-6.16.1
  tar xf linux-6.16.1.tar.xz
  cd linux-6.16.1
  make mrproper 2>&1 | tee -a $LOG
  make headers 2>&1 | tee -a $LOG
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LFS/usr 2>&1 | tee -a $LOG
  cd $SRC
  step_done linux-headers
else
  log "Linux headers already done, skipping"
fi

########################################
# Glibc
########################################
if ! already_done glibc; then
  log "=== Glibc ==="
  rm -rf glibc-2.42
  tar xf glibc-2.42.tar.xz
  cd glibc-2.42

  case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-linux.so.2 ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64 ;;
  esac

  patch -Np1 -i ../glibc-2.42-fhs-1.patch 2>&1 | tee -a $LOG

  mkdir -v build && cd build

  echo "rootsbindir=/usr/sbin" > configparms

  ../configure                             \
        --prefix=/usr                      \
        --host=$LFS_TGT                    \
        --build=$(../scripts/config.guess)  \
        --enable-kernel=4.19                 \
        --with-headers=$LFS/usr/include       \
        --disable-nscd                         \
        libc_cv_slibdir=/usr/lib 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG

  sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

  log "Sanity check: compiling a test binary..."
  echo 'int main(){}' | $LFS_TGT-gcc -xc -o /tmp/dummy -
  readelf -l /tmp/dummy | grep 'Requesting program interpreter' | tee -a $LOG
  rm -v /tmp/dummy

  cd $SRC
  step_done glibc
else
  log "Glibc already done, skipping"
fi

########################################
# Libstdc++ from GCC
########################################
if ! already_done libstdcxx; then
  log "=== Libstdc++ ==="
  cd gcc-15.2.0
  mkdir -v build-libstdc++ && cd build-libstdc++

  ../libstdc++-v3/configure           \
      --host=$LFS_TGT                 \
      --build=$(../config.guess)      \
      --prefix=/usr                   \
      --disable-multilib               \
      --disable-nls                     \
      --disable-libstdcxx-pch            \
      --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/15.2.0 2>&1 | tee -a $LOG

  make 2>&1 | tee -a $LOG
  make DESTDIR=$LFS install 2>&1 | tee -a $LOG

  rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
  cd $SRC
  step_done libstdcxx
else
  log "Libstdc++ already done, skipping"
fi

log "=== CHAPTER 5 (cross-toolchain) COMPLETE ==="
