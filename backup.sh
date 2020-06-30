#!/bin/bash

# exit when any command fails
set -e

DATE=$(date +"%m-%d-%Y.%H.%M.%S")
TOMCAT_HOME=/usr/share/tomcat8
APACHE_CONFIG_HOME=/etc/httpd
APACHE_DOCROOT_HOME=/var/www/html
FOLDER_NAME=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 -s)
TOMCAT_BACKUP_NAME="tomcat_backup_$DATE.tar.gz"
APACHE_BACKUP_NAME="apache_backup_$DATE.tar.gz"

function tomcat_backup
{
##backup tomcat to tar
tar cvfz $TOMCAT_BACKUP_NAME $TOMCAT_HOME --exclude=log --exclude=work
##copy backup to s3
aws s3 cp  $TOMCAT_BACKUP_NAME s3://ramana-backup-bucket/$FOLDER_NAME/
##delete local tar
/bin/rm -f $TOMCAT_BACKUP_NAME
}

function apache_backup
{
##backup apache docroot and config to tar
tar cvfz $APACHE_BACKUP_NAME $APACHE_CONFIG_HOME $APACHE_DOCROOT_HOME --exclude=log --exclude=work
##copy backup to s3
aws s3 cp  $APACHE_BACKUP_NAME s3://ramana-backup-bucket/$FOLDER_NAME/
##delete local tar
/bin/rm -f $APACHE_BACKUP_NAME
}

##main
tomcat_backup
apache_backup
