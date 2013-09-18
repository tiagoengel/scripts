#!/bin/bash
GNOME=0
ARCHI=`uname -m`

# Automatically detects the system language based on your rc.conf
LOCATION=`cat /etc/rc.conf | sed -n '/LOCALE=/p' | sed '1!d' | cut -c9-13`
LOCATION_KDE=`echo $LOCATION | tr '[:upper:]' '[:lower:]'`
LOCATION_GNOME=`echo $LOCATION | tr '[:upper:]' '[:lower:]' | sed 's/_/-/'`
LOCATION_LO=`echo $LOCATION | sed 's/_/-/'`

function question_for_answer(){ #{{{
	read -p "$1 [y][n]: " OPTION
	echo ""
} #}}}
function install_status(){ #{{{
	if [ $? -ne 0 ] ; then
		CURRENT_STATUS=-1
	else
		CURRENT_STATUS=1
	fi
} #}}}
function print_line(){ #{{{
	echo "--------------------------------------------------------------------------------"
} #}}}
function print_title (){ #{{{
	clear
	echo "#-------------------------------------------------------------------------------"
	echo -e "# $1"
	echo "#-------------------------------------------------------------------------------"
	echo ""
} #}}}
function add_new_daemon(){ #{{{
	remove_daemon "$1"
	sed -i '/DAEMONS[=]/s/\(.*\)\>/& '"$1"'/' /etc/rc.conf
} #}}}
function remove_daemon(){ #{{{
	sed -i '/DAEMONS[=]/s/'"$1"' //' /etc/rc.conf
} #}}}
function add_new_module(){ #{{{
	remove_module "$1"
	sed -i '/MODULES[=]/s/\(.*\)\>/& '"$1"'/' /etc/rc.conf
	#sed -i '/MODULES[=]/s/^[^ ]*\>/& '"$1"'/' /etc/rc.conf
} #}}}
function remove_module(){ #{{{
	sed -i '/MODULES[=]/s/'"$1"' //' /etc/rc.conf
} #}}}
function finish_function(){ #{{{
	print_line
	echo "Continue with RETURN"
	read
	clear
} #}}}
function sumary(){ #{{{
	case $CURRENT_STATUS in
		0)
			print_line
			echo "$1 not successfull (Canceled)"
			;;
		-1)
			print_line
			echo "$1 not successfull (Error)"
			;;
		1)
			print_line
			echo "$1 successfull"
			;;
		*)
			print_line
			echo "WRONG ARG GIVEN"
			;;
	esac
} #}}}
function check_user(){ #{{{		
	if [ "$USER" != "root" ] ; then
	    echo "ATTENTION! Run this script as root"
	    exit 1
	else 	   
	    USERNAME="$SUDO_USER"
	fi

	#additionally check the desktop enviroment
	if [ "$(pidof ksmserver)" ] ; then
	    GNOME=0
	else 
	    #FOR XFCE AND GNOME
	    GNOME=1
	fi
} #}}}