#!/bin/bash

SOURCE_DIR="/home/krishna"
BACKUP_DIR="/home/krishna/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/full_backup_$TIMESTAMP.tar.gz"

mkdir -p $BACKUP_DIR

tar -Pczf $BACKUP_FILE --exclude="$BACKUP_DIR" $SOURCE_DIR --warning=no-file-changed

if [ $? -eq 0 ]; then
    echo "Full backup successful: $BACKUP_FILE"
else
    echo "Full backup failed!"
fi