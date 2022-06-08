#!/bin/bash

if [ -d "$1" ]
then
	if [ "$2" == "*" ]
	then
		rm -rf $1/*
	else
		rm -rf $1
		fi
	fi
