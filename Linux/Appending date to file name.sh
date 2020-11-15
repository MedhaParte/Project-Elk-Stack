#!/bin/bash
## Get Todays date as variable
TODAY="$(date +%m-%d-%Y)"
sudo tar cvf /var/backup/home.tar /home
sudo mv /var/backup/home.tar /var/backup/home-$TODAY.tar
sudo ls -lah /var/backup >> /var/backup/file_report.txt
sudo free -h >> /var/backup/diskreport.txt

