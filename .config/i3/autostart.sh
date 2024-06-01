#!/bin/bash

# picom --config $HOME/.config/picom/picom.conf &
xcompmgr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# wallpaper set
#wall=$(find ~/Imágenes/Wallpapers/ -type f -name "*.jpg" -o -name "*.png" | shuf -n 1)
#xwallpaper --zoom $wall &
nitrogen --restore &

udiskie &
flameshot &
numlockx &
