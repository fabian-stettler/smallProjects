#!/bin/bash

#parameter input from Backup_Script.txt.sh
# What to backup. 
backup_files="/tmp/"
dest=$1

# Where to backup to. Path of the test USB drive
#dest="/media/fabian/LIVE"


# Create archive filename.
# here the dollar sign is used to indicate a command
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file" \n


# Backup the files using tar.
# gibt noch einen Fehler aus, wenn der command nicht mit sudo ausgeführt 
# wird /home/normal_user: Cannot open: Permission denied
#-g erstellt ein log file mit Einträgen, welche benötigt werden um inkrementelles Backup durchzuführen
tar czf $dest/$archive_file $backup_files -g $dest/backup.log

# Print end status message.
echo \n\n"Backup finished"
date

