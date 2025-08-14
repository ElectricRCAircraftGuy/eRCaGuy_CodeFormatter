#!/usr/bin/env bash

# GS
# Aug. 2025
#
# Aided by Grok AI: https://grok.com/share/bGVnYWN5LWNvcHk%3D_88c54d9a-087d-4c1c-9dec-a13d3179572d
#
# See also:
# 1. https://unix.stackexchange.com/q/24630/114401
# 
# ********************* NOTICE *******************************************************************
# This script recombines files from the location of this script, recursively, and downwards. Do NOT 
# copy the script nor move it into any dir under which you do not want it to recombine files!
# ********************* NOTICE *******************************************************************

# See: https://stackoverflow.com/a/60157372/4561887
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
echo "cd-ing into $SCRIPT_DIRECTORY"
cd "$SCRIPT_DIRECTORY"

echo "Recursively finding and recombining split files..."
echo ""

# Find all .partaa files recursively to identify the start of split files
find . -type f -name "*.partaa" | while read -r partaa_file; do
  # Extract the base filename (removing .partaa suffix) and directory
  basefile=$(echo "$partaa_file" | sed -E 's/\.partaa$//')
  dir=$(dirname "$partaa_file")
  
  echo "Recombining parts for $basefile..."
  # Concatenate all parts in order (partaa, partab, etc.) in the same directory
  cat "$dir/$(basename "$basefile")".part* > "$basefile"
  
  # Verify if recombination was successful
  if [ $? -eq 0 ]; then
    echo "  Successfully recombined $basefile"
    echo "  Making it executable."
    chmod +x "$basefile"
    # Optionally, remove the part files after successful recombination
    # rm "$dir/$(basename "$basefile")".part*
  else
    echo "  Error recombining $basefile"
  fi
done

echo ""
echo "Recombination complete."
