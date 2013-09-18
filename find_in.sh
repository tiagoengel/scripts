#!/bin/bash

find ./ -name "$1" | xargs grep "$2" | awk -F: {'print $1"/"$2'} | awk -F/ {'i=NF-1; print "("$2") --> " $i'} | sort -u

