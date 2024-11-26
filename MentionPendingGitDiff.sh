#! /bin/bash

# Recursively go through all directories and see if they are git

a=() 
for d in $(find . -type d 2>/dev/null); do
    if [ -d "$d/.git" ]; then
        #echo "Directory $d is a git repo"
        a+=($d)
    fi
done

#print all the git repos
#echo "Git repos :" ${a[@]}
for d in ${a[@]}; do
    pushd $d > /dev/null
    if [ -n "$(git status --porcelain 2>/dev/null)" ] && ! git diff --quiet 2>/dev/null; then
        echo "In  Repo :$d"
        git diff --name-status 2>/dev/null
        echo "Out of Repo : $d"
        echo "----------------------------"
    fi
    popd > /dev/null
done

