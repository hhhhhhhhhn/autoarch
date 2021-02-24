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

#: Bootloader
grub-install "--target=$(uname -m | grep 64 >/dev/null && echo x86_64 || echo i386)-efi" --recheck --removable --efi-directory=/boot/EFI --boot-directory=/boot

grub-install --target=i386-pc --recheck --boot-directory=/boot "/dev/$DRIVE"

grub-install --target=i386-pc --recheck --boot-directory=/boot "/dev/${DRIVE}3"

grub-mkconfig -o /boot/grub/grub.cfg
