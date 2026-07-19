set -e
mkdir -pv /boot
cd /sources
tar xf linux-6.16.1.tar.xz
cd linux-6.16.1

make mrproper
make defconfig

./scripts/config --enable DEVTMPFS
./scripts/config --enable DEVTMPFS_MOUNT
./scripts/config --enable STACKPROTECTOR_STRONG
./scripts/config --disable WERROR
./scripts/config --enable PCI_MSI
./scripts/config --enable IRQ_REMAP
./scripts/config --enable X86_X2APIC
./scripts/config --enable EXT4_FS
./scripts/config --enable ATA
./scripts/config --enable ATA_PIIX
./scripts/config --enable SATA_AHCI
./scripts/config --enable BLK_DEV_SD
./scripts/config --enable SCSI_MOD
./scripts/config --enable BLK_DEV_NVME
./scripts/config --enable VIRTIO
./scripts/config --enable VIRTIO_PCI
./scripts/config --enable VIRTIO_BLK
./scripts/config --enable VIRTIO_NET
./scripts/config --enable SERIAL_8250
./scripts/config --enable SERIAL_8250_CONSOLE
./scripts/config --enable UNIX98_PTYS
./scripts/config --enable PROC_FS
./scripts/config --enable SYSFS
./scripts/config --enable TMPFS
./scripts/config --enable DEVPTS_FS

make olddefconfig
make
make modules_install

cp -v arch/x86/boot/bzImage /boot/vmlinuz-6.16.1-lfs-12.4
cp -v System.map /boot/System.map-6.16.1
cp -v .config /boot/config-6.16.1-lfs-12.4
