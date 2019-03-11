#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR

pathfile="../repositories.txt"

cd ../microservices

while IFS="" read -r REPO || [ -n "$REPO" ]
do
  if [ -d $REPO ]
    then
      cd $REPO
      git pull origin master
      cd ..
    else
      git clone https://github.com/dabops/"$REPO".git
    fi
done < "$pathfile"
