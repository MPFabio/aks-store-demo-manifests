#!/bin/bash

# Variables
MONGO_HOST="mongodb"
MONGO_PORT="27017"
MONGO_DB="my-database"
BACKUP_DIR="/backup"
TIMESTAMP=$(date +%F-%H%M)
BACKUP_NAME="mongodb-backup-$TIMESTAMP.gz"
AZCOPY_PATH="/usr/local/bin/azcopy"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

# Dump MongoDB database
mongodump --host $MONGO_HOST --port $MONGO_PORT --db $MONGO_DB --out $BACKUP_DIR/$TIMESTAMP

# Compress the backup
tar -czvf $BACKUP_DIR/$BACKUP_NAME -C $BACKUP_DIR $TIMESTAMP

# Upload to Azure Storage
$AZCOPY_PATH copy "$BACKUP_DIR/$BACKUP_NAME" "https://$azurestorageaccountname.blob.core.windows.net/$containername/$BACKUP_NAME"

# Clean up
rm -rf $BACKUP_DIR/$TIMESTAMP
rm $BACKUP_DIR/$BACKUP_NAME