#! /bin/bash

# Recursively go through all directories and see if they are git

a=() 
for d in */; do
    if [ -d "$d/.git" ]; then
        #echo "Directory $d is a git repo"
        a+=($d)
    fi
done

#print all the git repos
echo "Git repos :" ${a[@]}
for d in ${a[@]}; do
    cd $d
    if [ -n "$(git status --porcelain)" ] && ! git diff --quiet; then
        echo "----------------------------"
        echo "In $d"
        git diff --name-status
        echo "Out of $d"
        echo "----------------------------"
    fi
    cd ..
done
