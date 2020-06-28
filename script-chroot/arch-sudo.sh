#!/bin/bash

sed -i 's/# \(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/g' /etc/sudoers
#sed -i 's/# \(%sudo       ALL=(ALL) ALL\)/\1/g' /etc/sudoers
gpasswd -a $USERNAME wheel
#gpasswd -a $USERNAME sudo