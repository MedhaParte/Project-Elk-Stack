#!/bin/bash
## Get Todays date as variable
TODAY="$(date +%m-%d-%Y)"
tar cvf /var/backup/home.tar /home
mv /var/backup/home.tar /var/backup/home-$TODAY.tar
tar cvf /var/backup/system.tar /home
ls -lah /var/backup >> /var/backup/file_report.txt
free -h >> /var/backup/diskreport.txt

