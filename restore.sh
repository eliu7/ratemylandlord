#!/bin/bash

FILE=db/production.sqlite3

BACKUP=$1

usage() {
   echo "Usage: $0 backup_db [dest_db]"
   exit 1
}

if [ -z $BACKUP ]; then
   usage
fi

if [ ! -f $BACKUP ]; then
   echo "$BACKUP is not a valid backup file"
   usage
   exit 1
fi

if [ ! -z $2 ]; then
   FILE=$2
else
   echo "No destination database specified, using default $FILE"
fi

if [ ! -f $FILE ]; then
   echo "$FILE is not a valid file"
   usage
   exit 1
fi

set -x
sqlite3 $FILE ".restore $BACKUP"
