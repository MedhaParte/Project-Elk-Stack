#!/bin/bash
read -p 'please enter 4 digit date:' "date"
read -p 'please enter 2 digit hour:' "time" 
read -p 'Was this AM or PM:' "AMPM"
read -p  "Casino game being played:" "game"
cat -e /home/sysadmin/Cybersecurity-Lesson-Plans/03-Terminal/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/${date}_Dealer_schedule |  awk -F" " '{print$1,$2,$5,$6}' | grep -e $time | grep $AMPM



