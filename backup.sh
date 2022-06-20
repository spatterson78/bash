#!/bin/bash
#
###################################################################
# Filename: backup.sh
# Author: Shawn Patterson
# Description: Script to backup user home directory
###################################################################

# Pre-defined Variable(s)
USERNAME=$(echo $USER)
SRC_PATH=/home/$USERNAME/
BKUP_PATH=/backups/$USERNAME
BKUP_NAME=/backups/$USERNAME/$USERNAME-$(date +"%F-%H%M-%Z").tar.gz

# Verify Variable(s) for testing purpose
echo
echo "username: $USERNAME"
echo "src_path: $SRC_PATH"
echo "bkup_path: $BKUP_PATH"
echo "bkup_name: $BKUP_NAME"

# Functions
bkup () {	
	echo
	echo "Backup starting now..."
	echo "-----------------------"
	echo
	tar cvzf $BKUP_NAME $SRC_PATH
	if [ $? = 0 ]; then
		echo
		echo "Backup completed at $(date +"%F-%H%M-%Z")"
	else
		echo "Backup Failed!!!"
	fi
}

bkup_dir () {
	if [ -d $BKUP_PATH ]; then
		echo
		echo "$BKUP_PATH directory already present"
	fi
	if [ ! -d $BKUP_PATH ]; then
		echo
		echo "$BKUP_PATH does not exist"
		echo
		echo "Creating $BKUP_PATH"
		echo
		mkdir $BKUP_PATH
		if [ $? = 0 ]; then
			echo "$BKUP_PATH created successfully"
			echo
		else
			"Creating $BKUP_PATH failed!!!"
		fi
	fi
}

# Verify correct username
echo
echo "Backup of /home/$USERNAME will be sent to /backup/$USERNAME"
echo
echo "Do you wish to continue? \"y\" or \"n\""
read YN
echo

if [ $YN = "y" ]; then
	echo "Proceeding with backup of /home/$USERNAME"
	# add more commands here
elif [ $YN = "n" ]; then
	echo "Exiting"
	exit
else
	echo "Please input either \"y\" or \"n\""
	read YN
	if [ $YN = "y" ]; then
		echo "Proceeding with backup of /home/$USERNAME"
		# add more commands here
	elif [ $YN = "n" ]; then
		echo "Exiting"
		exit
	else
		echo "Script exiting now due to invalid input"
		exit
	fi
fi

# Make backup directory if it does not exist
bkup_dir

# Create backup
bkup
