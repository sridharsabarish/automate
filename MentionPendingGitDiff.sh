#! /bin/bash

log_info()    { echo "[INFO]  $(date '+%Y-%m-%d %H:%M:%S') - $*"; }
log_warn()    { echo "[WARN]  $(date '+%Y-%m-%d %H:%M:%S') - $*" >&2; }
log_error()   { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $*" >&2; }
# Recursively go through all directories and see if they are git

function find_all_git_repos() {
    local a=() 
    for d in $(find . -type d 2>/dev/null); do
        if [ -d "$d/.git" ]; then
            #echo "Directory $d is a git repo"
            a+=($d)
        fi
    done
    echo ${a[@]}
}

function check_pending_git_diff() {
    local git_repos=($(find_all_git_repos))
    for d in ${git_repos[@]}; do
        pushd $d > /dev/null
        if [ -n "$(git status --porcelain 2>/dev/null)" ] && ! git diff --quiet 2>/dev/null; then
            log_info "In Repo : $d "
            cd $d
            if git diff --name-status 2>/dev/null; then
                read -p "Changes detected. Do you want to view the changes? (y/n) " choice
                if [ "$choice" == "y" ]; then
                    git diff
                fi

                read -p "Do you want to commit the changes? (y/n) " commit_choice
                if [ "$commit_choice" == "y" ]; then
                    read -p "Enter commit message: " commit_msg
                    git add -u
                    git commit -m "$commit_msg" && git push
                fi
            fi
            cd -


            # log_error "Out of Repo : $d "
            log_info "------------------------------------------------------------------------------------------------------------------------"
        fi
        popd > /dev/null
    done
}

check_pending_git_diff