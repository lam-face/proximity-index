/*
ÍNDICE DE SIMILARIDADE TÉCNICA ENTRE OCUPAÇÕES
	- Referência: MONSUETO, S.E.; CARDOSO, F.P.; OLIVEIRA, A.A.A. Um índice de similaridade entre ocupações da CBO. Textos para Discussão do Curso de Ciências Econômicas n. 101. Goiânia: Curso de Ciências Econômicas/FACE, 2024.
	- CBO/RAIS

Versão Abr/2023:
 - Atualizada a base de dados da CBO para Jun/2023
 - Indice_Proximidade.DTA
 - Requer Stata 11 ou superior
 */

// 1) PREPARAÇÃO INICIAL DA PASTA DE TRABALHO
* Configurar a pasta de trabalho
clear
cd "d:/Indice"
*** Certifique-se que todos os arquivos abaixo estão nesta mesma pasta
	* Indice_de_Similaridade_abr_2024.do (este arquivo) // Arquivo principal que faz o gerenciamento dos demais e cria o índice.
	* Classificar_Grupos_Tarefas.do // Arquivo com a classificação das tarefas em 21 tipos e 3 grupos de natureza (cognitivas, rotineias e manuais).
	* Correcao_portugues.do // Implementa correções ortográficas em verbos e sujeitos e padroniza para o singular
	* Nomes_Ocupacoes.do // Contém os nomes das ocupações a 4 dígitos.
	* ESTRUTURA CBO\CBO2002 - PerfilOcupacional 2023.csv // Arquivo original da CBO com a descrição das tarefas.
 

// 2) IMPORTAÇÃO DA BASE DE TAREFAS (Jun/2023)
* Importar
import delimited "CBO2002 - PerfilOcupacional 2023.csv", clear
capture drop v10 v11
* Configurar ocupações a quatro dígitos (Famílias Ocupacionais)
	* acrescentando um zero na frente das ocupações de famílias com três dígitos
tostring cod_familia, gen(familia_str)
gen zero = "0"
egen ocupacao4d = concat(zero familia_str)
replace ocupacao4d = familia_str if cod_familia>400
drop zero
* Numerando as ocupações
encode ocupacao4d, gen(nocupacao)
label var ocupacao4d "Ocupações a 4 dígitos - string"
label var nocupacao "Ocupações a 4 dígitos - numeração"
* Grupo principal de ocupações (ocupações a 2 dígitos)
gen grupo_principal = substr(ocupacao4d,1,2)
label var grupo_principal "Ocupações a 2 dígitos"


// 3) CLASSIFICAR AS TAREFAS USANDO O NOME DA GRANDE ÁREA
include "Classificar_Grupos_Tarefas.do"
* Deixando uma linha por tarefa (nome_atividade) para cada ocupação de quatro dígitos
bys ocupacao4d tipo nome_atividade: gen j=_n
drop if j>1
drop j

// 4) TRATAMENTO DAS DESCRIÇÕES DAS TAREFAS
	/*
	Retirar acentuação e caracteres especiais
	Retirar palavras de ligação e outras correções
	*/
gen tarefa = nome_atividade
* passar para maiúsculas
replace tarefa = ustrupper(tarefa)
* caracteres especiais (substituir por espaço em branco)
replace tarefa = ustrregexra(tarefa,","," ")
replace tarefa = ustrregexra(tarefa,"\("," ")
replace tarefa = ustrregexra(tarefa,"\)"," ")
replace tarefa = ustrregexra(tarefa,"\."," ")
replace tarefa = ustrregexra(tarefa,"\*"," ")
replace tarefa = ustrregexra(tarefa,"/"," ")
replace tarefa = ustrregexra(tarefa,"'"," ")
replace tarefa = ustrregexra(tarefa,`"""'," ")
replace tarefa = ustrregexra(tarefa,"´"," ")
replace tarefa = ustrregexra(tarefa,"-"," ")
replace tarefa = ustrregexra(tarefa,":"," ")
* retirada de acentos
replace tarefa = ustrregexra(tarefa,"Á", "A",.)
replace tarefa = ustrregexra(tarefa,"À", "A",.)
replace tarefa = ustrregexra(tarefa,"Ã", "A",.)
replace tarefa = ustrregexra(tarefa,"Â", "A",.)
replace tarefa = ustrregexra(tarefa,"É", "E",.)
replace tarefa = ustrregexra(tarefa,"Ê", "E",.)
replace tarefa = ustrregexra(tarefa,"Í", "I",.)
replace tarefa = ustrregexra(tarefa,"Ì", "I",.)
replace tarefa = ustrregexra(tarefa,"Ó", "O",.)
replace tarefa = ustrregexra(tarefa,"Ô", "O",.)
replace tarefa = ustrregexra(tarefa,"Õ", "O",.)
replace tarefa = ustrregexra(tarefa,"Ü", "U",.)
replace tarefa = ustrregexra(tarefa,"Ú", "U",.)
* palavras de ligação ou fechamento
replace tarefa = subinword(tarefa,"OU","",.)
replace tarefa = subinword(tarefa,"ETC","",.)
replace tarefa = subinword(tarefa, "A", "",.)
replace tarefa = subinword(tarefa, "E", "",.)
replace tarefa = subinword(tarefa, "I", "",.)
replace tarefa = subinword(tarefa, "O", "",.)
replace tarefa = subinword(tarefa, "U", "",.)
replace tarefa = subinword(tarefa, "COM", "",.)
replace tarefa = subinword(tarefa, "X", "",.)
replace tarefa = subinword(tarefa, "DA", "",.)
replace tarefa = subinword(tarefa, "DE", "",.)
replace tarefa = subinword(tarefa, "DO", "",.)
replace tarefa = subinword(tarefa, "DAS", "",.)
replace tarefa = subinword(tarefa, "DOS", "",.)
replace tarefa = subinword(tarefa, "NA", "",.)
replace tarefa = subinword(tarefa, "NO", "",.)
replace tarefa = subinword(tarefa, "NAS", "",.)
replace tarefa = subinword(tarefa, "NOS", "",.)
replace tarefa = subinword(tarefa, "AO", "",.)
replace tarefa = subinword(tarefa, "AOS", "",.)
replace tarefa = subinword(tarefa, "COMO", "",.)
replace tarefa = subinword(tarefa, "EM", "",.)
replace tarefa = subinword(tarefa, "AS", "",.)
replace tarefa = subinword(tarefa, "OS", "",.)
replace tarefa = subinword(tarefa, "BOM", "",.)
replace tarefa = subinword(tarefa, "BONS", "",.)
replace tarefa = subinword(tarefa, "BOA", "",.)
replace tarefa = subinword(tarefa, "BOAS", "",.)
replace tarefa = subinword(tarefa, "ATE", "",.)
replace tarefa = subinword(tarefa, "ON", "",.)
replace tarefa = subinword(tarefa, "NUM", "",.)
replace tarefa = subinword(tarefa, "SUA", "",.)
replace tarefa = subinword(tarefa, "SUAS", "",.)
replace tarefa = subinword(tarefa, "SEU", "",.)
replace tarefa = subinword(tarefa, "SEUS", "",.)
replace tarefa = subinword(tarefa, "UM", "",.)
replace tarefa = subinword(tarefa, "UMA", "",.)
replace tarefa = subinword(tarefa, "UNS", "",.)
replace tarefa = subinword(tarefa, "UMAS", "",.)
* espaços em branco
replace tarefa = stritrim(tarefa)
replace tarefa = strtrim(tarefa)
* Correção de palavras unificadas ou abreviadas
replace tarefa = ustrregexra(tarefa,"COBRIRINFORMAÇOES", "COBRIR INFORMAÇOES",.)
replace tarefa = subinword(tarefa, "RF", "RESPONSAVEL",.) // rf = responsável pela família
replace tarefa = subinword(tarefa, "ACELERAR DESACELERAR IMAGENS", "ACELERAR IMAGENS",.)
* Tarefas sem verbo (substituir pelo verbo da grande área)
replace tarefa = "DEMONSTRAR INICIATIVA" if tarefa=="INICIATIVA"
replace tarefa = "DEMONSTRAR DESTREZA MANUAL" if tarefa=="DESTREZA MANUAL"
replace tarefa = "PRESTAR ASSESSORIA MANUTENÇAO SISTEMA" if tarefa=="ASSESSORIA MANUTENÇAO SISTEMA"
replace tarefa = "DEMONSTRAR MEMORIA VISUAL FISIONOMICA" if tarefa=="MEMORIA VISUAL FISIONOMICA"
replace tarefa = "DEMONSTRAR CLAREZA" if tarefa=="CLAREZA"
replace tarefa = "DEMONSTRAR ACUIDADE VISUAL" if tarefa=="ACUIDADE VISUAL"
replace tarefa = "DEMONSTRAR ADAPTABILIDADE" if tarefa=="ADAPTABILIDADE"
replace tarefa = "DEMONSTRAR ANALISE SINTESE" if tarefa=="ANALISE SINTESE"
replace tarefa = "DEMONSTRAR CAPACIDADE PERCEPÇAO SITUACIONAL" if tarefa=="CAPACIDADE PERCEPÇAO SITUACIONAL"
replace tarefa = "DEMONSTRAR CONTROLE EMOCIONAL" if tarefa=="CONTROLE EMOCIONAL"
replace tarefa = "DEMONSTRAR FLEXIBILIDADE RACIOCINIO" if tarefa=="FLEXIBILIDADE RACIOCINIO"
replace tarefa = "DEMONSTRAR IMPARCIALIDADE" if tarefa=="IMPARCIALIDADE"
replace tarefa = "DEMONSTRAR LEALDADE" if tarefa=="LEALDADE"
replace tarefa = "DEMONSTRAR OBJETIVIDADE" if tarefa=="OBJETIVIDADE"
replace tarefa = "DEMONSTRAR ATENÇAO FOCADA DIFUSA" if tarefa=="ATENÇAO FOCADA DIFUSA"
replace tarefa = "DEMONSTRAR COMPREENSAO OUTROS IDIOMAS" if tarefa=="COMPREENSAO OUTROS IDIOMAS"
replace tarefa = "DEMONSTRAR COMUNICAÇAO" if tarefa=="COMUNICAÇAO"
replace tarefa = "DEMONSTRAR DISCRIÇAO" if tarefa=="DISCRIÇAO"
replace tarefa = "DEMONSTRAR ORGANIZAÇAO" if tarefa=="ORGANIZAÇAO"
replace tarefa = "REALIZAR PARTICIPAÇAO PROGRAMAS ORIENTAÇAO PROFISSIONAL" if tarefa=="PARTICIPAÇAO PROGRAMAS ORIENTAÇAO PROFISSIONAL"
replace tarefa = "DEMONSTRAR RESOLUÇAO PROBLEMAS" if tarefa=="RESOLUÇAO PROBLEMAS"
replace tarefa = "DEMONSTRAR TRABALHO EQUIPE" if tarefa=="TRABALHO EQUIPE"
replace tarefa = "PREPARAR AMOSTRAS POR VIA UMIDA" if tarefa=="AMOSTRAS POR VIA UMIDA"
replace tarefa = "DEMONSTRAR RAPIDEZ RACIOCINIO" if tarefa=="RAPIDEZ RACIOCINIO"
replace tarefa = "DEMONSTRAR CAPACIDADE CUMPRIR NORMAS REGRAS" if tarefa=="CAPACIDADE CUMPRIR NORMAS REGRAS"
replace tarefa = "DEMONSTRAR CAPACIDADE TRABALHAR GRANDES ALTURAS" if tarefa=="CAPACIDADE TRABALHAR GRANDES ALTURAS"
replace tarefa = "DEMONSTRAR CAPACIDADE VISAO SISTEMICA" if tarefa=="CAPACIDADE VISAO SISTEMICA"
replace tarefa = "DEMONSTRAR CAPACIDADE ASSUMIR RESPONSABILIDADES" if tarefa=="CAPACIDADE ASSUMIR RESPONSABILIDADES"
replace tarefa = "DEMONSTRAR CAPACIDADE SENSO CRITICO" if tarefa=="CAPACIDADE SENSO CRITICO"
replace tarefa = "DEMONSTRAR CAPACIDADE SINTESE" if tarefa=="CAPACIDADE SINTESE"
replace tarefa = "DEMONSTRAR CAPACIDADE ARTICULAÇAO" if tarefa=="CAPACIDADE ARTICULAÇAO"
replace tarefa = "DEMONSTRAR CAPACIDADE SENSORIAL" if tarefa=="CAPACIDADE SENSORIAL"
replace tarefa = "DEMONSTRAR CAPACIDADE CONCENTRAÇAO" if tarefa=="CAPACIDADE CONCENTRAÇAO"
replace tarefa = "DEMONSTRAR CAPACIDADE LIDERANÇA" if tarefa=="CAPACIDADE LIDERANÇA"
replace tarefa = "DEMONSTRAR CAPACIDADE COMUNICAÇAO" if tarefa=="CAPACIDADE COMUNICAÇAO"
replace tarefa = "DEMONSTRAR CAPACIDADE SENSO ANALITICO" if tarefa=="CAPACIDADE SENSO ANALITICO"
replace tarefa = "DEMONSTRAR CAPACIDADE FORMULAÇAO TEORICA" if tarefa=="CAPACIDADE FORMULAÇAO TEORICA"
replace tarefa = "DEMONSTRAR CAPACIDADE TRABALHAR SOB PRESSAO" if tarefa=="CAPACIDADE TRABALHAR SOB PRESSAO"
replace tarefa = "DEMONSTRAR CAPACIDADE OBSERVAÇAO" if tarefa=="CAPACIDADE OBSERVAÇAO"
replace tarefa = "DEMONSTRAR RAPIDEZ REFLEXOS" if tarefa=="RAPIDEZ REFLEXOS"

* Verbos
egen verbo = ends(tarefa)
** Verbos conjugados
split tarefa, parse(" ")
gen traco="-"
egen conjugado=concat(tarefa1 traco tarefa2)
replace verbo = conjugado if verbo=="AUTO"
replace verbo = conjugado if verbo=="CO"
replace verbo = conjugado if verbo=="NAO"
replace verbo = conjugado if verbo=="POS"
replace verbo = conjugado if verbo=="PRE"
replace verbo = conjugado if verbo=="PRO"
replace verbo = conjugado if verbo=="RE"
replace verbo = conjugado if verbo=="SOBRE"
replace verbo = conjugado if verbo=="SUB"

* Tratar verbos com "SE" (Exemplo: "ATUALIZAR-SE" é convertido para "AUTO-ATUALIZAR")
gen auto = "AUTO"
egen se = concat(auto traco tarefa1)
replace verbo = se if tarefa2=="SE"
drop auto se

* Objetos
egen objeto = ends(tarefa), tail
** Objetos para o caso de verbos conjugados
egen objeto2 = ends(objeto), tail
replace objeto = objeto2 if verbo==conjugado
drop tarefa1-conjugado objeto2

* Correções gerais de português
include "Correcao_portugues.do"

* Eliminando pares de verbo+objeto repetido na mesma ocupação
bys ocupacao4d tipo verbo objeto: gen j=_n
drop if j>1
drop j

* Ajustar objeto de duas partes (conjugado)
split objeto, parse(" ")
gen espaco=" "
egen conjugado=concat(objeto1 espaco objeto2)
replace objeto = conjugado
drop objeto1 - espaco

* Codificando verbo e objeto
encode verbo, gen(nverbo)
encode objeto, gen(nobjeto)
gen espaco = " "
egen tarefa_corrigida = concat(verbo espaco objeto)
encode tarefa_corrigida, gen(ntarefa)
label var nverbo "Código do Verbo"
label var nobjeto "Código do Objeto"
label var ntarefa "Código da Tarefa"

* Descartando tarefas muito genéricas e comuns
drop if verbo=="DEMONSTRAR"
drop if tarefa_corrigida=="TRABALHAR EQUIPE"
drop if tarefa_corrigida=="TOMAR DECISAO"

* Preparação final para salvar antes da criação do índice
gen controle=_n
sort nverbo nobjeto
keep nome_atividade nverbo nobjeto ntarefa controle nocupacao ocupacao4d grupo_principal tipo natureza
compress
save "Tarefas.dta", replace


// 5) CRIANDO UM ARQUIVO ADICIONAL COM A QUANTIDADE DE TAREFAS DE CADA OCUPAÇÃO
use "Tarefas.dta", clear
tab tipo, gen(t)
forvalues n=1/21{
	bys nocupacao: egen qtipo`n' = total(t`n')
}
drop t1-t21
tab natureza, gen(natureza)
bys nocupacao: egen qcognitiva = total(natureza1)
bys nocupacao: egen qmanual = total(natureza2)
bys nocupacao: egen qrotineira = total(natureza3)
drop natureza1-natureza3
bys nocupacao: gen n=_n
keep if n==1
gen qtarefas = qcognitiva + qmanual + qrotineira
* Etiquetas
label var qtipo1 "Pesquisar, analisar, avaliar, desenvolver"
label var qtipo2 "Desenhar, planejar, esboçar, projetar, formular"
label var qtipo3 "Executar leis, interpretar leis/regras,"
label var qtipo4 "Negociar, coordenar, fazer lobby, organizar, gerenciar"
label var qtipo5 "Ensinar"
label var qtipo6 "Vender, comprar, aconselhar clientes, fazer propaganda"
label var qtipo7 "Entretenimento, apresentação"
label var qtipo8 "Cálculo, contabilidade, controlar recursos financeiros"
label var qtipo9 "Corrigir texto, corrigir dados, programar, registrar informações, organizar documentos"
label var qtipo10 "Medições, controle de qualidade, executar ensaios"
label var qtipo11 "Operar, controlar e preparar máquinas e equipamentos"
label var qtipo12 "Reparar, renovar e reconstruir máquinas"
label var qtipo13 "Cultivar"
label var qtipo14 "Instalar máquinas, extrair, moldar materiais, cozinhar, construir"
label var qtipo15 "Serviços de limpeza"
label var qtipo16 "Embalar produtos, carregar, entregar."
label var qtipo17 "Servir, acomodar, auxiliar, tratar/cuidar de outros"
label var qtipo18 "Segurança"
label var qtipo19 "Auxiliar, assessorar, apoiar"
label var qtipo20 "Manual"
label var qtipo21 "Interagir, agir, atuar"
label var qcognitiva "Quant. de tarefas cognitivas"
label var qmanual "Quant. de tarefas manuais"
label var qrotineira "Quant. de tarefas rotineiras"
label var qtarefas "Total de tarefas realizadas"
* Nomes das ocupações
gen ocupacao_o=ocupacao4d
capture include "Nomes_Ocupacoes.do"
drop ocupacao_o nome_d
ren nome_o nome_ocupacao
keep ocupacao4d nocupacao nome_ocupacao qtipo1-qtipo21 qcognitiva qmanual qrotineira nome_ocupacao qtarefas
order ocupacao4d nocupacao nome_ocupacao
compress
sort ocupacao4d
save "Quant_tarefas.dta", replace


// 6) CRIANDO ARQUIVOS AUXILIARES
forvalues n = 1/619{
	use "Tarefas.dta", clear
	keep if nocupacao==`n'
	ren ocupacao4d ocupacao_d
	sort tipo nverbo nobjeto
	save "ocup`n'.dta", replace
}
forvalues n = 1/619{
	use "Tarefas.dta", clear
	keep if nocupacao==`n'
	ren ocupacao4d ocupacao_d
	sort grupo_principal tipo nverbo nobjeto
	save "ocup_F`n'.dta", replace
}

// 7) CALCULANDO O ÍNDICE COM OS PESOS
* Índices individuais
forvalues ocup=1/619{
	forvalues k=1/619{
		
		* GRUPO PRINCIPAL + TIPO + VERBO + OBJETO = 1
		use "Tarefas.dta", clear
		drop controle
		keep if nocupacao==`ocup'
		sort grupo_principal tipo nverbo nobjeto
		merge grupo_principal tipo nverbo nobjeto using "ocup_F`k'.dta"
		egen ocupacao_o = mode(ocupacao4d)
		drop if _merge==1
		gen p1 = 1 if _merge==3
		recode p1 .=0
		drop _merge
		bys controle: gen j=_n
		keep if j==1
		save "peso1.dta", replace

		* GRUPO PRINCIPAL + TIPO + VERBO = 0.5
		use "Tarefas.dta", clear
		drop controle
		keep if nocupacao==`ocup'
		sort grupo_principal tipo nverbo nobjeto
		merge grupo_principal tipo nverbo using "ocup_F`k'.dta"
		egen ocupacao_o = mode(ocupacao4d)
		drop if _merge==1
		gen p2 = 0.5 if _merge==3
		recode p2 .=0
		drop _merge
		bys controle: gen j=_n
		keep if j==1
		save "peso2.dta", replace
		
		* GRUPO PRINCIPAL + TIPO = 0.25
		use "Tarefas.dta", clear
		drop controle
		keep if nocupacao==`ocup'
		sort grupo_principal tipo nverbo nobjeto
		merge grupo_principal tipo using "ocup_F`k'.dta"
		egen ocupacao_o = mode(ocupacao4d)
		drop if _merge==1
		gen p3 = 0.25 if _merge==3
		recode p3 .=0
		drop _merge
		bys controle: gen j=_n
		keep if j==1
		save "peso3.dta", replace

		* TIPO = 0.125
		use "Tarefas.dta", clear
		drop controle
		keep if nocupacao==`ocup'
		sort tipo nverbo nobjeto
		merge tipo using "ocup`k'.dta"
		egen ocupacao_o = mode(ocupacao4d)
		drop if _merge==1
		gen p4 = 0.125 if _merge==3
		recode p4 .=0
		drop _merge
		bys controle: gen j=_n
		keep if j==1
		save "peso4.dta", replace
		
		* Unificando os arquivos de pesos
		use "peso1.dta", clear
		merge controle using "peso2.dta"
		drop _merge
		sort controle
		merge controle using "peso3.dta"
		drop _merge
		sort controle
		merge controle using "peso4.dta"
		drop _merge
		
		* Obtendo o índice (I)
		egen peso = rowmax(p1 p2 p3 p4)
		egen IS = mean(peso)
		keep ocupacao_o ocupacao_d I
		keep in 1
		save "Ocupacao_`k'.dta", replace
		display "Ocupação `k' da `ocup' de 619..."
	}
	clear
	forvalues k=1/619{
		append using "Ocupacao_`k'.dta"
	}
	save "I_`ocup'.dta", replace
}

* Unificando os arquivos de ocupações
clear
forvalues ocup=1/619{
	append using "I_`ocup'.dta"
}
* Nomes das ocupações
include "Nomes_Ocupacoes.do"


/*

* Apagando arquivos auxiliares
forvalues n=1/619{
	capture erase ocup`n'.dta
	capture erase ocup_F`n'.dta
	capture erase Ocupacao_`n'.dta
}

*/


// 7) SALVAR ARQUIVO FINAL
label var ocupacao_d "Ocupação de Destino"
label var ocupacao_o "Ocupação de Origem"
label var IS "Índice de Similaridade"
compress
sort ocupacao_o ocupacao_d
save "Indice_Similaridade_abr_2024.dta", replace