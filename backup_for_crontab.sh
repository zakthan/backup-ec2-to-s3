#!/bin/bash
DATE=$(date +"%m-%d-%Y.%H.%M.%S")
FOLDER_NAME=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 -s)
TOPIC="arn:aws:sns:us-west-2:264247381738:alerts"
ERROR_FILE="file://./file.txt"

##run backup script and if it fails send a message
/root/scripts/backup.sh &> file.txt
 aaa=$?
if [ $aaa != "0" ]
then
        aws sns publish --topic-arn "$TOPIC" --message $ERROR_FILE --subject "$FOLDER_NAME backup failed at $DATE"
 fi
