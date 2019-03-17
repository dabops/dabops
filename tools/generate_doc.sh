#!/bin/bash

#npm install -g jsdoc-to-markdown

# Get all jsfile
list=$(find . -type d \( -path ./.git -o -path ./node_modules  \) -prune -o  -name "*.js" -print)

#Generate doc
jsdoc2md $list > wiki/Home.md
echo "---------- Doc created ----------"

# Push it on wiki
cd wiki
git add Home.md
git commit -m "documentation updated"
git push origin master
cd ..