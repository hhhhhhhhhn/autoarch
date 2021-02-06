#!/bin/sh
#: System Clock
timedatectl set-ntp true

#: Partitions
dd if=/dev/zero "of=/dev/$DRIVE" bs=1024 count=1 conv=notrunc

gdisk "/dev/$DRIVE" < assets/gdisk.txt

mkfs.fat -F32 "/dev/${DRIVE}2"
mkfs.ext4 "/dev/${DRIVE}3"

mount "/dev/${DRIVE}3" /mnt
mkdir -p /mnt/boot/EFI
mount "/dev/${DRIVE}2" /mnt/boot/EFI

#: Base system
pacstrap /mnt base linux linux-firmware
