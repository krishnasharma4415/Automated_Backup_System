#!/bin/bash

SOURCE_DIR="/home/krishna"
BACKUP_DIR="/home/krishna/backups"
SNAPSHOT_FILE="$BACKUP_DIR/snapshot.snar"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/incremental_backup_$TIMESTAMP.tar.gz"

mkdir -p $BACKUP_DIR

if [ ! -f $SNAPSHOT_FILE ]; then
    touch $SNAPSHOT_FILE
fi

tar -Pczf $BACKUP_FILE --listed-incremental=$SNAPSHOT_FILE --exclude="$BACKUP_DIR" $SOURCE_DIR --warning=no-file-changed

if [ $? -eq 0 ]; then
    echo "Incremental backup successful: $BACKUP_FILE"
else
    echo "Incremental backup failed!"
fi