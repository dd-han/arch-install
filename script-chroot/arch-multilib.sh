#!/bin/bash

sed -i 's/^#\(\[multilib\]\)/\1\nInclude = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf