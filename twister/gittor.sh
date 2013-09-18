#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

print_title "GIT-TOR - https://wiki.archlinux.org/index.php/Tor"
question_for_answer "Ensuring access to GIT through a firewall (bypass college firewall)"
case "$OPTION" in
	"y")
		su -l $USERNAME --command="yaourt -S --noconfirm gtk-doc openbsd-netcat vidalia privoxy git"
		if [ ! -f /usr/bin/proxy-wrapper ]; then
			echo 'forward-socks5   /               127.0.0.1:9050 .' >> /etc/privoxy/config
			echo -e '#!/bin/bash\nnc.openbsd -xlocalhost:9050 -X5 $*' > /usr/bin/proxy-wrapper
			chmod +x /usr/bin/proxy-wrapper
			echo -e '\nexport GIT_PROXY_COMMAND="/usr/bin/proxy-wrapper"' >> /etc/bash.bashrc
			export GIT_PROXY_COMMAND="/usr/bin/proxy-wrapper"
			su -l $USERNAME --command="export GIT_PROXY_COMMAND=\"/usr/bin/proxy-wrapper\""
		fi
		#groupadd -g 42 privoxy
		#useradd -u 42 -g privoxy -s /bin/false -d /etc/privoxy privoxy
		pacman -S --noconfirm tor privoxy
		rc.d start tor privoxy
		su -l $USERNAME --command="sudo /etc/rc.d/tor restart"
		su -l $USERNAME --command="sudo /etc/rc.d/privoxy restart"
		add_new_daemon "@tor @privoxy"
		install_status
		;;
	*)
		CURRENT_STATUS=0
		;;
esac
sumary "GIT-TOR installation"
finish_function