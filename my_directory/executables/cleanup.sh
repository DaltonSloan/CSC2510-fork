#! /bin/bash

#!/bin/bash

# Initialize directory names and base path
dir=("images" "documents" "pdfs" "executables" "data" "unknown")
path_to_dir="/Users/daltonsloan/Desktop/GitHub/CSC2510-fork/my_directory"

# Variable initialization for counting and size accumulation
total_files_moved=0
total_size_moved=0

# Arrays to hold count and size for each type
count=(0 0 0 0 0 0)
size=(0 0 0 0 0 0)

# Create directories if they don't exist
for directory in "${dir[@]}"; do
    if [ -d "${path_to_dir}/${directory}" ]; then
        echo "Directory ${directory} already exists. Skipping creation."
    else
        echo "Creating directory ${directory}."
        mkdir "${path_to_dir}/${directory}"
    fi
done

# Function to move files by extension
move_files() {
    target_dir_index=$1
    for ext in "${@:2}"; do
        # Using glob pattern to match files
        for file in "${path_to_dir}"/*."${ext}"; do
            if [ -f "$file" ]; then
                # Get file size in bytes
                file_size=$(wc -c <"$file")
                mv "$file" "${path_to_dir}/${dir[$target_dir_index]}"
                # Increment total files moved and total size moved
                total_files_moved=$((total_files_moved + 1))
                total_size_moved=$((total_size_moved + file_size))
                # Increment count and size for the specific file type
                count[$target_dir_index]=$((count[$target_dir_index] + 1))
                size[$target_dir_index]=$((size[$target_dir_index] + file_size))
            fi
        done
    done
}

# Function to move executable files
move_executables() {
    target_dir_index=3 # Index of 'executables' in the 'dir' array
    for file in "${path_to_dir}"/*; do
        if [ -f "$file" ] && ([ "${file##*.}" = "sh" ] || [ "${file##*.}" = "exe" ] || [ -x "$file" ]); then
            file_size=$(wc -c <"$file")
            mv "$file" "${path_to_dir}/${dir[$target_dir_index]}"
            total_files_moved=$((total_files_moved + 1))
            total_size_moved=$((total_size_moved + file_size))
            count[$target_dir_index]=$((count[$target_dir_index] + 1))
            size[$target_dir_index]=$((size[$target_dir_index] + file_size))
        fi
    done
}

# Move files by type
move_files 0 gif jpg jpeg png
move_files 1 txt docx doc pages key pptx ppt odt md
move_files 2 pdf
move_files 4 csv xlsx json
move_executables

# Move any remaining files to the 'unknown' directory
for file in "${path_to_dir}"/*; do
    if [ -f "$file" ]; then
        file_size=$(wc -c <"$file")
        mv "$file" "${path_to_dir}/${dir[5]}"
        total_files_moved=$((total_files_moved + 1))
        total_size_moved=$((total_size_moved + file_size))
        count[5]=$((count[5] + 1))
        size[5]=$((size[5] + file_size))
    fi
done

# Output results
echo "File move complete, Total files moved: $total_files_moved"
echo "Total size of files moved: $total_size_moved B"
average_size=0
if [ $total_files_moved -gt 0 ]; then
    average_size=$((total_size_moved / total_files_moved))
fi
echo "Average file size: $average_size B"

# Print breakdown per file type
echo "*** Breakdown per file type ***"
for i in "${!dir[@]}"; do
    if [ ${count[$i]} -gt 0 ]; then
        echo "*** ${dir[$i]^} ***"
        echo "Total moved ${count[$i]}, total size ${size[$i]} B"
        if [ ${count[$i]} -gt 0 ]; then
            echo "Average file size: $((size[$i] / count[$i])) B"
        fi
    fi
done

