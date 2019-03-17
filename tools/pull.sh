#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR
pathfile="../repositories.txt"

mkdir ../microservices
cd ../microservices

## FUNCTIONS ##

## Wiki - if it exists pull, else create it
wiki()
{
    if [ -d "wiki" ]
      then
        cd "wiki"
        git pull origin master
        cd ..
      else
        git clone https://github.com/dabops/"$REPO".wiki.git
        mv "$REPO".wiki wiki
  fi
}

generate_doc()
{
    if [ ! -d "tools" ]
        then
            mkdir tools
      fi
      cp ../../tools/generate_doc.sh tools/
      chmod u+x tools/generate_doc.sh
}


## MAIN ##

while IFS="" read -r REPO || [ -n "$REPO" ]
do
  if [ -d $REPO ]
    then
      cd $REPO
      git pull origin master
      generate_doc
      wiki
      cd ..
    else
      git clone https://github.com/dabops/"$REPO".git
      cd $REPO
      generate_doc
      wiki
      cd ..
    fi
done < "$pathfile"
