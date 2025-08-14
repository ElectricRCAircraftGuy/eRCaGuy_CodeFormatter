#!/usr/bin/env bash

# GS
# Aug. 2025
#
# Aided by Grok AI: https://grok.com/share/bGVnYWN5LWNvcHk%3D_88c54d9a-087d-4c1c-9dec-a13d3179572d
# 
# ********************* WARNING *******************************************************************
# This script splits files from the location of this script, recursively, and downwards. Do NOT 
# copy the script nor move it into any dir under which you do not want it to split files!
# ********************* WARNING *******************************************************************

# See: https://stackoverflow.com/a/60157372/4561887
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
echo "cd-ing into $SCRIPT_DIRECTORY"
cd "$SCRIPT_DIRECTORY"

echo "Recursively finding files larger than 50MiB and splitting them into 25MiB chunks"
echo "so they can be committed into GitHub..."
echo ""

find . -type f -size +50M | while read -r file; do
  echo "Splitting $file into 25MiB chunks..."
  split -b 25M "$file" "${file}.part"
done

echo ""
echo "Splitting complete."
