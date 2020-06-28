#!/bin/bash
mountfail () {
    echo '/mnt not mount, partition disk first'
    exit 1
}

startup () {
    mount | grep "$TARGET_MOUNT" || mountfail
    script-pre-archiso/arch-mirror.sh
    pacstrap /mnt `cat ./packages/${BASE_PACKAGE}`
    genfstab -U /mnt >> /mnt/etc/fstab
    mkdir -p /mnt/installer/
    cp -a . /mnt/installer/
    arch-chroot /mnt /installer/`basename $0` systembase
    arch-chroot /mnt /installer/`basename $0` system
}

systembase () {
    cd /installer
    pwd

    echo username: $USERNAME
    useradd -m -s /bin/zsh "$USERNAME"
    echo -e "$USERPASSWORD\n$USERPASSWORD\n" | passwd "$USERNAME"
    echo -e "$ROOTPASSWORD\n$ROOTPASSWORD\n" | passwd

    script-chroot/arch-sudo.sh
    script-chroot/arch-locale.sh
    script-chroot/arch-network.sh
    script-chroot/arch-multilib.sh
    script-chroot/arch-timezone.sh
    pacman -Sy
}

system () {
    cd /installer
    pwd

    PACKEGS=""
    echo $PACKAGES_LIST
    for list in $PACKAGES_LIST; do
        PACKAGES="${PACKAGES} `cat packages/${list}`"
    done
    pacman -S --needed --noconfirm $PACKAGES

    for script in $SCRIPT_SYSTEM; do
        script-chroot/$script
    done
    su - "$USERNAME" -c "/installer/`basename $0` user"
}

user () {
    cd /installer
    pwd
    for script in $SCRIPT_USER; do
        script-chroot-user/$script
    done
}

outside () {
    for script in $SCRIPT_POST_ARCHISO; do
        script-post-archiso/$script
    done
}

aur () {
    for list in $PACKAGES_LIST_AUR; do
        PACKAGES="${PACKAGES} `cat packages-aur/${list}`"
    done
    yay -S --needed --removemake --noconfirm $PACKAGES
}

## Main

if [ "$1" == "" ]; then
    echo startup
    startup
    outside
    echo all done, after reboot run "\"/installer/${PARENT_SCRIPT} aur\"" to install aur packages
elif [ "$1" == "systembase" ]; then
    echo systembase
    systembase
elif [ "$1" == "system" ]; then
    echo system chroot
    system
elif [ "$1" == "user" ]; then
    echo user chroot
    user
elif [ "$1" == "aur" ]; then
    echo aur
    aur
fi
