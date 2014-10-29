#!/bin/bash

BACKUP_DIR=~/backups
FILE=db/production.sqlite3

usage() {
   echo "Usage: $0 [database]"
   exit 1
}

if [ ! -z $1 ]; then
   FILE=$1
else
   echo "No source database specified, using default: $FILE"
fi

if [ ! -f $FILE ]; then
   echo "$FILE is not a valid file"
   usage
   exit 1
fi

TIME=`date +%F_%H_%M_%S`_
NAME=`basename $FILE`

set -x
sqlite3 $FILE ".backup $BACKUP_DIR/$TIME$NAME"
