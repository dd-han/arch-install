#!/bin/bash

# this will hang on This Session is locked
#xfconf-query -c xfce4-session --create -p /general/LockCommand --set "light-locker-command -l" --type string
# workaround
xfconf-query -c xfce4-session -p /general/LockCommand -s "dm-tool lock" --create -t string

mkdir -p ~/.config/xfce4/
cp -r /installer/config-user/xfce4/* ~/.config/xfce4/

mkdir -p ~/.config/autostart
cp -r /installer/config-user/autostart/* ~/.config/autostart/
