#!/bin/bash

if [ "$UID" -ne 0 ] 
then 
    echo "Voce deve ter poder de root par executar este scrip." 
    exit 
fi 

mount -t cifs -o username="$1",uid=1000,password="$2" "$3" "$4"

