#!/bin/bash

# A script to perform incremental backups using rsync
#FRAGE: WARUM findet der letzte Befehl des scriptes das directory LATESTLINK, wir haben diese ja nie angelegt

#err handling
set -o errexit #exit script when error occurs
set -o nounset #when scripts want to access undefined variable --> exit
set -o pipefail #not mask errors inside a pipe

HOME="/home/fabian/Desktop/TestForBackupDir"
#HOME="/home/fabian/"

SOURCE_DIR="${HOME}"
echo $1

#check if the USB Drive is here
if [[ -d $1 ]]; 
then
	echo "USB drive is present - backup can be made"
else
	echo "USB drive is not present - no backup will be made"
	exit
#end of the if statement	
fi

#start generating the Backup path and backup

DATETIME="$(date '+%Y-%m-%d_%H%M%S')"
BACKUP_PATH="$1/${DATETIME}/"
LATEST_LINK="$1/latest"

echo $BACKUP_PATH

#create directory to save the data in -p ---> create parent directory if neccessary
mkdir -p "${BACKUP_PATH}"

#-a = archive want to preserve almost all data; v = verbose, rsync gives feedback \ = not clone the source directory itself
#--delete --> löscht fremde files auf der "aufnehmenden Seite" im target directory

#we provide the directory from which we want to make backup
# we provide path to where we will backup the data
#first execution of script will creates full backup the path LATEST_LINK will not contain symbolic link but default is full backup
#--link-dest is the parameter which rsync uses to compare current state to

rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  "${BACKUP_PATH}"

echo "Backup complete, links have to be readjusted"

rm -rf "${LATEST_LINK}" # -r remove directories and their contents -f force in other words we remove the symbolic link inside the directory
ln -s "${BACKUP_PATH}" "${LATEST_LINK}" #make a symbolic link inside the LATEST__LINK path which points to Backup path

echo "Latest Link got updated"
