#!/bin/bash

BACKUP_DIR="/home/krishna/backups"
RESTORE_DIR="/home/krishna/restore"

mkdir -p $RESTORE_DIR

LATEST_FULL_BACKUP=$(ls -t $BACKUP_DIR/full_backup_*.tar.gz | head -n 1)

tar -xzf $LATEST_FULL_BACKUP -C $RESTORE_DIR

for INCREMENTAL in $(ls $BACKUP_DIR/incremental_backup*.tar.gz | sort); do
    tar -xzf $INCREMENTAL -C $RESTORE_DIR --warning=no-file-changed
done

if [ $? -eq 0 ]; then
    echo "Restoration completed successfully."
else
    echo "Restoration failed!"
fi