cat /etc/pacman.d/mirrorlist | sed 's/^Server/#\0/g' | sed 's/^#\(Server = .*\.tw\/.*\)/\1/g' > /etc/pacman.d/mirrorlist.tw
mv /etc/pacman.d/mirrorlist{,.old}
mv /etc/pacman.d/mirrorlist{.tw,}