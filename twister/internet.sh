#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "INTERNET APPS"
	echo "[1] Firefox"
	echo "[2] Thunderbird"
	echo "[3] Google-Chrome"
	echo "[4] Jdownloader"
	echo "[5] Google Earth"
	echo "[6] Dropbox"
	echo "[7] Teamviewer"
	echo "[8] Trasmission"
	echo ""
	echo "[a] ALL"
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm firefox firefox-i18n-$LOCATION_GNOME flashplugin
			;;
		2)
			pacman -S --noconfirm thunderbird thunderbird-i18n-$LOCATION_GNOME
			;;
		3)
			pacman -S --noconfirm flashplugin
			su -l $USERNAME --command="yaourt -S --noconfirm google-chrome"
			;;
		4)
			su -l $USERNAME --command="yaourt -S --noconfirm jdownloader"
			;;
		5)
			su -l $USERNAME --command="yaourt -S --noconfirm google-earth"
			;;
		6)
			if [ "$GNOME" -eq 1 ]; then
				su -l $USERNAME --command="yaourt -S --noconfirm nautilus-dropbox"
			else
				su -l $USERNAME --command="yaourt -S --noconfirm kfilebox"
			fi
			;;
		7)
			su -l $USERNAME --command="yaourt -S --noconfirm teamviewer"
			;;
		8)
			if [ "$GNOME" -eq 1 ]; then
				su -l $USERNAME --command="yaourt -S --noconfirm transmission-gtk"
			else
				su -l $USERNAME --command="yaourt -S --noconfirm transmission-qt"
			fi
			;;
		"a")
			pacman -S --noconfirm firefox firefox-i18n-$LOCATION_GNOME flashplugin
			pacman -S --noconfirm thunderbird thunderbird-i18n-$LOCATION_GNOME
			su -l $USERNAME --command="yaourt -S --noconfirm google-chrome"
			su -l $USERNAME --command="yaourt -S --noconfirm jdownloader"
			su -l $USERNAME --command="yaourt -S --noconfirm google-earth"
			su -l $USERNAME --command="yaourt -S --noconfirm teamviewer"
			if [ "$GNOME" -eq 1 ]; then
				su -l $USERNAME --command="yaourt -S --noconfirm nautilus-dropbox"
				su -l $USERNAME --command="yaourt -S --noconfirm transmission-gtk"
			else
				su -l $USERNAME --command="yaourt -S --noconfirm kfilebox"
				su -l $USERNAME --command="yaourt -S --noconfirm transmission-qt"
			fi
			LOOP=0
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done