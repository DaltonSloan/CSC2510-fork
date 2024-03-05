#! /bin/bash

list_of_usernames="$1"
username="$2"
readarray -t usernames_array < "$list_of_usernames"
user_found=false

if [ "$#" -ne 2 ]; then
    echo "Incorrect number of arguments provided. Please provide the list of usernames and the username to search."
    exit 1
else
    echo "Arguments provided. Checking for user: $username..."
    printf "\n"
    sleep 2
fi

if [ -f "$list_of_usernames" ]; then
    echo "File exists"
    printf "\n"
else
    echo "File does not exist"
    exit 1
fi

for i in "${usernames_array[@]}"; do
    if [ "$i" == "$username" ]; then
        echo "User found: $username"
        user_found=true
        break
    fi
done

if [ "$user_found" = false ]; then
    while true; do
        read -p "User not found. Do you want to add the user? Please answer 'yes' or 'no': " answer
        if [ "$answer" == "yes" ]; then
            echo "$username" >> "$list_of_usernames"
            sort "$list_of_usernames" -o "$list_of_usernames"
            echo "User added: $username"
            exit 0
        elif [ "$answer" == "no" ]; then
            echo "User not added."
            exit 1
        else
            echo "Invalid input. Please answer 'yes' or 'no'."
        fi
    done
fi