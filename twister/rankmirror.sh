#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user


print_title "RANKMIRROR - https://wiki.archlinux.org/index.php/Improve_Pacman_Performance"
question_for_answer "Choosing the fastest mirror using rankmirror (this can take a while)"
case "$OPTION" in
	"y")
		cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
		sed -i '/^#\S/ s|#||' /etc/pacman.d/mirrorlist.backup
		rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
		install_status
		;;
	*)
		CURRENT_STATUS=0
		;;
esac
sumary "New mirrorlist creation"
finish_function