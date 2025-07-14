#!/bin/bash

clean_downloads() {
    local DAYS=7
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color

    printf "%bDeleting files older than %d days from ~/Downloads (excluding .sh files)%b\n" "$GREEN" "$DAYS" "$NC"
    echo "----------------------------------------------"

    find ~/Downloads/* -type f ! -name '*.sh' -mtime +$DAYS -print -delete 2>/dev/null | while read -r file; do
        printf "%bDeleted: %s%b\n" "$GREEN" "$file" "$NC"
    done

    find ~/Downloads/* -type d -empty -print -delete 2>/dev/null | while read -r dir; do
        printf "%bDeleted empty directory: %s%b\n" "$GREEN" "$dir" "$NC"
    done

    if [ $? -eq 0 ]; then
        printf "%bFinished deleting files and empty directories%b\n" "$GREEN" "$NC"
    else
        printf "%bError deleting files or directories from ~/Downloads%b\n" "$RED" "$NC"
        echo "----------------------------------------------"
        exit 1
    fi
    echo "----------------------------------------------"
}

clean_downloads


