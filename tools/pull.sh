#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR

pathfile="../repositories.txt"
repositories=()

cd ../microservices
while read REPO
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
