#!/bin/bash

list_of_usernames="$1"
username="$2"
readarray -t usernames_array < "$list_of_usernames"
user_found=false

echo "Checking if file exists..."
sleep 2

if [ -f "$list_of_usernames" ]; then
    echo "File exists!"
    printf "\n"
else
    echo "File does not exist!"
    echo "Exiting..."
    sleep 1
    exit 1
fi

echo "Checking for correct number of arguments..."
sleep 2

if [ "$#" -ne 2 ]; then
    echo "Incorrect number of arguments provided. Please provide the list of usernames and the username to search."
    echo "Exiting..."
    sleep 1
    exit 1
else
    echo "Correct number of arguments provided. Checking for user: $username..."
    printf "\n"
    sleep 2
fi

for i in "${usernames_array[@]}"; do
    if [ "$i" = "$username" ]; then
        echo "User $username found!"
        user_found=true
        break
    fi
done

if [ "$user_found" = false ]; then
    read -p "User $username not found. Would you like to add it? ('yes' or 'no'): " answer
    while true; do
        case "$answer" in
            yes | y | Y | Yes | YES)
                echo "Adding user $username..."
                sleep 2
                echo "$username" >> "$list_of_usernames"
                echo "User $username added!"
		printf "\n"
                read -p "Would you like to sort the list? ('yes' or 'no'): " sort_answer
                while true; do
                    case "$sort_answer" in
                        yes | y | Y | Yes | YES)
                            echo "Sorting list..."
                            sleep 2
                            sort -o "$list_of_usernames" "$list_of_usernames"
                            echo "List sorted!"
			    echo "Exiting..."
			    sleep 1
                            exit 0
                            ;;
                        no | n | N | No)
                            echo "List not sorted."
			    echo "Exiting..."
			    sleep 1
                            exit 0
                            ;;
                        *)
                            read -p "Invalid input. Please enter 'yes' or 'no': " sort_answer

                            ;;
                    esac
                done
                    ;;
            no | n | N | No | NO)
                echo "User $username not added."
		echo "Exiting..."
		sleep 1
                exit 0
                ;;
            *)
                read -p "Invalid input. Please enter 'yes' or 'no': " answer
                ;;
        esac
    done
fi
