#! /bin/bash

arg1="$0"
arg2="$#"
arg3="$*"

echo "Input parameters"
echo "$arg1"
echo "$arg2"
echo "$arg3"
printf "\n"

arrrgs() {
    echo "arrrgs!"
    echo "$0"
    echo "$#"
    echo "$*"
}

echo "With no arguments"
arrrgs
printf "\n"
echo "With one argument"
arrrgs "David"
printf "\n"
echo "With five arguments"
arrrgs "David" "Gilmour" "Roger" "Waters" "Nick" 