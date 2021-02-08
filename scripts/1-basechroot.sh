#!/bin/sh
#: Configuration
ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.old
echo "$LOCALES" | tr "|" "\n" > /etc/locale.gen
locale-gen
echo "LANG=$(tail -n 1 < /etc/locale.gen | sed "s/\s*$//")" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf
echo Arch > /etc/hostname
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
systemctl enable NetworkManager

yes "$ROOTPASSWORD" | passwd
useradd -m -G wheel "$USERNAME"
yes "$USERPASSWORD" | passwd "$USERNAME"

grub-mkconfig -o /boot/grub/grub.cfg
