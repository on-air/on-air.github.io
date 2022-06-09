#!/bin/bash

if [ "${1: -1}" == "/" ]
then
	cp -r $1/* $2
else
	cp -r $1 $2
	fi
