if mount | grep '/boot ' | grep 'vfat' ; then
	echo "boot mounted"
else
	echo 'no boot partition, exit'
	exit 1
fi

grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=ArchLinuxTest
grub-mkconfig -o /boot/grub/grub.cfg
