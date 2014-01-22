#!/bin/bash

for file in /mnt/dados/diario_oficial/*.pdf; do pdftotext "$file" /mnt/dados/diario_oficial/pdf_txt/"$file.txt"; done

rm /mnt/dados/diario_oficial/diarios_oficiais_flopis.csv
counter=1
for f in /mnt/dados/diario_oficial/pdf_txt/*
do
	tr '\n' ' ' < $f >> /mnt/dados/diario_oficial/diarios_oficiais_flopis.csv
	echo '^'$counter >> /mnt/dados/diario_oficial/diarios_oficiais_flopis.csv

	echo $counter
	counter=$((counter+1))
done 
