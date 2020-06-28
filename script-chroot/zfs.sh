#!/bin/bash

echo '[archzfs]' >> /etc/pacman.conf
echo 'Server = http://archzfs.com/$repo/x86_64' >> /etc/pacman.conf
echo 'Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/x86_64' >> /etc/pacman.conf
echo 'Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/x86_64' >> /etc/pacman.conf
pacman-key -r F75D9D76

pacman -Syu zfs-dkms

sed -i $'s/rpool=`\${grub_probe}.*/rpool="zroot"/g' /etc/grub.d/10_linux
sed -i 's/^\(HOOKS=(.*\) filesystems keyboard/\1 keyboard zfs filesystems/g' /etc/mkinitcpio.conf
mkinitcpio -P
