# Índice de Similaridade entre Ocupações da CBO

## O índice

O Índice de Similaridade é uma ferramenta que visa a avaliar a proximidade entre ocupações do mercado de trabalho brasileiro. A sua construção leva em consideração a descrição das tarefas realizadas das ocupações listadas na Classificação Brasileira de Ocupações (CBO) de 4 dígitos e busca sintetizar o quanto que duas ocupações podem ser consideradas próximas segundo a lista de tarefas esperadas por cada uma delas.

Para consultar os detalhes relativos à construção do indicador, foi elaborada uma [nota técnica](https://lam.face.ufg.br/) explicando o passo a passo de sua elaboração.

## Matriz de distância entre ocupações

Um dos produtos do trabalho é uma matriz de distância entre duas ocupações. Uma de suas considerações é que o nível de dificuldade para um profissional da ocupação A executar as tarefas do posto de trabalho B pode não ser o mesmo de B para a ocupação A. Dessa forma, a similaridade entre pares de ocuapações não é simétrica, caracterizando melhor a rigidez de mobilidade do mercado de trabalho e seus custos de transição entre postos de trabalho.

A matriz pode ser consultada [aqui](https://data.mendeley.com/datasets/vstnv3vdns/1).

## Organização do repositório

Este repositório é pensado para facilitar a divulgação dos códigos utilizados para a construção do índice e incentivamos a colaboração. Eles estão dispostos na pasta "Stata", que possui os seguintes arquivo:

* Indice_de_Proximidade_abr_2024.do: Arquivo da extensão .do principal do repositório e é ele quem deve ser rodado para calcular o índice.
* CBO2002 - PerfilOcupacional 2023.csv: Arquivo da extensão .csv que está organizado de acordo com as atividades executadas de cada ocupação. As colunas contêm os códigos do grande grupo, do subgrupo principal, do subgrupo, da família e da ocupação de acordo com a atualização da CBO de junho de 2023, bem como a sigla da grande área, o nome da grande área, o código da atividade e o nome da atividade.
* Classificar_Grupos_Tarefas.do: Arquivo da extensão .do que classifica as tarefas descritas na CBO em 21 tipos e em 3 naturezas (cognitiva, manual e rotineira).
* Correcao_portugues.do: Arquivo da extensão .do que executa as correções e padronizações de português, conforme descrito na seção 4 da nota técnica.
* Nomes_Ocupacoes.do: Arquivo da extensão .do que atribui o nome às ocupações de destino e de origem na matriz de distância.
* Quant_tarefas.do: Arquivo da extensão .dta que conta quantas tarefas cada ocupação tem, segregando para os 21 tipos e para as 3 naturezas (cognitiva, manual e rotineira).

**É necessário que todos esses arquivos estejam na mesma pasta no momento de execução**

## Próximos passos

Além de eventuais correções e atualizações conforme a CBO for adicionando novas ocupações, os próximos passos consistem em:

* Adicionar códigos em R e Python;

## Contatos

Caso tenha alguma colaboração, não hesite de entrar em contato com algum dos autores listados abaixo:  
LAM - lam.face@ufg.br  
Sandro Eduardo Monsueto - monsueto@ufg.br  
Felipe Pureza Cardoso - felpureza@cedeplar.ufmg.br  
Alícia Araújo Amaral de Oliveira - aliciaaraujo@discente.ufg.br  

