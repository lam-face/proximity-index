# Índice de Similaridade entre Ocupações da CBO

## O índice

O Índice de Similaridade é uma ferramenta que visa a avaliar a proximidade entre ocupações do mercado de trabalho brasileiro. A sua construção leva em consideração a descrição das tarefas realizadas das ocupações listadas na Classificação Brasileira de Ocupações (CBO) de 4 dígitos e busca sintetizar o quanto que duas ocupações podem ser consideradas próximas segundo a lista de tarefas esperadas por cada uma delas.

Para consultar os detalhes relativos à construção do indicador, foi elaborada uma [nota técnica](https://lam.face.ufg.br/) explicando o passo a passo de sua elaboração.

## Matriz de distância entre ocupações

Um dos produtos do trabalho é uma matriz de distância entre duas ocupações. Uma de suas considerações é que o nível de dificuldade para um profissional da ocupação A executar as tarefas do posto de trabalho B pode não ser o mesmo de B para a ocupação A. Dessa forma, a similaridade entre pares de ocuapações não é simétrica, caracterizando melhor a rigidez de mobilidade do mercado de trabalho e seus custos de transição entre postos de trabalho.

A matriz pode ser consultada [aqui](https://lam.face.ufg.br/).

## Organização do repositório

Este repositório é pensado para facilitar a divulgação dos códigos utilizados para a construção do índice e incentivamos a colaboração. Eles estão dispostos na pasta "Stata", que possui os seguintes arquivo:

* Indice_de_Proximidade_abr_2024.do: **adicionar descrição**
* CBO2002 - PerfilOcupacional 2023.csv: **adicionar descrição**
* Classificar_Grupos_Tarefas.do: **adicionar descrição**
* Correcao_portugues.do: **adicionar descrição**
* Nomes_Ocupacoes.do: **adicionar descrição**
* Quant_tarefas.do: **adicionar descrição**

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

