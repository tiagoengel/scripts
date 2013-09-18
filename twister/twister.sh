#!/bin/bash
#-------------------------------------------------------------------------------
#Created by helmuthdu mailto: helmuthdu[at]gmail[dot]com
#Inspired by Andreas Freitag, aka nexxx script
#-------------------------------------------------------------------------------
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# Run this script after your first boot with archlinux (as root)

#includes configs#{{{
  . config.sh  
#}}}

#begin #{{{
	clear
	echo "Welcome to the Ultimate Archlinux install script by helmuthdu"
	echo "Inspired by freitag archlinux helper script install"
	print_line
	echo "Requirements:"
	echo "-> Archlinux installation"
	echo "-> Run script as root user"
	echo "-> Working internet connection"
	print_line
	echo "Script can be canceled all the time with CTRL+C"
	print_line
	echo "OPEN THIS SCRIPTS AND READ ALL OPTIONS BEFORE USE IT"
	echo "Not recommended use this script more then 1 time (create duplicate values)"
	echo "This version is still in BETA. Send bugreports to: "
	echo "helmuthdu at gmail dot com"
	finish_function
#}}}
#custom repositories #{{{
	print_title "CUSTOM REPOSITORIES (Is recomended only if you use a 32 bits system)"
	question_for_answer "Install custom repositories (ayatana)"
	case "$OPTION" in
		"y")
			echo -e '[ayatana]\nServer = http://repo.ayatana.info/' >> /etc/pacman.conf
			echo -e '\n[custom]\nServer = file:///media/backup/Archlinux/$arch' >> /etc/pacman.conf
			install_status
			;;
		*)
			CURRENT_STATUS=0
			;;
	esac
	sumary "Custom repositories installation"
	finish_function
#}}}
#rankmirror #{{{
	. rankmirror.sh
#}}}
#system update #{{{
	print_title "UPDATING YOUR SYSTEM"
	pacman -Syu
	read -p "Reboot your system [y][n]: " OPTION
	if [ $OPTION = "y" ]; then
		reboot
		exit 0
	fi
#}}}
#create a new user #{{{
	print_title "CREATE USER ACCOUNT"
	read -p "New user name: " USERNAME
	useradd -m -g users -G users,audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash $USERNAME
	passwd $USERNAME
	#set user as sudo #{{{
		pacman -S --noconfirm sudo
		## Uncomment to allow members of group wheel to execute any command
		sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
		## Same thing without a password (not secure)
		#sed -i '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers
	#}}}
#}}}
#yaourt #{{{
	. yaourt.sh
#}}}
#base system #{{{
	print_title "BASH TOOLS - https://wiki.archlinux.org/index.php/Bash"
	pacman -S --noconfirm curl bc rsync mlocate bash-completion vim
	print_title "(UN)COMPRESS TOOLS - https://wiki.archlinux.org/index.php/P7zip"
	pacman -S --noconfirm tar gzip bzip2 unzip unrar p7zip
	print_title "DBUS - https://wiki.archlinux.org/index.php/D-Bus"
	pacman -S --noconfirm dbus
	add_new_daemon "dbus"
	print_title "ACPI - https://wiki.archlinux.org/index.php/ACPI_modules"
	pacman -S --noconfirm acpi acpid
	add_new_daemon "acpid"
	#TLP #{{{
	print_title "TLP - https://wiki.archlinux.org/index.php/TLP"
	question_for_answer "Install TLP (great battery improvement on laptops)"
	case "$OPTION" in
		"y")
			su -l $USERNAME --command="yaourt -S --noconfirm tlp"
			add_new_daemon "@tlp"
			install_status
			;;
		*)
			CURRENT_STATUS=0
			;;
	esac
	sumary "TLP installation"
	finish_function
	#}}}
	print_title "CUPS - https://wiki.archlinux.org/index.php/Cups"
	pacman -S --noconfirm cups ghostscript gsfonts
	pacman -S --noconfirm gutenprint foomatic-db foomatic-db-engine foomatic-db-nonfree foomatic-filters hplip splix cups-pdf
	add_new_daemon "@cupsd"
	print_title "NTFS/FAT - https://wiki.archlinux.org/index.php/Ntfs"
	pacman -S --noconfirm ntfs-3g ntfsprogs dosfstools
	print_title "SSH - https://wiki.archlinux.org/index.php/Ssh"
	pacman -S --noconfirm rssh openssh
	add_new_daemon "@sshd"
	#configure ssh/samba #{{{
		echo -e "sshd: ALL\n# End of file" > /etc/hosts.allow
		echo -e "ALL: ALL: DENY\n# End of file" > /etc/hosts.deny
		#ssh_conf #{{{
			sed -i '/ListenAddress/s/^#//' /etc/ssh/sshd_config
			sed -i '/SyslogFacility/s/^#//' /etc/ssh/sshd_config
			sed -i '/LogLevel/s/^#//' /etc/ssh/sshd_config
			sed -i '/LoginGraceTime/s/^#//' /etc/ssh/sshd_config
			sed -i '/PermitRootLogin/s/^#//' /etc/ssh/sshd_config
			sed -i '/StrictModes/s/^#//' /etc/ssh/sshd_config
			sed -i '/RSAAuthentication/s/^#//' /etc/ssh/sshd_config
			sed -i '/PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
			sed -i '/IgnoreRhosts/s/^#//' /etc/ssh/sshd_config
			sed -i '/PermitEmptyPasswords/s/^#//' /etc/ssh/sshd_config
			sed -i '/X11Forwarding/s/^#//' /etc/ssh/sshd_config
			sed -i '/X11Forwarding/s/no/yes/' /etc/ssh/sshd_config
			sed -i '/X11DisplayOffset/s/^#//' /etc/ssh/sshd_config
			sed -i '/X11UseLocalhost/s/^#//' /etc/ssh/sshd_config
			sed -i '/PrintMotd/s/^#//' /etc/ssh/sshd_config
			sed -i '/PrintMotd/s/yes/no/' /etc/ssh/sshd_config
			sed -i '/PrintLastLog/s/^#//' /etc/ssh/sshd_config
			sed -i '/TCPKeepAlive/s/^#//' /etc/ssh/sshd_config
			sed -i '/the setting of/s/^/#/' /etc/ssh/sshd_config
			sed -i '/RhostsRSAAuthentication and HostbasedAuthentication/s/^/#/' /etc/ssh/sshd_config
			sed -i 's/ListenAddress ::/s/^/#/' /etc/ssh/sshd_config
		#}}}
	#}}}
	print_title "SAMBA - https://wiki.archlinux.org/index.php/Samba"
	pacman -S --noconfirm samba
	cp /etc/samba/smb.conf.default /etc/samba/smb.conf
	add_new_daemon "@samba"
	print_title "ALSA - https://wiki.archlinux.org/index.php/Alsa"
	pacman -S --noconfirm alsa-utils alsa-plugins
	sed -i '/MODULES[=]/s/snd-usb-audio//' /etc/rc.conf
	sed -i '/MODULES[=]/s/MODULES[=](/&snd-usb-audio/' /etc/rc.conf
	add_new_daemon "@alsa"
#}}}
#X #{{{
	print_title "XORG - https://wiki.archlinux.org/index.php/Xorg"
	echo "Installing X-Server (req. for Desktopenvironment, GPU Drivers, Keyboardlayout,...)"
	pacman -S --noconfirm xorg-server xorg-xinit xorg-utils xorg-server-utils xorg-xkill xorg-xauth
	pacman -S --noconfirm xf86-input-evdev xf86-input-synaptics
	pacman -S --noconfirm mesa mesa-demos
	pacman -S --noconfirm xorg-twm xorg-xclock xterm
	pacman -S --noconfirm udisks gamin
#}}}
#graphic cards #{{{
	. graphiccards.sh
#}}}
#git access thru a firewall #{{{
	. gittor.sh
#}}}
#desktop environment #{{{
	. desktopenv.sh
#}}}
#developement #{{{
	. development.sh
#}}}
#office #{{{
	. office.sh
#}}}
#System Tools #{{{
	. systemtools.sh
#}}}
#graphics #{{{
	. graphics.sh
#}}}
#Internet #{{{
	. internet.sh
#}}}
#multimedia #{{{
	. multimedia.sh
#}}}
#Games #{{{
	. games.sh
#}}}
#fonts #{{{
	. fonts.sh
#}}}
#reboot #{{{
print_title "INSTALL COMPLETED"
question_for_answer "Reboot now?"
case "$OPTION" in
	"y")
		echo "Thanks for using the Ultimate Arch install script by helmuthdu"
		echo "Your Computer will now restart"
		finish_function
		reboot
		exit 0
		;;
	*)
		echo "Thanks for using the Ultimate Arch install script by helmuthdu"
		exit 0
		;;
esac
#}}}
#}}}
