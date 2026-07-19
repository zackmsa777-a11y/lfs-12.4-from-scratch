# Linux From Scratch 12.4 — Full Automated Build System

A complete, from-source Linux distribution (kernel 6.16.1, GCC 15.2.0, Python 3.13.7, ~630 binaries)
built by hand following the [LFS 12.4 book](https://www.linuxfromscratch.org/lfs/view/12.4/), fully
automated into idempotent shell scripts. This was built and **verified to boot successfully under QEMU**
(login, run programs, compile C code, poweroff cleanly).

This repo ships the **build automation**, not a pre-built binary image (a full rootfs is several GB —
too large for a normal git repo). Run it on any real Linux machine (or a `--privileged` Docker container)
with root access and you'll get a bootable disk image in a few hours.

## What's included

- `scripts/05-cross-toolchain.sh` — Chapter 5: cross-compiler (binutils, gcc pass1, linux-headers, glibc, libstdc++)
- `scripts/06-temp-tools.sh` — Chapter 6: temporary tools (m4, ncurses, bash, coreutils, ... gcc pass2)
- `scripts/07-chroot-prep.sh` — Chapter 7: chroot prep (dirs, /etc/passwd, /etc/group, /etc/hosts)
- `scripts/08-final-system.sh` — Chapter 8: the full 79-package final system build, in corrected book order
- `scripts/chroot-run.sh` — reusable harness for running a script inside the chroot
- `scripts_chroot/*.sh` — one script per Chapter 8 package (81 total incl. helpers), all idempotent
- Chapter 9 (system config: bootscripts, /etc/inittab, /etc/fstab, hostname, etc.) and
  Chapter 10 (kernel build w/ QEMU-friendly defconfig) driver scripts described below — see "Chapters 9 & 10" section

## Requirements

- A Linux machine (bare metal, VM, or `docker run --privileged`) with **root** access
- ~20GB free disk space, gcc/make/etc. build toolchain already on the *host* (to bootstrap)
- `wget`/`curl` to fetch LFS source tarballs (see `wget-list.txt` from the LFS book, not included here —
  download the full LFS 12.4 sources package from https://www.linuxfromscratch.org/lfs/view/12.4/wget-list)
- Real `mount()` and `chroot()` — both work fine on a normal Linux host (this was built inside a restricted
  gVisor sandbox where `mount()` was blocked, so our scripts manually `mknod` device nodes instead of
  mounting devtmpfs/proc/sys — you can simplify this on real hardware by just using standard LFS bind-mounts)

## How to build

1. Set `LFS=/mnt/lfs` (or wherever you want the root to live) and download all LFS 12.4 source
   tarballs + patches into `$LFS/sources` (see the official book's wget-list).
2. Run the chapters in order:
   ```bash
   export LFS=/mnt/lfs
   bash scripts/05-cross-toolchain.sh   # builds the cross-toolchain
   bash scripts/06-temp-tools.sh        # builds temp tools
   bash scripts/07-chroot-prep.sh       # preps chroot dirs/files
   chroot "$LFS" /usr/bin/env -i HOME=/root PATH=/usr/bin:/usr/sbin \
       MAKEFLAGS=-j$(nproc) /usr/bin/bash /scripts/08-final-system.sh
   ```
   Each script/package is idempotent — it checks a stamp file before building, so you can safely re-run
   after any interruption.
3. **Known real bugs fixed in these scripts** (not sandbox artifacts — will bite you on real hardware too):
   - MB_LEN_MAX header conflict after GCC pass1 (fixed by replacing `include/limits.h` with the proper
     `limitx.h`+`glimits.h`+`limity.h` composition from the GCC source tree)
   - diffutils cross-compile configure failure — pre-set `gl_cv_func_strcasecmp_works=yes`
   - Chapter 8 doc-generation (`makeinfo`/`make html`) fails in dejagnu/gmp/mpc/mpfr/sed/tar because texinfo
     isn't built until mid-Chapter-8 — all guarded with `command -v makeinfo >/dev/null 2>&1 && ... || true`
   - libxcrypt needs perl≥5.14 before its official position — perl/gettext/texinfo/util-linux/bison are
     moved earlier in the build order (see comments in `08-final-system.sh`)
   - python-bootstrap needs `--with-ensurepip=no`
   - glibc needs `mkdir -pv /usr/lib/locale` before `localedef` calls will work
   - ncurses needs `rm -rf /usr/share/terminfo` before each build attempt (partial-copy corruption on retry)
   - inetutils' ifconfig needs `--disable-ifconfig` (needs `/proc/net/dev`, and iproute2 replaces it anyway)
   - real python build needs `--enable-optimizations` REMOVED (PGO triggers the full test suite, which fails
     in minimal/headless environments)

## Chapters 9 & 10 (system config + kernel) — manual steps

These weren't scripted into standalone files in this repo snapshot, but are simple manual steps per the LFS book:

- **Chapter 9**: install LFS-Bootscripts-20250827, write `/etc/hostname`, `/etc/hosts`, `/etc/resolv.conf`,
  `/etc/inittab` (runlevel 3, `agetty` on tty1-6 **and** `agetty -L 115200 ttyS0 vt100` on ttyS0 if you plan
  to use a serial console e.g. under QEMU `-nographic`), `/etc/fstab`.
- **Chapter 10**: build Linux kernel 6.16.1. Config essentials for a QEMU/virtio guest with no initramfs:
  `DEVTMPFS`, `DEVTMPFS_MOUNT`, `EXT4_FS=y` (built-in, not module), `ATA_PIIX`, `SATA_AHCI`, `BLK_DEV_SD`,
  `SCSI_MOD`, `BLK_DEV_NVME`, `VIRTIO_*` all built-in, `SERIAL_8250` + `SERIAL_8250_CONSOLE`, `UNIX98_PTYS`.
  Then `make -j$(nproc) && make modules_install && cp arch/x86/boot/bzImage /boot/vmlinuz`.
- Set root's password with `chpasswd` — LFS ships an invalid shadow placeholder by default, login will
  fail until you set one explicitly: `echo "root:yourpassword" | chpasswd` (run inside the chroot).

## Building the bootable disk image (no loop device needed)

```bash
mke2fs -t ext4 -d "$LFS" -L lfsroot lfs.img 6G
```
The `-d` flag populates the ext4 image directly from a source directory tree — no loop device required.
Before running this, temporarily move build-scratch dirs (`sources/`, `tools/`, logs, stamp dirs, `scripts/`,
`scripts_chroot/`) out of `$LFS` so the image only contains the real target rootfs, then move them back.

## Booting it

```bash
qemu-system-x86_64 \
  -kernel /path/to/vmlinuz-6.16.1-lfs-12.4 \
  -append "root=/dev/sda rw init=/sbin/init console=ttyS0,115200" \
  -drive file=lfs.img,format=raw,if=ide \
  -m 2G -nographic -no-reboot
```
On real hardware with KVM available, add `-enable-kvm` for massively faster (near-native) emulation
instead of software TCG. Root password is whatever you set via `chpasswd` above.

## Verified working

Booted this exact build to a full login prompt, logged in as root, ran `uname -a`, `df -h`, `free -h`,
compiled and ran a C program with `gcc`, ran `python3`, and did a clean `poweroff` back through SysVinit —
all inside a restricted gVisor sandbox using QEMU TCG software emulation (no KVM, no loop devices, no
`mount()` syscall even available). On a real machine with KVM this will be faster and even more capable
(real `/proc`, `/sys`, full mount support for all the things the sandbox couldn't do).
