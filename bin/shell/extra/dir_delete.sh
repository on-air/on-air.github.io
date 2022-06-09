#!/bin/bash

if [ "${1: -1}" == "/" ]
then
	rm -rf $1/*
else
	if [ -d "$1" ]
	then
		rm -rf $1
		fi
	fi
