#!/bin/bash

# Check if a filename is provided as a command line argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1

# Check if the file exists
if [ ! -e "$filename" ]; then
    echo "File '$filename' does not exist."
    exit 1
fi

# Check if it's a regular file
if [ -f "$filename" ]; then
    # Display file information for ordinary files
    echo "File '$filename' is an ordinary file."
    echo "Access Permissions: $(ls -l "$filename" | cut -d ' ' -f 1)"
    echo "Size: $(du -h "$filename" | cut -f 1)"
    echo "Last Modified: $(stat -c '%y' "$filename")"
elif [ -d "$filename" ]; then
    # Display information for directories
    echo "File '$filename' is a directory."
    file_count=$(find "$filename" -maxdepth 1 -type f | wc -l)
    dir_count=$(find "$filename" -maxdepth 1 -type d | wc -l)
    echo "Number of files: $file_count"
    echo "Number of subdirectories: $((dir_count - 1))"  # Subtracting 1 to exclude the directory itself
else
    echo "File '$filename' is not a regular file or directory."
fi
