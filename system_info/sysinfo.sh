#! /bin/bash

cat system_info.txt
echo "Date and Time" | date +%x\ %T\ %Z
echo "User: "$(whoami)
pwd
echo "System Usage: "
top -b -n 1 | head -n 5
echo ""
echo "Disk Usage: "
df -h
