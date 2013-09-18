#!/bin/bash
if [ -L "$0" ]; then
   BASE_DIR="$(dirname $(readlink $0))";
else
   BASE_DIR="$(dirname $0)";
fi
cd "$BASE_DIR"

. ../utils.sh

function create_connection() {
	file="$CONN_DIR$1"
	touch "$file"

	cat cn_template >> "$file"
	echo "Host:"
	read HOST
	echo "User:"
	read USER
	echo "Pass:"
	read PASS

	sed "s/?HOST/$HOST/g" "$file" -i
	sed "s/?USER/$USER/g" "$file" -i
	sed "s/?PASS/$PASS/g" "$file" -i
}

function connect() {
	. "$CONN_FILE"
	#xfreerdp -u "$USER" -p "$PASS" -g 95% --plugin cliprdr -T "$HOST" --plugin rdpdr --data disk:temp:"$HOME" -- "$HOST"
	xfreerdp /u:"$USER" /p:"$PASS" /size:1840x970 +clipboard +smart-sizing /drive:home,"$HOME" /t:"$HOST" /v:"$HOST"
}

function create_if_not_exist() {
	if [ ! -f "$CONN_FILE" ]; then
		echo "Connection $CONN_NAME not found. Create now? (y/n)"
		read OPTION

	if [ ! "$OPTION" == "y" ]; then
		exit 1
	fi

		create_connection "$CONN_NAME"
	fi
}


##################################################
#				MAIN METHOD                      #
##################################################

CONN_DIR="$HOME"/.rdp/

if [ "$1" == "-l" ]; then
	cd "$CONN_DIR"
	CONN_NAME=$(choose_a_file "Choose an connection:" "$2")
	cd ..
	if [ "$CONN_NAME" == "" ]; then
		exit 1
	fi
else
	CONN_NAME="$1"
fi

if [ "$CONN_NAME" == "" ]; then
	echo 'Invalid connection name!'
	exit 1
fi

CONN_FILE="$CONN_DIR$CONN_NAME"

create_if_not_exist

connect





