#!/bin/bash
#includes #{{{
  . config.sh  
#}}}	

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

echo "$USERNAME"
read -p "a" A 

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "DEVELOPMENT APPS"
	echo "[1] QT-Creator"
	echo "[2] Gvim"
	echo "[3] Emacs"
	echo "[4] Oracle Java"
	echo "[5] IntelliJ IDEA"
	echo "[6] Aptana Studio"
	echo "[7] Netbeans"
	echo "[8] Eclipse"
	echo "[9] Debugger Tools [Valgrind, Gdb, Splint, Tidyhtml, Pyflakes, Jsl, Meld]"
	echo "[10] MySQL Workbench"
	echo "[11] LAMP Server"
	echo ""
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
			pacman -S --noconfirm qtcreator qt-doc
			mkdir -p /home/$USERNAME/.config/Nokia/qtcreator/styles
			wget http://angrycoding.googlecode.com/svn/branches/qt-creator-monokai-theme/monokai.xml
			mv monokai.xml /home/$USERNAME/.config/Nokia/qtcreator/styles/
			chown -R $USERNAME:users /home/$USERNAME/.config
			;;
		2)
			pacman -Rdd --noconfirm vim
			pacman -S --noconfirm gvim wmctrl ctags
			#helmuthdu's vimrc
			git clone git://github.com/helmuthdu/vim.git
			mv vim /home/$USERNAME/.vim
			ln -sf /home/$USERNAME/.vim/vimrc /home/$USERNAME/.vimrc
			chown -R $USERNAME:users /home/$USERNAME/.vim
			chown $USERNAME:users /home/$USERNAME/.vimrc
			sed -i '/Icon/s/gvim/vim/g' /usr/share/applications/gvim.desktop
			;;
		3)
			pacman -S --noconfirm emacs
			;;
		4)
			pacman -Rdd --noconfirm jre7-openjdk
			pacman -Rdd --noconfirm jdk7-openjdk
			su -l $USERNAME --command="yaourt -S --noconfirm jdk"
			;;
		5)
			pacman -S --noconfirm intellij-idea-community-edition
			;;
		6)
			su -l $USERNAME --command="yaourt -S --noconfirm aptana-studio"
			;;
		7)
			pacman -S --noconfirm netbeans
			;;
		8)
			while [ "$LOOP" -ne 0 ]
			do
				print_title "ECLIPSE - https://wiki.archlinux.org/index.php/Eclipse"
				echo "[1] Eclipse Classic"
				echo "[2] Eclipse IDE for C/C++ Developers "
				echo "[3] Android Development Tools for Eclipse"
				echo "[4] Web Development Tools for Eclipse"
				echo "[5] PHP Development Tools for Eclipse"
				echo "[6] Python Development Tools for Eclipse"
				echo "[7] Aptana Studio plugin for Eclipse"
				echo "[8] Vim-like editing plugin for Eclipse"
				echo "[9] Git support plugin for Eclipse"
				echo ""
				echo "[b] BACK"
				echo ""
				read -p "Option: " OPTION
				case "$OPTION" in
					1)
						pacman -S --noconfirm eclipse
						;;
					2)
						pacman -S --noconfirm eclipse-cdt
						;;
					3)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-android android-apktool android-sdk android-sdk-platform-tools android-udev"
						;;
					4)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-wtp-wst"
						;;
					5)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-pdt"
						;;
					6)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-pydev"
						;;
					7)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-aptana"
						;;
					8)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-vrapper"
						;;
					9)
						su -l $USERNAME --command="yaourt -S --noconfirm eclipse-egit"
						;;
					*)
						LOOP=0
						;;
				esac
			done
			LOOP=1
			;;
		9)
			pacman -S --noconfirm valgrind gdb splint tidyhtml pyflakes meld
			su -l $USERNAME --command="yaourt -S --noconfirm jsl"
			;;
		10)
			su -l $USERNAME --command="yaourt -S --noconfirm mysql-workbench"
			;;
		11)			
			pacman -S --noconfirm apache mysql php php-apache php-mcrypt php-gd
			su -l $USERNAME --command="yaourt -S --noconfirm adminer"
			rc.d start httpd mysqld
			/usr/bin/mysql_secure_installation
			echo -e '\n# adminer configuration\nInclude conf/extra/httpd-adminer.conf' >> /etc/httpd/conf/httpd.conf
			echo -e 'application/x-httpd-php		php' >> /etc/httpd/conf/mime.types
			sed -i '/LoadModule dir_module modules\/mod_dir.so/a\LoadModule php5_module modules\/libphp5.so' /etc/httpd/conf/httpd.conf
			echo -e '\n# Use for PHP 5.x:\nInclude conf/extra/php5_module.conf\nAddHandler php5-script php' >> /etc/httpd/conf/httpd.conf
			sed -i 's/DirectoryIndex\ index.html/DirectoryIndex\ index.html\ index.php/g' /etc/httpd/conf/httpd.conf
			sed -i 's/public_html/Sites/g' /etc/httpd/conf/extra/httpd-userdir.conf
			sed -i '/mysqli.so/s/^;//' /etc/php/php.ini
			sed -i '/mysql.so/s/^;//' /etc/php/php.ini
			sed -i '/mcrypt.so/s/^;//' /etc/php/php.ini
			sed -i '/gd.so/s/^;//' /etc/php/php.ini
			sed -i '/skip-networking/s/^/#/' /etc/mysql/my.cnf
			su -l $USERNAME --command="mkdir -p ~/Sites"
			su -l $USERNAME --command="chmod 775 ~/ && chmod -R 775 ~/Sites"
			rc.d restart httpd mysqld
			add_new_daemon "httpd @mysqld"
			install_status
			;;
		 *)
			LOOP=0
			;;
	esac
	finish_function
done