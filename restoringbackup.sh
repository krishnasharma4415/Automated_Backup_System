#!/bin/bash

# Set variables
BACKUP_DIR="/home/krishna/backups"
RESTORE_DIR="/home/krishna/restore"  # Change this to your desired restore directory

# Create restore directory if it doesn't exist
mkdir -p $RESTORE_DIR

# Find the latest full backup (assuming naming convention full_backup_*.tar.gz)
LATEST_FULL_BACKUP=$(ls -t $BACKUP_DIR/full_backup_*.tar.gz | head -n 1)

# Restore full backup
tar -xzf $LATEST_FULL_BACKUP -C $RESTORE_DIR

# Restore incremental backups (in order)
for INCREMENTAL in $(ls $BACKUP_DIR/incremental_backup*.tar.gz | sort); do
    tar -xzf $INCREMENTAL -C $RESTORE_DIR --warning=no-file-changed
done

# Check if restoration was successful
if [ $? -eq 0 ]; then
    echo "Restoration completed successfully."
else
    echo "Restoration failed!"
fi
