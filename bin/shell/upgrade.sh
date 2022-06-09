#!/bin/bash

package="node_modules"

if [ "$1" != "" ]
then
	package="$1/node_modules"
	fi

if [ -d "$package" ]
then
	dir_copy $node_modules/ $package/
	fi
