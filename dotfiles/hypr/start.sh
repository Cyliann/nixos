#!/usr/bin/env bash

# initialize wallpaper daemon
# swww init &
#
# # set wallpaper
# swww img ~/Pictures/Wallpapers/forest_road2.png &
#
hyprpaper

# run networkmanager applet
nm-applet --indicator &

# bar
waybar &

# dunst
dunst &

hyprlock

