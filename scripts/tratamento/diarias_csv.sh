#!/bin/bash

rm /mnt/dados/diarias/diarias.csv

counter=1
for f in /mnt/dados/diarias/utf-8/*
do
	cat $f | while read line; 
	do
		echo $counter
        echo $counter"	"$line >> /mnt/dados/diarias/diarias.csv
        counter=$((counter+1))
	done
	
done 
