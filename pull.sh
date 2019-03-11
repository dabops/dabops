#!/bin/bash

val=("thermometer" "clock" "tictactoe" "mocaccino")

cd microservices

for repot in "${val[@]}" ;
do
	if [ -d $repot ]
	then
	    cd $repot
	    git pull origin master
	    cd ..
	else
		    git clone https://github.com/dabops/"$repot".git
	fi
done