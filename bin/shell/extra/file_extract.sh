#!/bin/bash

if [ "$3" == "" ]
then
	unrar x $1 $2 -o+
else
	unrar x -P$3 $1 $2 -o+
	fi
