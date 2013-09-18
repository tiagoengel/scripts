#!/bin/bash

FILE_NAME="$1"

iconv --from-code=ISO-8859-1 --to-code=UTF-8 $FILE_NAME > /tmp/enc.$$.txt
mv /tmp/enc.$$.txt $FILE_NAME
