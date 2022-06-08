#!/bin/bash

if [ "$2" == "from" ] && [ "$4" == "to" ]
then
	rm /tmp/$1
	wget -q -P /tmp/ $3$1
	if [ -d "$5" ]
	then
		mv /tmp/$1 $5$1
	else
		mv /tmp/$1 $5
		fi
	fi
