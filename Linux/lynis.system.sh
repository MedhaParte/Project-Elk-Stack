#!/bin/bash
# This will run full system scan using lynis
sudo lynis audit system --logfile /tmp/lynis.system_scan.log 
