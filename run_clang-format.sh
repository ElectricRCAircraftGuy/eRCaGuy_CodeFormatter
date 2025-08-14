#!/usr/bin/env bash

# By Gabriel Staples
# For documentation on this file, see my answer here:
# [my answer] How to call clang-format over a cpp project folder?:
# https://stackoverflow.com/a/65988393/4561887

RETURN_CODE_SUCCESS=0
RETURN_CODE_ERROR=1

# Option 1: search the dir in which this script, or a symlink to it, is located.
# See my ans: https://stackoverflow.com/a/60157372/4561887
FULL_PATH_TO_SCRIPT="$(realpath -s "$0")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
DIR_TO_SEARCH="$SCRIPT_DIRECTORY"

# # Option 2: search the repo root. Exit if not inside a git repo. 
# # See: https://stackoverflow.com/a/957978/4561887
# echo "Searching for files to format just in the repo root dir..."
# REPO_ROOT_DIR="$(git rev-parse --show-toplevel)"
# if [ $? -ne 0 ]; then
#     echo "Error: Not in a git repository. Cannot determine repo root directory."
#     exit $RETURN_CODE_ERROR
# fi
# DIR_TO_SEARCH="$REPO_ROOT_DIR"

echo "DIR_TO_SEARCH is set to $DIR_TO_SEARCH"

# Find all files in DIR_TO_SEARCH with one of these extensions
FILE_LIST="$(find "$DIR_TO_SEARCH" | grep -E ".*\.(ino|cpp|cc|c|h|hpp|hh)$")"
# echo "\"$FILE_LIST\"" # debugging
# split into an array; see my ans: https://stackoverflow.com/a/71575442/4561887
# mapfile -t FILE_LIST_ARRAY <<< "$FILE_LIST"
IFS=$'\n' read -r -d '' -a FILE_LIST_ARRAY <<< "$FILE_LIST"

num_files="${#FILE_LIST_ARRAY[@]}"
echo -e "$num_files files found to format:"
if [ "$num_files" -eq 0 ]; then
    echo "Nothing to do."
    exit $RETURN_CODE_SUCCESS
fi

# print the list of all files
for i in "${!FILE_LIST_ARRAY[@]}"; do
    file="${FILE_LIST_ARRAY["$i"]}"
    printf "  %2i: %s\n" $((i + 1)) "$file"
done
echo ""

format_files="false"
# See: https://stackoverflow.com/a/226724/4561887
read -p "Do you wish to auto-format all of these files [y/N] " user_response
case "$user_response" in
    [Yy]* ) format_files="true"
esac

if [ "$format_files" = "false" ]; then
    echo "Aborting."
    exit $RETURN_CODE_SUCCESS
fi

# Format each file in-place (`-i`).
echo "Formatting all files in-place..."
clang-format --verbose -i --style=file "${FILE_LIST_ARRAY[@]}"
