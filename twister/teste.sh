#!/bin/bash
. config.sh
if [ "$(pidof ksmserver)" ]; then
   echo "KDE running."
   # KDE-specific stuff here
elif [ "$(pidof gnome-session)" ]; then
   echo "GNOME running."
   # GNOME-specific stuff here
elif [ "$(pidof xfce-mcs-manage)" ]; then
   echo "Xfce running."
   # Xfce-specific stuff here
fi