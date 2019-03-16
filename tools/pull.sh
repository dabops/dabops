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

      # IF WIKI repot exists
      if [ -d "wiki" ]
          then
            cd "wiki"
            git pull origin master
            cd ..
          else
            git clone https://github.com/dabops/"$REPO".wiki.git
            mv "$REPO".wiki wiki
      fi
      cd ..
    else
      git clone https://github.com/dabops/"$REPO".git
      cd $REPO
      git clone https://github.com/dabops/"$REPO".wiki.git
      mv "$REPO".wiki wiki
      cd ..
    fi
done < "$pathfile"
