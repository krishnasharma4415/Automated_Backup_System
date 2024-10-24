#!/bin/bash

# Set variables
SOURCE_DIR="/home/krishna"
BACKUP_DIR="/home/krishna/backups"
SNAPSHOT_FILE="$BACKUP_DIR/snapshot.snar"  # Store the snapshot file in the backup directory
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/incremental_backup_$TIMESTAMP.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create an empty snapshot file if it doesn't exist
if [ ! -f $SNAPSHOT_FILE ]; then
    touch $SNAPSHOT_FILE
fi

# Create an incremental backup, excluding the backups directory
tar -Pczf $BACKUP_FILE --listed-incremental=$SNAPSHOT_FILE --exclude="$BACKUP_DIR" $SOURCE_DIR --warning=no-file-changed

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Incremental backup successful: $BACKUP_FILE"
else
    echo "Incremental backup failed!"
fi
