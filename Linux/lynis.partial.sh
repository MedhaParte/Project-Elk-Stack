#!/bin/bash
#This will run  lynis scan for the test groups:malware,authentication, networing,storage, filesystem and save results to lynis partial scan log file.
sudo lynis audit --tests-from-group malware,authentication,networking,storage,filesystem --logfile /tmp/lynis.partial_scan.log

