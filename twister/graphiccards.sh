#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

print_title "GRAPHIC CARD"
echo "Select your GPU:"
echo "[1] Intel"
echo "[2] ATI"
echo "[3] nVidia"
echo "[4] Nouveau"
echo "[5] Virtualbox"
echo ""
echo "[q] QUIT"
echo ""
read -p "Option: " OPTION
case "$OPTION" in
	1)
		pacman -S --noconfirm libgl xf86-video-intel
		install_status
		sumary "Intel GPU driver installation"
		;;
	2)
		echo "Proprietary driver or open source?"
		echo "[1] Proprietary"
		echo "[2] Open Source"
		read -p "Option:" ATIOPTION
		case "$ATIOPTION" in
		      1)		
			  echo "[catalyst]
			  Server = http://catalyst.apocalypsus.net/repo/catalyst/\$arch" >> /etc/pacman.conf
			  pacman -Sy
			  pacman -S  --noconfirm catalyst catalyst-utils
			  install_status
			  sumary "ATI GPU driver installation"
			  ;;
		      2)
			  pacman -S --noconfirm libgl xf86-video-ati
			  install_status
			  sumary "ATI GPU driver installation"
			  ;;
		      *)
			  CURRENT_STATUS=0
			  sumary "No driver installed"
			  ;;			  
		esac
	3)
		pacman -Rdd --noconfirm libgl
		pacman -S --noconfirm nvidia nvidia-utils
		install_status
		sumary "nVidia GPU driver installation"
		;;
	4)
		pacman -S --noconfirm libgl xf86-video-nouveau nouveau-dri
		modprobe nouveau
		add_new_module "nouveau"
		install_status
		sumary "Nouveau GPU driver installation"
		;;
	5)
		pacman -S --noconfirm virtualbox-archlinux-additions
		modprobe -a vboxguest vboxsf vboxvideo
		add_new_module "vboxguest vboxsf vboxvideo"
		groupadd vboxsf
		gpasswd -a $USERNAME vboxsf
		install_status
		sumary "Virtualbox guest additions (incl. video drivers) installation"
		;;
	*)
		CURRENT_STATUS=0
		sumary "GPU drivers installation"
		;;
esac
finish_function