#!/bin/sh
#: System Clock
timedatectl set-ntp true

#: Partitions
wipefs -a "/dev/$DRIVE"

gdisk "/dev/$DRIVE" < assets/gdisk.txt

mkfs.fat -F32 "/dev/${DRIVE}2"
mkfs.ext4 "/dev/${DRIVE}3"

mount "/dev/${DRIVE}3" /mnt
mkdir -p /mnt/boot/EFI
mount "/dev/${DRIVE}2" /mnt/boot/EFI

#: Base system
pacstrap /mnt base linux linux-firmware grub networkmanager sudo

genfstab -U /mnt >> /mnt/etc/fstab
