#!/bin/bash

HOSTNAME=dd-han-x230
USERNAME=dd-han
EMAIL='han@dd-han.tw'
if [ "$1" == "" ]; then
    read -p 'RootPassword: ' ROOTPASSWORD
    read -p 'UserPassword: ' USERPASSWORD
fi

export HOSTNAME
export USERNAME
export EMAIL
export ROOTPASSWORD
export USERPASSWORD

export TARGET_MOUNT='/mnt'
export ESP_MOUNT='/boot'
export EFI_NAME='ArchLinux'

export PARENT_SCRIPT=`basename $0`
export BASE_PACKAGE='base.package'
export PACKAGES_LIST='xfce.package x230drive.package boot-uefi.package cjk.package network.package utils-devs.package utils-gui.package utils-multimedia.package utils-smartcard.package utils.package wifi-intel-drive.package'
export PACKAGES_LIST_AUR='utils.package utils-devs.package'

export SCRIPT_SYSTEM='docker.sh gcin.sh monospace-font.sh trackball-libinput.sh smartcard.sh uefiboot.sh'
export SCRIPT_USER='xfce-user.sh synapse.sh config.sh mpv-user.sh yay.sh zsh.sh'
export SCRIPT_POST_ARCHISO='kde.sh network-manager.sh'

./installer.sh $@
