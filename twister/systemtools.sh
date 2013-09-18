#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "SYSTEM TOOLS APPS"
	echo "[1] Htop"
	echo "[2] Grsync"
	echo "[3] Wine"
	echo "[4] Virtualbox"
	echo ""
	echo "[a] ALL"
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm htop
			;;
		2)
			pacman -S --noconfirm grsync
			;;
		3)
			pacman -S --noconfirm wine wine_gecko winetricks
			;;
		4)
			pacman -S --noconfirm virtualbox virtualbox-additions
			su -l $USERNAME --command="yaourt -S --noconfirm virtualbox-ext-oracle"
			modprobe vboxdrv
			groupadd vboxusers
			gpasswd -a $USERNAME vboxusers
			add_new_module "vboxdrv"
			;;
		"a")
			pacman -S --noconfirm htop
			pacman -S --noconfirm grsync
			pacman -S --noconfirm wine wine_gecko winetricks
			pacman -S --noconfirm virtualbox virtualbox-additions
			su -l $USERNAME --command="yaourt -S --noconfirm virtualbox-ext-oracle"
			modprobe vboxdrv
			groupadd vboxusers
			gpasswd -a $USERNAME vboxusers
			add_new_module "vboxdrv"
			LOOP=0
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done