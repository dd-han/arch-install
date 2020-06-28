#!/bin/bash

cp -r /usr/share/doc/mpv/ ~/.config/
sed -i 's/#hwdec=auto/hwdec=auto/g' ~/.config/mpv/mpv.conf