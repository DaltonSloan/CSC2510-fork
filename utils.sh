#! /bin/bash

# Question 1
find /usr/bin -name 'c*'
# Question 2
find /usr/bin -name '*sh*' -type l
# Question 3
find /usr | head -n 10
# Question 4
grep "model name" /proc/cpuinfo
# Question 5
grep -cv "send" /etc/services
# Question 6
grep -n "send" /etc/services
# Question 7
cat food | sort
# Question 8
cat food | sort -r
# Question 9
sort --key=2 food
# Question 10
sort -k4,4nr -k3,3nr food > calo
