#!/bin/bash

if [ "$3" == "--file" ]
then
	cp -r $1/* $2
else
	cp -r $1 $2
	fi
