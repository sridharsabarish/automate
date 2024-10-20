#!/bin/bash
if [ -z "$1" ]
    then
        echo "No repo supplied"
        exit 1
fi

if [ -z "$2" ]
    then
        echo "No commit message supplied"
        exit 1
fi

cd $1
git add .
git commit -m "$2"
git push
cd ..