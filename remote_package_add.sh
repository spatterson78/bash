#!/bin/bash
#
#############################################################################
# Filename: remote_package_add.sh
# Author: Shawn Patterson
# Description: Script to install packages on remote systems
# Usage: ./remote_package_add.sh ARG1 ARG2
#        ARG1=Path to server list
#        ARG2=Path to package list
#        Ex. ./remote_package_add.sh /files/server.txt /files/packages.txt
#
#
#  Default dnf return values from man page:
#
#       · 0  : Operation was successful.
#
#       · 1  : An error occurred, which was handled by dnf.
#
#       · 3  : An unknown unhandled error occurred during operation.
#
#       · 100: See check-update
#
#       · 200: There was a problem with acquiring or releasing of locks.
#############################################################################

# Pre-defined Variables
SRV_LIST=$1
PKG_LIST=$2

# Functions
remote_install () {
	echo
	echo "Logging into remote server(s) and installing new package(s)..."
	echo
	for SRV in $(cat $SRV_LIST); do
		echo "Logging into server $SRV..."
		echo
		ssh $USER@$SRV sudo dnf -y install $(cat $PKG_LIST)
		[ $? = 0 ] && echo "Package install(s) completed on $SRV"; echo || echo "There was an error!!!"
		[ $? = 1 ] && echo "Package install(s) completed on $SRV"; echo || echo "There was an error!!!"
	done
}

#
echo
echo "Server list path entered: $SRV_LIST"
echo "Package list path entered: $PKG_LIST"
echo
echo "Are these the correct paths? Enter either \"y\" or \"n\""
read YN
echo

if [ $YN = "y" ]; then
	echo "Proceeding with package install(s)..."
elif [ $YN = "n" ]; then
	echo "Please re-run with correct path locations"
	echo "Script is exiting now..."
	exit
else
	echo "Script was expecting either \"y\" or \"n\""
	echo "Script is exiting now..."
	exit
fi

# execute function(s)
remote_install
