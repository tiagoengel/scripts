#!/bin/bash
#includes #{{{
  . config.sh  
#}}}	

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "OFFICE APPS"
	echo "[1] LibreOffice"
	echo "[2] Latex [Texmaker, Lyx]"
	echo "[3] CHM Viewer"
	echo "[4] Xmind"
	echo "[5] Wunderlist"
	echo "[6] GCStar"
	echo ""
	echo "[a] ALL"
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm libreoffice-$LOCATION_LO libreoffice-{base,calc,draw,impress,math,writer} libreoffice-extension-presenter-screen libreoffice-extension-pdfimport libreoffice-extension-diagram
			su -l $USERNAME --command="yaourt -S --noconfirm hunspell-$LOCATION_GNOME"
			if [ "$GNOME" -eq 1 ]; then
				pacman -S --noconfirm libreoffice-gnome
			else
				pacman -S --noconfirm libreoffice-kde4
			fi
			;;
		2)
			pacman -S --noconfirm texlive-latexextra texlive-langextra
			pacman -S --noconfirm lyx texmaker
			su -l $USERNAME --command="yaourt -S --noconfirm abntex"
			su -l $USERNAME --command="yaourt -S --noconfirm latex-template-springer latex-template-ieee latex-beamer"
			;;
		3)
			if [ "$GNOME" -eq 1 ]; then
				pacman -S --noconfirm chmsee
			else
				pacman -S --noconfirm kchmviewer
			fi
			;;
		4)
			su -l $USERNAME --command="yaourt -S --noconfirm xmind"
			;;
		5)
			su -l $USERNAME --command="yaourt -S --noconfirm wunderlist"
			;;
		6)
			pacman -S --noconfirm gcstar
			;;
		"a")
			pacman -S --noconfirm libreoffice-$LOCATION_LO libreoffice-{base,calc,draw,impress,math,writer} libreoffice-extension-presenter-screen libreoffice-extension-pdfimport libreoffice-extension-diagram
			su -l $USERNAME --command="yaourt -S --noconfirm hunspell-$LOCATION_GNOME"
			if [ "$GNOME" -eq 1 ]; then
				pacman -S --noconfirm libreoffice-gnome
			else
				pacman -S --noconfirm libreoffice-kde4
			fi
			pacman -S --noconfirm texlive-latexextra texlive-langextra lyx texmaker
			su -l $USERNAME --command="yaourt -S --noconfirm abntex"
			su -l $USERNAME --command="yaourt -S --noconfirm latex-template-springer latex-template-ieee latex-beamer"
			if [ "$GNOME" -eq 1 ]; then
				pacman -S --noconfirm chmsee
			else
				pacman -S --noconfirm kchmviewer
			fi
			su -l $USERNAME --command="yaourt -S --noconfirm xmind"
			su -l $USERNAME --command="yaourt -S --noconfirm wunderlist"
			pacman -S --noconfirm gcstar
			LOOP=0
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done