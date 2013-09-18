#!/bin/bash

BASE_PACKAGE="$1"
FILES=$(find ./ -name \*.class | grep "$BASE_PACKAGE")

mkdir generated
cd generated

for file in $FILES; do
    dir_name=$(dirname "$file")
    mkdir -p "$dir_name"
    jad -d "$dir_name" -s .java -o ../"$file"
done;
