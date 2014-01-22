#!/bin/bash

for i in {1..2073}
do
z=$(((i-1)*10))
wget -q --no-check-certificate "https://www.leismunicipais.com.br/cgi-local/topsearch.pl?id_cidade=4571&city=Florian%F3polis&state=sc&tp=&page_this=$i&block=${z}&search_all=1&ementaouintegra=naintegra&FLORIAN%D3POLIS" -O /mnt/script/tmp.html

#cat /tmp/work.txt
echo "https://www.leismunicipais.com.br/cgi-local/topsearch.pl?id_cidade=4571&city=Florian%F3polis&state=sc&tp=&page_this=$i&block=${z}&search_all=1&ementaouintegra=naintegra&wordkey=%%%"
lynx -dump -listonly /mnt/script/tmp.html | grep -e 'a/sc' | cut -d ' ' -f4 | sed -e s_file:..localhost__g > /mnt/script/tmp_ok.txt
#cat /mnt/script/tmp_ok.txt
j=0
while read -r line
do
   echo "${i}-${j} - " $line
   wget -q --no-check-certificate "https://www.leismunicipais.com.br${line}" -O /mnt/dados/leismunicipais/leis/${i}-${j}.html

   j=$((j+1))
   sleep 4

   #wget $line
done < /mnt/script/tmp_ok.txt
rm /mnt/script/tmp_ok*.*
done

