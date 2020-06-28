#!/bin/bash

sed -i 's/^#\(en_US.UTF-8.*\)/\1/g' /etc/locale.gen
sed -i 's/^#\(zh_TW.UTF-8.*\)/\1/g' /etc/locale.gen
locale-gen

echo 'LANG=zh_TW.UTF-8' > /etc/locale.conf