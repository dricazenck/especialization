CREATE KEYSPACE candidatos with placement_strategy = 'org.apache.cassandra.locator.SimpleStrategy' and strategy_options = {replication_factor:1};
USE candidatos;

CREATE COLUMN FAMILY diarias
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: codigo_orgao_superior, validation_class: UTF8Type}
{column_name: nome_orgao_superior, validation_class: UTF8Type}
{column_name: codigo_orgao_subordinado, validation_class: UTF8Type}
{column_name: nome_orgao_subordinado, validation_class: UTF8Type}
{column_name: codigo_unidade_gestora, validation_class: UTF8Type}
{column_name: unidade_gestora, validation_class: UTF8Type}
{column_name: codigo_funcao, validation_class: UTF8Type}
{column_name: nome_funcao, validation_class: UTF8Type}
{column_name: codigo_Subfuncao, validation_class: UTF8Type}
{column_name: nome_subuncao, validation_class: UTF8Type}
{column_name: codigo_programa, validation_class: UTF8Type}
{column_name: nome_programa, validation_class: UTF8Type}
{column_name: codigo_acao, validation_class: UTF8Type}
{column_name: nome_acao, validation_class: UTF8Type}
{column_name: linguagem_cidada, validation_class: UTF8Type}
{column_name: cpf_favorecido, validation_class: UTF8Type}
{column_name: nome_favorecido, validation_class: UTF8Type, index_type: KEYS}
{column_name: documento, validation_class: UTF8Type}
{column_name: pagamento, validation_class: UTF8Type}
{column_name: gestao_pagamento, validation_class: UTF8Type}
{column_name: data_pagamento, validation_class: UTF8Type, index_type: KEYS}
{column_name: valor_pagamento, validation_class: UTF8Type}
];

CREATE COLUMN FAMILY leis_municipais
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: link, validation_class: UTF8Type}
{column_name: conteudo, validation_class: UTF8Type, index_type: KEYS}
];

CREATE COLUMN FAMILY leis_estaduais
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: conteudo, validation_class: UTF8Type, index_type: KEYS}
];

CREATE COLUMN FAMILY diario_oficial
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: conteudo, validation_class: UTF8Type, index_type: KEYS}
];

CREATE COLUMN FAMILY tramitacoes
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: proposicao, validation_class: UTF8Type}
{column_name: autor, validation_class: UTF8Type, index_type: KEYS}
{column_name: ementa, validation_class: UTF8Type, index_type: KEYS}
{column_name: data, validation_class: UTF8Type}
{column_name: url_lei, validation_class: UTF8Type}
{column_name: url_tramitacao, validation_class: UTF8Type}
];

CREATE COLUMN FAMILY despesas
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: candidato, validation_class: UTF8Type}
{column_name: data, validation_class: UTF8Type, index_type: KEYS}
{column_name: tipo, validation_class: UTF8Type}
{column_name: valor, validation_class: UTF8Type}
{column_name: fornecedor, validation_class: UTF8Type}
{column_name: cnpj, validation_class: UTF8Type}
];

CREATE COLUMN FAMILY receitas
WITH comparator = UTF8Type
AND key_validation_class=UTF8Type
AND column_metadata = [
{column_name: key, validation_class: UTF8Type}
{column_name: candidato, validation_class: UTF8Type}
{column_name: data, validation_class: UTF8Type, index_type: KEYS}
{column_name: valor, validation_class: UTF8Type}
{column_name: cnpj, validation_class: UTF8Type}
{column_name: numero_candidato, validation_class: UTF8Type}
{column_name: partido, validation_class: UTF8Type}
{column_name: cidade, validation_class: UTF8Type}
];
