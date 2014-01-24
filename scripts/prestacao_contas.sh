#!/bin/bash

#todos os municipios de SC 
curl 'http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/recuperaMunicipios.action?siglaUf=PA' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: inter01.tse.jus.br' -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4,ca;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/recuperaMunicipios.action?siglaUf=SC' -H 'Cookie: JSESSIONID=E8716DF7EBF7DE4FD40ECF36B625C28A; BIGipServerpool_producao_jboss_sepel2=483174592.36895.0000' -H 'Connection: keep-alive' --compressed > /mnt/dados/prestacao_contas/municipios.xml

#Todos os codigos dos municipios
cat /mnt/dados/prestacao_contas/municipios.xml | grep -R 'value=' | grep -oP '[0-9]+' > /mnt/dados/prestacao_contas/municipios.txt

#Receitas e Despesas por municipio
cat /mnt/dados/prestacao_contas/municipios.txt | while read CIDADE
do
	wget -q --no-check-certificate "http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/candidatoAutoComplete.do?noCandLimpo=&sgUe=${CIDADE}&cdCargo=11&orderBy=cand.NM_CANDIDATO" -O /mnt/dados/prestacao_contas/dados/prefeito.xml
	wget -q --no-check-certificate "http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/candidatoAutoComplete.do?noCandLimpo=&sgUe=$CIDADE&cdCargo=12&orderBy=cand.NM_CANDIDATO" -O /mnt/dados/prestacao_contas/dados/vice.xml
	wget -q --no-check-certificate "http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/candidatoAutoComplete.do?noCandLimpo=&sgUe=$CIDADE&cdCargo=13&orderBy=cand.NM_CANDIDATO" -O /mnt/dados/prestacao_contas/dados/vereador.xml

	cat /mnt/dados/prestacao_contas/dados/prefeito.xml | grep 'sqCand' | grep -oP '[0-9]+' > /mnt/dados/prestacao_contas/todos_codigos.txt
	
	cat /mnt/dados/prestacao_contas/dados/vice.xml | grep 'sqCand' | grep -oP '[0-9]+' >> /mnt/dados/prestacao_contas/todos_codigos.txt

	cat /mnt/dados/prestacao_contas/dados/vereador.xml | grep 'sqCand' | grep -oP '[0-9]+' >>/mnt/dados/prestacao_contas/todos_codigos.txt

	count=0
	cat /mnt/dados/prestacao_contas/todos_codigos.txt | while read CANDIDATO
	do
		curl 'http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/resumoReceitasByCandidato.action' -H 'Cookie: JSESSIONID=E8716DF7EBF7DE4FD40ECF36B625C28A; BIGipServerpool_producao_jboss_sepel2=483174592.36895.0000' -H 'Origin: http://inter01.tse.jus.br' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: inter01.tse.jus.br' -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4,ca;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/abrirTelaReceitasCandidato.action' -H 'Connection: keep-alive' --data 'sqCandidato='$CANDIDATO'&sgUe='$CIDADE'&rb1=on&rbTipo=on&tipoEntrega=0&nrCandidato=&nmCandidato=&sgUfMunicipio=&sgPartido=&nomeDoador=&cpfCnpjDoador=&action%3AresumoReceitasByCandidato=Resumo' --compressed > /mnt/dados/prestacao_contas/todos_receitas/$CIDADE"_"$CANDIDATO".html"

		curl 'http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/resumoDespesasByCandidato.action' -H 'Cookie: JSESSIONID=E8716DF7EBF7DE4FD40ECF36B625C28A; BIGipServerpool_producao_jboss_sepel2=483174592.36895.0000' -H 'Origin: http://inter01.tse.jus.br' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: inter01.tse.jus.br' -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4,ca;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: http://inter01.tse.jus.br/spceweb.consulta.receitasdespesas2012/resumoDespesasByCandidato.action?sqCandidato='$CANDIDATO'&sgUe=81051&filtro=S' -H 'Connection: keep-alive' --data 'sqCandidato='$CANDIDATO'&sgUe='$CIDADE'&rb1=on&rbTipo=on&tipoEntrega=0&nrCandidato=&nmCandidato=&sgUfMunicipio=&sgPartido=&nomeFornecedor=&cpfCnpjFornecedor=&action%3AresumoDespesasByCandidato=Resumo' --compressed > /mnt/dados/prestacao_contas/todos_despesas/$CIDADE"_"$CANDIDATO".html"
	    
	    count=$((count+1))
	    echo "$count"

	done
done
