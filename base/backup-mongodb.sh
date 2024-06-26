#!/bin/bash
TIMESTAMP=$(date +%F-%H%M)
BACKUP_DIR=/data/db/backup-$TIMESTAMP
mkdir -p $BACKUP_DIR
mongodump --out $BACKUP_DIR

# Upload to Azure Storage
AZURE_STORAGE_ACCOUNT=$azurestorageaccountname
AZURE_STORAGE_KEY=$azurestorageaccountkey
AZURE_CONTAINER=$containername

az storage blob upload-batch -d $AZURE_CONTAINER -s $BACKUP_DIR --account-name $AZURE_STORAGE_ACCOUNT --account-key $AZURE_STORAGE_KEY