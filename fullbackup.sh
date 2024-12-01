#!/bin/bash

SOURCE_DIR="/home/krishna"
BACKUP_DIR="/home/krishna/Automated_Backup_System/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/full_backup_$TIMESTAMP.tar.gz"
HASH_DB="$BACKUP_DIR/backup_hashes.txt"

mkdir -p $BACKUP_DIR

# Remove previous full backup files
find $BACKUP_DIR -type f -name "full_backup_*.tar.gz" -exec rm -f {} \;

# Initialize the hash database if it doesn't exist
if [ ! -f $HASH_DB ]; then
    touch $HASH_DB
fi

# Generate file hashes and back up only new/modified files
find $SOURCE_DIR -type f -exec sha256sum {} \; > /tmp/file_hashes.txt

MODIFIED=false

while read -r HASH FILE; do
    if grep -q "$HASH" "$HASH_DB"; then
        echo "File $FILE is unchanged, skipping backup."
    else
        echo "$HASH $FILE" >> $HASH_DB
        MODIFIED=true
    fi
done < /tmp/file_hashes.txt

# Only create a tar.gz archive if there are modified files
if $MODIFIED; then
    tar -Pczf $BACKUP_FILE --exclude="$BACKUP_DIR" $SOURCE_DIR --warning=no-file-changed
    git add "$BACKUP_FILE"  # Add the backup archive to Git

    # Commit changes if there are any
    if [ -n "$(git status --porcelain)" ]; then
        git commit -m "Full backup on $TIMESTAMP"
        echo "Full backup successful and committed to Git: $BACKUP_FILE"
    else
        echo "No changes to back up."
    fi
else
    echo "No modified files, skipping full backup."
fi