#!/bin/bash

read -p "Project Name: " NAME

PS3="Option: "
echo "Files origin:"
opt=""
select opt in "svn" "git" "local" ; do
  if (( REPLY < 1 || REPLY > 3 )); then
    echo "Invalid option"
    continue
  fi    
  break
done

if [ "$opt" == "local" ]; then  
  echo "Insert file filters (\"*.cpp\", \"*.c\")"
  read FILTERS
  
  JSON_CFG=" \"directory\": \"./\", \"filters\": [ "$FILTERS" ] }, \"recursive\": 1 } ]"
else 
  read -p "$opt url: " URL
  JSON_CFG=" \""$opt"\": \""$URL"\" } ]"
fi

echo "{
   \"name\": \""$NAME"\", 
   \"files\": [ { "$JSON_CFG" 
}" > .kateproject
  

    