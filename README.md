# Automated Backup System

A robust Linux-based backup solution written in Bash that provides automated incremental and full backup capabilities with Git integration for version control and change tracking.

## Features

- **Incremental Backups**: Creates space-efficient backups by only backing up modified files
- **Full Backups**: Complete system backups with hash-based deduplication
- **Hash-based Change Detection**: Uses SHA256 checksums to identify modified files
- **Git Integration**: Automatically commits backup files to Git for version control
- **Automated Cleanup**: Removes previous backup files to save storage space
- **Flexible Restoration**: Restore from full backups with incremental updates
- **Timestamp Naming**: All backups are timestamped for easy identification

## Components

### 1. `incrementalbackup.sh`
- Creates incremental backups using GNU tar's snapshot feature
- Only backs up files that have changed since the last backup
- Maintains a snapshot file for tracking incremental changes
- Automatically commits backup archives to Git

### 2. `fullbackup.sh`
- Performs complete system backups
- Uses hash database to avoid backing up unchanged files
- Creates compressed tar.gz archives
- Integrates with Git for backup versioning

### 3. `restoringbackup.sh`
- Restores data from backup archives
- Automatically finds and restores the latest full backup
- Applies incremental backups in chronological order
- Provides restoration status feedback

## How It Works

1. **Hash Generation**: The system generates SHA256 hashes for all files in the source directory
2. **Change Detection**: Compares current file hashes with stored hash database
3. **Selective Backup**: Only backs up files that are new or have been modified
4. **Archive Creation**: Creates compressed tar.gz archives with timestamp naming
5. **Git Integration**: Automatically adds and commits backup files to Git repository
6. **Cleanup**: Removes previous backup files to maintain storage efficiency

## Configuration

The scripts are currently configured with the following default paths:
- **Source Directory**: `/home/krishna`
- **Backup Directory**: `/home/krishna/Automated_Backup_System/backups`
- **Restore Directory**: `/home/krishna/restore`

These paths can be easily modified in the script headers to match your system configuration.

## Usage

### Creating Backups
```bash
# Run incremental backup
./incrementalbackup.sh

# Run full backup
./fullbackup.sh
```

### Restoring Data
```bash
# Restore from backups
./restoringbackup.sh
```

## Requirements

- Linux operating system
- Bash shell
- GNU tar with incremental backup support
- Git (for version control integration)
- SHA256sum utility (usually included in coreutils)

## File Structure

```
Automated_Backup_System/
├── incrementalbackup.sh
├── fullbackup.sh
├── restoringbackup.sh
└── backups/
    ├── backup_hashes.txt
    ├── snapshot.snar
    ├── full_backup_YYYYMMDD_HHMMSS.tar.gz
    └── incremental_backup_YYYYMMDD_HHMMSS.tar.gz
```

## Key Benefits

- **Space Efficient**: Hash-based deduplication prevents backing up unchanged files
- **Version Control**: Git integration provides backup history and tracking
- **Automated**: Requires minimal manual intervention once configured
- **Reliable**: Comprehensive error handling and status reporting
- **Flexible**: Easy to modify paths and configuration for different environments

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## License

This project is open source and available under the [MIT License](LICENSE).
