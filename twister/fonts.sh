#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "FONTS - https://wiki.archlinux.org/index.php/Fonts"
	echo "[1] ttf-ms-fonts"
	echo "[2] ttf-dejavu"
	echo "[3] ttf-liberation"
	echo "[4] ttf-kochi-substitute (Japanese Support)"
	echo "[5] ttf-google-webfonts"
	echo "[6] ttf-roboto"
	echo ""
	echo "[a] ALL"
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			su -l $USERNAME --command="yaourt -S --noconfirm ttf-ms-fonts"
			;;
		2)
			pacman -S --noconfirm ttf-dejavu
			;;
		3)
			pacman -S --noconfirm ttf-liberation
			;;
		4)
			su -l $USERNAME --command="yaourt -S --noconfirm ttf-kochi-substitute"
			;;
		5)
			pacman -Rdd --noconfirm ttf-ubuntu-font-family ttf-droid
			su -l $USERNAME --command="yaourt -S --noconfirm ttf-google-webfonts"
			;;
		6)
			su -l $USERNAME --command="yaourt -S --noconfirm ttf-roboto"
			;;
		"a")
			pacman -Rdd --noconfirm ttf-ubuntu-font-family ttf-droid
			su -l $USERNAME --command="yaourt -S --noconfirm ttf-ms-fonts ttf-dejavu ttf-liberation ttf-kochi-substitute ttf-roboto ttf-google-webfonts"
			LOOP=0
			;;
		*)
			LOOP=0
			;;
	esac
	finish_function
done
print_title "FONTS CONFIGURATION - https://wiki.archlinux.org/index.php/Font_Configuration"
question_for_answer "Install ubuntu patched (cairo, fontconfig, freetype and libxft) packages"
case "$OPTION" in
	"y")
		pacman -Rdd --noconfirm cairo fontconfig freetype2 libxft
		su -l $USERNAME --command="yaourt -S --noconfirm cairo-ubuntu fontconfig-ubuntu freetype2-ubuntu"
		;;
	*)
		CURRENT_STATUS=0
		;;
esac
sumary "Ubuntu Patched Fonts Configuration installation"
finish_function