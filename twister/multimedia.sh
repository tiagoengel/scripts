#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "MULTIMEDIA APPS"
	echo "[1] Rhythmbox"
	echo "[2] Exaile"
	echo "[3] Banshee"
	echo "[4] Clementine"
	echo "[5] Amarok"
	echo "[6] Beatbox"
	echo "[7] Arista"
	echo "[8] Transmageddon"
	echo "[9] XBMC"
	echo "[10] VLC"
	echo "[11] MIDI Support"
	echo "[12] Codecs"
	echo ""
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm rhythmbox
			;;
		2)
			pacman -S --noconfirm exaile
			;;
		3)
			pacman -S --noconfirm banshee
			;;
		4)
			pacman -S --noconfirm clementine
			;;
		5)
			pacman -S --noconfirm amarok
			;;
		6)
			su -l $USERNAME --command="yaourt -S --noconfirm beatbox-bzr"
			;;
		7)
			su -l $USERNAME --command="yaourt -S --noconfirm arista-transcoder"
			;;
		8)
			su -l $USERNAME --command="yaourt -S --noconfirm transmageddon"
			;;
		9)
			pacman -S --noconfirm xbmc
			;;
		10)
			pacman -S --noconfirm vlc
			if [ "$GNOME" -eq 0 ]; then
				pacman -S --noconfirm phonon-vlc
			fi
			;;
		11)
			su -l $USERNAME --command="yaourt -S --noconfirm timidity++ fluidr3"
			echo -e 'soundfont /usr/share/soundfonts/fluidr3/FluidR3GM.SF2' >> /etc/timidity++/timidity.cfg
			;;
		12)
			pacman -S --noconfirm gstreamer0.10-plugins
			su -l $USERNAME --command="yaourt -S --noconfirm libquicktime libdvdread libdvdnav libdvdcss cdrdao"
			if [ "$ARCHI" = "i686" ]; then
				su -l $USERNAME --command="yaourt -S --noconfirm codecs"
			else
				su -l $USERNAME --command="yaourt -S --noconfirm codecs64"
			fi
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done