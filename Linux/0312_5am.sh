#!/bin/bash
awk -F" " '{print$1,$2,$5,$6}' 0312_Dealer_schedule | grep "05:00:00 AM"

