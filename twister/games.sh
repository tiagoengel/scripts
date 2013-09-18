#!/bin/bash
#includes #{{{
  . config.sh  
#}}}

#check if the user is or not root, and set the $USERNAME to $SUDO_USER
check_user

LOOP=1
while [ "$LOOP" -ne 0 ]
do
	print_title "GAMES - https://wiki.archlinux.org/index.php/Games"
	echo "[1] Action/Adventure"
	echo "[2] Arcade/Platformer"
	echo "[3] Dungeon"
	echo "[4] FPS"
	echo "[5] MMO"
	echo "[6] Puzzle"
	echo "[7] Simulation"
	echo "[8] Strategy"
	echo "[9] Racing"
	echo "[10] RPG"
	echo "[11] Emulators"
	echo ""
	echo "[q] QUIT"
	echo ""
	read -p "Option: " OPTION
	case "$OPTION" in
		1)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "ACTION AND ADVENTURE"
			echo "[1] Astromenace"
			echo "[2] OpenTyrian"
			echo "[3] M.A.R.S."
			echo "[4] Yo Frankie!"
			echo "[5] Counter-Strike 2D"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm astromenace"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm opentyrian-hg"
					;;
				3)
					su -l $USERNAME --command="yaourt -S --noconfirm mars-shooter"
					;;
				4)
					su -l $USERNAME --command="yaourt -S --noconfirm yofrankie"
					;;
				5)
					su -l $USERNAME --command="yaourt -S --noconfirm counter-strike-2d"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		2)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "ARCADE AND PLATFORMER"
			echo "[1] Opensonic"
			echo "[2] Frogatto"
			echo "[3] Bomberclone"
			echo "[4] Goonies"
			echo "[5] Neverball"
			echo "[6] Super Mario Chronicles"
			echo "[7] X-Moto"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm opensonic"
					;;
				2)
					pacman -S --noconfirm frogatto
					;;
				3)
					pacman -S --noconfirm bomberclone
					;;
				4)
					su -l $USERNAME --command="yaourt -S --noconfirm goonies"
					;;
				5)
					pacman -S --noconfirm neverball
					;;
				6)
					pacman -S --noconfirm smc
					;;
				7)
					pacman -S --noconfirm xmoto
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		3)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "DUNGEON"
			echo "[1] Tales of Maj'Eyal"
			echo "[2] Lost Labyrinth"
			echo "[3] S.C.O.U.R.G.E."
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm tome4"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm lostlabyrinth"
					;;
				3)
					su -l $USERNAME --command="yaourt -S --noconfirm scourge"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		4)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "FPS"
			echo "[1] World of Padman"
			echo "[2] Warsow"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm worldofpadman"
					;;
				2)
					pacman -S --noconfirm warsow
					;;
				3)
					pacman -S --noconfirm alienarena
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		5)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "MMO"
			echo "[1] Heroes of Newerth"
			echo "[2] Spiral Knights"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm hon"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm spiral-knights"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		6)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "PUZZLE"
			echo "[1] Numptyphysics"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm numptyphysics-svn"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		7)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "SIMULATION"
			echo "[1] Simultrans"
			echo "[2] Theme Hospital"
			echo "[3] OpenTTD"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm simutrans"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm corsix-th"
					;;
				3)
					pacman -S --noconfirm openttd
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		8)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "STRATEGY"
			echo "[1] Wesnoth"
			echo "[3] 0ad"
			echo "[4] Hedgewars"
			echo "[5] Warzone 2100"
			echo "[6] MegaGlest"
			echo "[7] Zod"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					question_for_answer "Install Devel Version"
					case "$OPTION" in
						"y")
							su -l $USERNAME --command="yaourt -S --noconfirm wesnoth-devel"
							;;
						*)
							pacman -S --noconfirm wesnoth
							;;
					esac
					;;
				3)
					su -l $USERNAME --command="yaourt -S --noconfirm 0ad"
					;;
				4)
					pacman -S --noconfirm hedgewars
					;;
				5)
					pacman -S --noconfirm warzone2100
					;;
				6)
					pacman -S --noconfirm megaglest
					;;
				7)
					su -l $USERNAME --command="yaourt -S --noconfirm commander-zod"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		9)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "RACING"
			echo "[1] Maniadrive"
			echo "[2] Death Rally"
			echo "[3] SupertuxKart"
			echo "[4] Speed Dreams"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm maniadrive"
					;;
				2)
					su -l $USERNAME --command="yaourt -S --noconfirm death-rally"
					;;
				3)
					pacman -S --noconfirm supertuxkart
					;;
				4)
					pacman -S --noconfirm speed-dreams
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		10)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "RPG"
			echo "[1] Ardentryst"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					su -l $USERNAME --command="yaourt -S --noconfirm ardentryst"
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		11)
		#{{{
		while [ "$LOOP" -ne 0 ]
		do
			print_title "RPG"
			echo "[1] ZSNES"
			echo ""
			echo "[b] BACK"
			echo ""
			read -p "Option: " OPTION
			case "$OPTION" in
				1)
					pacman -S --noconfirm zsnes
					;;
				*)
					LOOP=0
					;;
			esac
		done
		LOOP=1
		;;
		#}}}
		*)
		LOOP=0
		;;
	esac
done
finish_function