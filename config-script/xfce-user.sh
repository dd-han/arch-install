#!/bin/bash

xfconf-query -c xfce4-session --create -p /general/LockCommand --set "light-locker-command -l" --type string
mkdir -p ~/.config/xfce4/
cp -r /installer/config-user/xfce4/* ~/.config/xfce4/

mkdir -p ~/.config/autostart
cp -r /installer/config-user/autostart/* ~/.config/autostart/