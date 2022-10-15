#!/bin/sh

# ---------------------------------------
# file:     $HOME/.dotfiles/bin/i3exit.sh
# author:   Bálint Gonda
# modified: 2021-12-16 
# ---------------------------------------

user_input=$(echo -e "cancel\nlogout\nshutdown\nreboot\nlock" | dmenu -nb "#101010" -nf "#e3dbb4" -sb "#a01416" -sf "#e3dbb4" -p "Shutdown Menu" )
#ff0a0a #a01416 #e3dbb4

case $user_input in
  logout)
    i3-msg exit
    ;;
  shutdown)
    systemctl poweroff
    ;;
  reboot)
    systemctl reboot
    ;;
  lock)
    i3lock
    ;;
  *)
    echo "ok."
    ;;
esac
