#!/bin/bash

#docs to txt
FILES=/mnt/dados/alesc/all_files_doc/*
for f in $FILES
do
  echo "$f"
  catdoc -s 8859-1 $f > "${f}.txt"
done

#txt to csv
rm /mnt/dados/alesc/alesc.csv
counter=0
for f in /mnt/dados/alesc/leis/txt/*
do
	tr '\n' ' ' < $f >> /mnt/dados/alesc/alesc.csv
	echo '^'$counter >> /mnt/dados/alesc/alesc.csv

	echo $counter
	counter=$((counter+1))
done 
