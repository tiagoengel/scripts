#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

print_title "YAOURT - https://wiki.archlinux.org/index.php/Yaourt"
question_for_answer "Install yaourt - AUR Backend (required for many Packages)?"
case "$OPTION" in
	"y")
		pacman -S --noconfirm base-devel yajl
		su -l $USERNAME --command="
			wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz;
			tar zxvf package-query.tar.gz;
			cd package-query;
			makepkg --noconfirm -si --asroot;
			cd ..;
			rm -fr package-query*
		"
		su -l $USERNAME --command="
			wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz;
			tar zxvf yaourt.tar.gz;
			cd yaourt;
			makepkg --noconfirm -si --asroot;
			cd ..;
			rm -fr yaourt*
		"
		install_status
		;;
	*)
		CURRENT_STATUS=0
		;;
esac
sumary "Yaourt installation"
finish_function
