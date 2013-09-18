#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "GRAPHICS APPS"
	echo "[1] Inkscape"
	echo "[2] Gimp"
	echo "[3] Gimp-plugins"
	echo "[4] Blender"
	echo "[5] MComix"
	echo ""
	echo "[a] ALL"
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm inkscape uniconvertor python2-numpy python-lxml
			su -l $USERNAME --command="yaourt -S --noconfirm sozi"
			;;
		2)
			pacman -S --noconfirm gimp
			;;
		3)
			su -l $USERNAME --command="yaourt -S --noconfirm gimp-paint-studio gimp-resynth gimpfx-foundry gimp-plugin-pandora gimp-plugin-saveforweb"
			;;
		4)
			pacman -S --noconfirm blender
			;;
		5)
			pacman -S --noconfirm mcomix
			;;
		"a")
			pacman -S --noconfirm gimp inkscape uniconvertor python2-numpy python-lxml blender mcomix
			su -l $USERNAME --command="yaourt -S --noconfirm gimp-paint-studio gimp-resynth gimpfx-foundry gimp-plugin-pandora gimp-plugin-saveforweb sozi"
			LOOP=0
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done