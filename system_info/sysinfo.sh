#! /bin/bash

echo "System information has been gathered. Here's the summary: " > system_info.txt
echo "Date and Time" | date +%x\ %T\ %Z >> system_info.txt
echo "User: $(whoami)" >> system_info.txt
echo "Current Working Directory: $(pwd)" >> system_info.txt
echo "System Usage: " >> system_info.txt
top -b -n 1 | head -n 5 >> system_info.txt
echo "" >> system_info.txt
echo "Disk Usage: " >> system_info.txt
df -h >> system_info.txt
cat system_info.txt

