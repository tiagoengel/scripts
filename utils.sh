#!/bin/bash

function findin() {
   find ./ -name "$1" | xargs grep "$2" | awk -F: '{print $1"/"$2}' | awk -F/ '{i=NF-1; print "("$2") --> " $i}' | sort -u
}

function choose_a_file() {
	prompt="$1"
	options=( $(ls | grep "$2") )

	if [ ${#options[@]} == 0 ]; then
		echo ""
		return
	fi

	PS3="$prompt "
	select opt in "${options[@]}" "Quit" ; do 
	    if (( REPLY == 1 + ${#options[@]} )) ; then
	        exit

	    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then	  
	    	echo "$opt"     
	        return
	    fi
	done 
	
	echo ""	
}

function getWindowID() {
  findpid="$1"

  known_windows=$(xwininfo -root -children|sed -e 's/^ *//'|grep -E "^0x"|awk '{ print $1 }')

  for id in ${known_windows}
  do
      xp=$(xprop -id $id _NET_WM_PID)
      if test $? -eq 0; then
	  pid=$(xprop -id $id _NET_WM_PID|cut -d'=' -f2|tr -d ' ')

	  if test "x${pid}" = x${findpid}
	  then
	      echo "Windows Id: $id"
	  fi
      fi
  done
}

# A slicker error handling routine
function error_exit() {

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------

	PROGNAME=$(basename $0)

	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}
