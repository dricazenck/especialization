
#pegar urls das leis municipais
lynx -dump -listonly *.html | grep -e 'a/sc' | cut -d ' ' -f4 | sed -e s_file:..localhost__g | sort | uniq 

#recuperar qtd links pdf
grep "arquivos/diario/pdf/"  *.txt | cut -d: -f2 | sort | wc -l

#recupera link pdf
grep "arquivos/diario/pdf/"  *.txt | cut -d: -f2 | sort | uniq | grep -Po "arquivos.*.pdf"

#pesquisa por string ignore case em diretorio
grep -R -i "FLORIANÓPOLIS " diario_oficial    

#converter pdf's to txt
for file in *.pdf; do pdftotext "$file" ../pdf_txt/"$file.txt"; done

#converte iso to utf
for a in $(find . -name "*.html"); do iconv -f iso-8859-1 -t utf-8 <"$a" >../utf/"$a" ; done

#pega as pessoas que tem algo em diario oficial
cat /mnt/dados/diario_oficial/pdf_txt/*.txt | grep -i "ABDO ALBERTO FRANCO ABDALLA"

#quantidade de arquivos importadas
watch 'find /mnt/dados/leismunicipais/dados -maxdepth 1 -type f | wc -l'

#verifica as paginas sendo importadas
watch 'ls -l | grep 0.html'

#Alesc files - URL
http://200.192.66.20/alesc/docs/

#get files apache  (Alesc)
wget -e robots=off -r -nd -np http://200.192.66.20/alesc/docs/ 

#mover todos os docs para um unico diretorio
find . -name '*.doc' -exec mv {} all_files_doc \

#cop tramitação alesc
curl 'http://www.alesc.sc.gov.br/proclegis/tramitacao.php' -H 'Cookie: PHPSESSID=7o8fo9qeh4k9ul5hgaira2d3h3i83281' -H 'Origin: http://www.alesc.sc.gov.br' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: www.alesc.sc.gov.br' -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4,ca;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: http://www.alesc.sc.gov.br/proclegis/tramitacao.php' -H 'Connection: keep-alive' --data 'Ano=&Assunto=&SiglaProp=&Status01=&Status02=&CodProced=&DepartCod=&PropNum=&Autor=&PropTramitando=3&DataInicial=&DataFinal=&TipoApresentacao=3&Pagina=1233' --compressed

#extrai somente os códigos do candidatos
cat *.xml | grep -R 'sqCand' | grep -oP '[0-9]+' > /mnt/dados/prestacao_contas/codigos_candidatos_sc.txt

cat /mnt/arquiov/xuxu.xml | grep 'sqCand' | grep -oP '[0-9]+' > /mnt/dados/prestacao_contas/codigos_candidatos_sc.txt