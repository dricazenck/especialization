#!/bin/bash

rm /mnt/dados/leismunicipais/leismunicipais.csv
rm /mnt/dados/leismunicipais/leisordenadas.csv

counter=1
for f in /mnt/dados/leismunicipais/dados/*.html
do
	COLUNA1=$(cat $f | head -n356 | tail -n1 | grep -Po 'http[^"]*') 
	COLUNA2=$(cat $f | head -n378 | tail -n1 | iconv -f iso-8859-1 -t UTF-8) 

	if [ -n "$COLUNA2" ]; then
		if [ -n "$COLUNA1" ]; then
	    	echo $counter"^"$COLUNA1"^"$COLUNA2 >> /mnt/dados/leismunicipais/leismunicipais.csv
	    	echo $counter
	    	counter=$((counter+1))
		fi
	fi
done 

for f in /mnt/dados/leismunicipais/leis/*.html
do
	COLUNA1=$(cat $f | head -n365 | tail -n1 | grep -Po 'http[^"]*') 
	COLUNA2=$(cat $f | head -n387 | tail -n1 | iconv -f iso-8859-1 -t UTF-8) 
	
	if [ -n "$COLUNA2" ]; then
		if [ -n "$COLUNA1" ]; then
	    	echo $counter"^"$COLUNA1"^"$COLUNA2 >> /mnt/dados/leismunicipais/leismunicipais.csv
	    	echo $counter
	    	counter=$((counter+1))
		fi
	fi
	
done 

cat /mnt/dados/leismunicipais/leismunicipais.csv | sort | uniq > /mnt/dados/leismunicipais/leisordenadas.csv