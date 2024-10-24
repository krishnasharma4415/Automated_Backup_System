#!/bin/bash

# Set variables
SOURCE_DIR="/home/krishna"
BACKUP_DIR="/home/krishna/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/full_backup_$TIMESTAMP.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create a full backup, excluding the backups directory itself
tar -Pczf $BACKUP_FILE --exclude="$BACKUP_DIR" $SOURCE_DIR --warning=no-file-changed

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Full backup successful: $BACKUP_FILE"
else
    echo "Full backup failed!"
fi
