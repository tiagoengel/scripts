#!/bin/bash
#includes #{{{
  . config.sh  
#}}}	

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

print_title "DESKTOP ENVIRONMENT - https://wiki.archlinux.org/index.php/Desktop_Environment"
echo "Choose your desktop-environment:"
echo "[1] GNOME"
echo "[2] KDE"
echo "[3] XFCE"
read -p "Option: " OPTION
case "$OPTION" in
	1)
		#GNOME #{{{
		print_title "GNOME - https://wiki.archlinux.org/index.php/GNOME"
		pacman -S --noconfirm gnome gnome-extra
		pacman -S --noconfirm gedit-plugins pulseaudio-gnome gnome-tweak-tool telepathy deja-dup
		pacman -S --noconfirm system-config-printer-gnome
		su -l $USERNAME --command="yaourt -S --noconfirm automounter"
		su -l $USERNAME --command="yaourt -S --noconfirm nautilus-open-terminal gnome-defaults-list"
		pacman -Rdd --noconfirm sushi
		su -l $USERNAME --command="yaourt -S --noconfirm gloobus-sushi-bzr"
		pacman -S --noconfirm gksu gvfs-smb xdg-user-dirs
		LOOP=1
		while [ "$LOOP" -ne 0 ]
		do
			print_title "FAVORITE GNOME APPS"
			echo "[1] GnomeShell Themes [eOS, Nord, Faience, Dark Shine]"
			echo "[2] GNOME Icons [Faience, Faenza, Elementary]"
			echo "[3] Themes [Zukitwo, Zukini, eGTK, Light, Aldabra]"
			echo "[4] GnomeShell Extensions"
			echo "[5] GNOME Activity Journal"
			echo "[6] Conky + CONKY-colors"
			echo "[7] Hotot"
			echo "[8] Openshot"
			echo "[9] PDFMod"
			echo "[10] Shotwell"
			echo "[11] Guake"
			echo "[12] X-Chat"
			echo "[13] Packagekit"
			echo ""
			echo "[a] ALL"
			echo "[q] QUIT"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm gnome-shell-theme-faience gnome-shell-theme-nord gnome-shell-theme-eos gnome-shell-theme-dark-shine"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm faience-icon-theme faenza-cupertino-icon-theme elementary-icons"
					;;
				3)
					su -l $USERNAME --command="yaourt -S --noconfirm zukitwo-themes zukini-theme light-themes-bzr egtk-bzr gtk-theme-aldabra"
					;;
				4)
					su -l $USERNAME --command="yaourt -S --noconfirm gpaste gnome-shell-system-monitor-applet-git gnome-shell-extension-noa11y-git gnome-shell-extension-weather-git gnome-shell-extension-user-theme gnome-shell-extension-workspace-indicator gnome-shell-extension-places-menu gnome-shell-extension-dock gnome-shell-extension-pomodoro gnome-shell-extension-mediaplayer-git"
					;;
				5)
					su -l $USERNAME --command="yaourt -S --noconfirm gnome-activity-journal libzeitgeist zeitgeist-datahub zeitgeist-extensions"
					;;
				6)
					su -l $USERNAME --command="yaourt -S --noconfirm toilet figlet cowsay conky conky-colors"
					sed -i '/MODULES[=]/s/\(.*\)\>/& coretemp it87 acpi-cpufreq/' /etc/rc.conf
					;;
				7)
					su -l $USERNAME --command="yaourt -Sf --noconfirm hotot faenza-hotot-icon"
					;;
				8)
					pacman -S --noconfirm openshot
					;;
				9)
					su -l $USERNAME --command="yaourt -S --noconfirm pdfmod"
					;;
				10)
					pacman -S --noconfirm shotwell
					;;
				11)
					pacman -S --noconfirm guake
					;;
				12)
					pacman -S --noconfirm xchat
					;;
				13)
					pacman -S --noconfirm gnome-packagekit gnome-settings-daemon-updates
					;;
				"a")
					su -l $USERNAME --command="yaourt -S --noconfirm gnome-shell-theme-faience gnome-shell-theme-nord gnome-shell-theme-eos"
					su -l $USERNAME --command="yaourt -S --noconfirm faience-icon-theme faenza-cupertino-icon-theme elementary-icons"
					su -l $USERNAME --command="yaourt -S --noconfirm zukitwo-themes zukini-theme light-themes-bzr egtk-bzr gtk-theme-aldabra"
					su -l $USERNAME --command="yaourt -S --noconfirm gpaste gnome-shell-system-monitor-applet-git gnome-shell-extension-noa11y-git gnome-shell-extension-weather-git gnome-shell-extension-user-theme gnome-shell-extension-workspace-indicator gnome-shell-extension-places-menu gnome-shell-extension-dock gnome-shell-extension-pomodoro gnome-shell-extension-mediaplayer-git"
					su -l $USERNAME --command="yaourt -S --noconfirm gnome-activity-journal libzeitgeist zeitgeist-datahub zeitgeist-extensions"
					su -l $USERNAME --command="yaourt -S --noconfirm pdfmod"
					su -l $USERNAME --command="yaourt -S --noconfirm toilet figlet cowsay conky conky-colors"
					su -l $USERNAME --command="yaourt -Sf --noconfirm hotot faenza-hotot-icon"
					sed -i '/MODULES[=]/s/\(.*\)\>/& coretemp it87 acpi-cpufreq/' /etc/rc.conf
					pacman -S --noconfirm openshot
					pacman -S --noconfirm shotwell
					pacman -S --noconfirm guake
					pacman -S --noconfirm xchat
					pacman -S --noconfirm gnome-packagekit gnome-settings-daemon-updates
					LOOP=0
					;;
				*)
					LOOP=0
					;;
			esac
			finish_function
		done
		GNOME=1
		add_new_daemon "gdm"
		sumary "GNOME installation"
		finish_function
		#}}}
		;;
	2)
		#KDE #{{{
		print_title "KDE - https://wiki.archlinux.org/index.php/KDE"
		pacman -S --noconfirm kde kde-l10n-$LOCATION_KDE
		pacman -Rcsn --noconfirm kdemultimedia-kscd kdemultimedia-juk kdemultimedia-dragonplayer
		pacman -S --noconfirm kdeadmin-system-config-printer-kde xdg-user-dirs
		su -l $USERNAME --command="yaourt -S --noconfirm chakra-gtk-config"
		su -l $USERNAME --command="yaourt -S --noconfirm oxygen-gtk qtcurve-gtk2 qtcurve-kde4 bespin-svn"
		su -l $USERNAME --command="yaourt -S --noconfirm kcm-wacomtablet"
		su -l $USERNAME --command="yaourt -S --noconfirm quickaccess-plasmoid plasma-icontasks"
		LOOP=1
		while [ "$LOOP" -ne 0 ]
		do
			print_title "FAVORITE KDE APPS"
			echo "[1] Plasma Themes [Caledonia]"
			echo "[2] KDE Icons [KFaenza]"
			#these 2 themes are also my :)
			echo "[3] QtCurve Themes [Kawai, Sweet]"
			echo "[4] Choqok"
			echo "[5] K3b"
			echo "[6] Apper"
			echo "[7] Minitube"
			echo "[8] Musique"
			echo "[9] Bangarang"
			echo "[10] Digikam"
			echo "[11] Yakuake"
			echo ""
			echo "[a] ALL"
			echo "[q] QUIT"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm plasma-theme-caledonia kdm-theme-caledonia ksplash-caledonia"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm kfaenza-icon-theme"
					;;
				3)
					#QtCurve Themes #{{{
					wget http://kde-look.org/CONTENT/content-files/144205-Sweet.tar.gz
					wget http://kde-look.org/CONTENT/content-files/141920-Kawai.tar.gz
					tar zxvf 144205-Sweet.tar.gz
					tar zxvf 141920-Kawai.tar.gz
					rm 144205-Sweet.tar.gz
					rm 141920-Kawai.tar.gz
					mkdir -p /home/$USERNAME/.kde4/share/apps/color-schemes
					mv Sweet/Sweet.colors /home/$USERNAME/.kde4/share/apps/color-schemes
					mv Kawai/Kawai.colors /home/$USERNAME/.kde4/share/apps/color-schemes
					mkdir -p /home/$USERNAME/.kde4/share/apps/QtCurve
					mv Sweet/Sweet.qtcurve /home/$USERNAME/.kde4/share/apps/QtCurve
					mv Kawai/Kawai.qtcurve /home/$USERNAME/.kde4/share/apps/QtCurve
					chown -R $USERNAME:users /home/$USERNAME/.kde4
					rm -fr Kawai Sweet
					#}}}
					;;
				4)
					pacman -S --noconfirm choqok
					;;
				5)
					pacman -S --noconfirm k3b dvd+rw-tools
					;;
				6)
					su -l $USERNAME --command="yaourt -S --noconfirm apper"
					;;
				7)
					su -l $USERNAME --command="yaourt -S --noconfirm minitube"
					;;
				8)
					su -l $USERNAME --command="yaourt -S --noconfirm musique"
					;;
				9)
					su -l $USERNAME --command="yaourt -S --noconfirm bangarang"
					;;
				10)
					pacman -S --noconfirm digikam kipi-plugins
					;;
				11)
					pacman -S --noconfirm yakuake
					su -l $USERNAME --command="yaourt -S --noconfirm yakuake-skin-plasma-oxygen-panel"
					;;
				"a")
					su -l $USERNAME --command="yaourt -S --noconfirm plasma-theme-caledonia kdm-theme-caledonia ksplash-caledonia"
					su -l $USERNAME --command="yaourt -S --noconfirm kfaenza-icon-theme"
					#QtCurve Themes #{{{
					wget http://kde-look.org/CONTENT/content-files/144205-Sweet.tar.gz
					wget http://kde-look.org/CONTENT/content-files/141920-Kawai.tar.gz
					tar zxvf 144205-Sweet.tar.gz
					tar zxvf 141920-Kawai.tar.gz
					rm 144205-Sweet.tar.gz
					rm 141920-Kawai.tar.gz
					mkdir -p /home/$USERNAME/.kde4/share/apps/color-schemes
					mv Sweet/Sweet.colors /home/$USERNAME/.kde4/share/apps/color-schemes
					mv Kawai/Kawai.colors /home/$USERNAME/.kde4/share/apps/color-schemes
					mkdir -p /home/$USERNAME/.kde4/share/apps/QtCurve
					mv Sweet/Sweet.qtcurve /home/$USERNAME/.kde4/share/apps/QtCurve
					mv Kawai/Kawai.qtcurve /home/$USERNAME/.kde4/share/apps/QtCurve
					chown -R $USERNAME:users /home/$USERNAME/.kde4
					rm -fr Kawai Sweet
					#}}}
					pacman -S --noconfirm choqok
					pacman -S --noconfirm k3b dvd+rw-tools
					su -l $USERNAME --command="yaourt -S --noconfirm apper"
					su -l $USERNAME --command="yaourt -S --noconfirm minitube"
					su -l $USERNAME --command="yaourt -S --noconfirm musique"
					su -l $USERNAME --command="yaourt -S --noconfirm bangarang"
					pacman -S --noconfirm digikam kipi-plugins
					pacman -S --noconfirm yakuake
					su -l $USERNAME --command="yaourt -S --noconfirm yakuake-skin-plasma-oxygen-panel"
					LOOP=0
					;;
				*)
					LOOP=0
					;;
			esac
			finish_function
		done
		GNOME=0
		add_new_daemon "kdm"
		sumary "KDE installation"
		finish_function
		#}}}
		;;
	3)
		#XFCE #{{{
		print_title "XFCE - https://wiki.archlinux.org/index.php/Xfce"
		pacman -S --noconfirm xfce4 xfce4-goodies
		pacman -S --noconfirm gstreamer0.10-plugins
		su -l $USERNAME --command="yaourt -S --noconfirm automounter"
		GNOME=1
		sumary "XFCE installation"
		finish_function
		#}}}
		;;
esac
#networkmanager #{{{
print_title "NETWORKMANAGER - https://wiki.archlinux.org/index.php/Networkmanager"
question_for_answer "Install NetworkManager"
case "$OPTION" in
	"y")
		if [ "$GNOME" -eq 1 ]; then
			pacman -S --noconfirm networkmanager network-manager-applet
		else
			pacman -S --noconfirm networkmanager kdeplasma-applets-networkmanagement
		fi
		groupadd networkmanager
		gpasswd -a $USERNAME networkmanager
		remove_daemon "network"
		add_new_daemon "@networkmanager"
		install_status
		;;
	*)
		CURRENT_STATUS=0
		;;
esac
sumary "NetworkManager installation"
finish_function
#}}}