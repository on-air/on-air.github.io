#!/bin/bash

w_get () {
	if [ "${3: -1}" == "/" ]
	then
		wget -q -P /tmp/ $3$1
	else
		wget -q -P /tmp/ $3/$1
		fi
	}

w_move () {
	if [ -d "$3" ]
	then
		if [ "${3: -1}" == "/" ]
		then
			mv /tmp/$1 $3$1
		else
			mv /tmp/$1 $3/$1
			fi
	else
		mv /tmp/$1 $3
		fi
	}

w_clear () {
	if [ -f "/tmp/$1" ]
	then
		rm /tmp/$1
		fi
	}

if [ "$2" == "from" ] && [ "$4" == "to" ]
then
	w_clear $1
	w_get $1 from $3
	w_move $1 to $5
else
	if [ "$2" == "from" ]
	then
		w_clear $1
		w_get $1 from $3
		fi
	fi
