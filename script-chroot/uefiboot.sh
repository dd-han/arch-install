#!/bin/bash

if mount | grep '/boot ' | grep 'vfat' ; then
	echo "boot mounted"
else
	echo 'no boot partition, exit'
	exit 1
fi

grub-install --target=x86_64-efi --efi-directory=${ESP_MOUNT} --bootloader-id=${EFI_NAME}

if which zpool; then
    grub-mkconfig -o /boot/grub/grub.cfg
else
    ZPOOL_VDEV_NAME_PATH=1 grub-mkconfig -o /boot/grub/grub.cfg
fi
