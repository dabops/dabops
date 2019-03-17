#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR
pathfile="../repositories.txt"

if [ ! -d "../microservices" ]
    then
        mkdir ../microservices
fi
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
    if [ ! -d "hooks" ]
        then
            mkdir hooks
            git config core.hooksPath hooks/
      fi
      cp ../../tools/generate_doc.sh hooks/pre-push
      chmod u+x hooks/pre-push
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
