#!/bin/bash
config () {
    HOSTNAME=dd-han-x230
    USERNAME=dd-han
    EMAIL="han@dd-han.tw"
    read -p "RootPassword: " ROOTPASSWORD
    read -p "UserPassword: " USERPASSWORD

    export USERNAME
    export HOSTNAME
    export USERPASSWORD
    export ROOTPASSWORD
    export EMAIL
}

mountfail () {
    echo '/mnt not mount, partition disk first'
    exit 1
}

startup () {
    mount | grep '/mnt' || mountfail
    config-script/mirror.sh
    pacstrap /mnt `cat ./packages/base.package`
    genfstab -U /mnt >> /mnt/etc/fstab
    mkdir -p /mnt/installer/
    cp -a . /mnt/installer/
    arch-chroot /mnt /installer/`basename $0` systemchroot
}

systemchroot () {
    cd /installer
    pwd

    config-script/timezone.sh
    config-script/locale.sh
    config-script/network.sh
    echo -e "$ROOTPASSWORD\n$ROOTPASSWORD\n" | passwd

    useradd -m -s /bin/zsh -p "$USERPASSWORD" "$USERNAME"
    config-script/quick-sudo.sh

    config-script/multilib.sh
    pacman -Sy
    pacman -S --needed - --noconfirm < packages/boot-uefi.package
    config-script/uefiboot.sh
    pacman -S --needed - --noconfirm < packages/utils.package
    pacman -S --needed - --noconfirm < packages/xfce.package
    config-script/xfce.sh
    cp config-system/10-libinput.conf /etc/X11/xorg.conf.d
    pacman -S --needed - --noconfirm < packages/utils-devs.package
    config-script/docker.sh
    pacman -S --needed - --noconfirm < packages/utils-gui.package
    pacman -S --needed - --noconfirm < packages/utils-multimedia.package
    pacman -S --needed - --noconfirm < packages/utils-smartcard.package
    pacman -S --needed - --noconfirm < packages/wine.package
    pacman -S --needed - --noconfirm < packages/x230drive.package
    pacman -S --needed - --noconfirm < packages/cjk.package
    cp config-system/01-monospace-font.conf /etc/fonts/conf.avail
    ln -s /etc/fonts/conf.avail/01-monospace-font.conf /etc/fonts/conf.d/01-monospace-font.conf 
    su - "$USERNAME" -c "/installer/`basename $0` userchroot"
    echo all done, after reboot run "\"/installer/`basename $0` aur\"" to install aur packages
}

userchroot () {
    cd /installer
    pwd
    /installer/config-script/xfce-user.sh
    /installer/config-script/yay.sh
    /installer/config-script/mpv-user.sh

    cat /installer/config-user/profile > ~/.profile
    cat /installer/config-user/xprofile > ~/.xprofile
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cat /installer/config-user/zshrc > ~/.zshrc

    mkdir -p ~/.ssh/
    cat /installer/config-user/ssh > ~/.ssh/config
    cp /installer/config-user/chromium-flags.conf ~/.config/
    cp /installer/config-user/chrome-flags.conf ~/.config/
    mkdir -p ~/.config/synapse/
    cp /installer/config-user/synapse/config.json ~/.config/synapse/

    ssh-keygen -f ~/.ssh/github -C "$EMAIL"
    ssh-keygen -f ~/.ssh/gitlab -C "$EMAIL"
}

aur () {
    yay -S --needed --removemake - --noconfirm < /installer/packages-aur/utils.package
    yay -S --needed --removemake - --noconfirm < /installer/packages-aur/utils-gui.package
    yay -S --needed --removemake - --noconfirm < /installer/packages-aur/utils-devs.package
}

## Main

if [ "$1" == "" ]; then
    config
    echo pacstraping
    startup
elif [ "$1" == "systemchroot" ]; then
    echo system chroot
    systemchroot
elif [ "$1" == "userchroot" ]; then
    echo user chroot
    userchroot
elif [ "$1" == "aur" ]; then
    aur
fi