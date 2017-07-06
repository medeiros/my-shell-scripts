#!/bin/bash

ABS_PATH=/home/daniel
BKP_FILE="$ABS_PATH/Dropbox/backups/material.7z"
DIR_TO_BKP="$ABS_PATH/docs/material"
OWNER=daniel.daniel
PWD=c0d3r
DROPBOX_SCRIPT=/home/daniel/code/scripts/dropbox.py


7z a -p$PWD $BKP_FILE $DIR_TO_BKP > /dev/null 2>&1 
chown $OWNER $BKP_FILE

echo "bkp'ed."

if [[ $($DROPBOX_SCRIPT status) = "Dropbox isn't running!" ]]; then
	nohup $DROPBOX_SCRIPT start > /dev/null 2>&1
	nohup bash -c 'while [ '"$($DROPBOX_SCRIPT filestatus)"' != *"up to date" ]; do echo "aa"; done; '"$DROPBOX_SCRIPT"' stop' > /dev/null 2>&1 &
fi

