# **Relatório**

- Introdução

Um compilador é um programa que traduz outro programa escrito em linguagem de alto nível, isto é, aquela que é entendida pelo humano, para a linguagem de máquina, isto é, linguagem entendida pela parte física do computador. O compilador geralmente é dividido em duas etapas: a tabela de símbolos e o montador.
A tabela de símbolos é onde fica armazenados os tokens da linguagem separados por *token*, lexema(nome da variável), tipo da variável e o endereço na memória de onde aquela variável está armazenada. O montador é a parte que realmente faz a tradução do código-fonte para linguagem de máquina. A partir da tabela de símbolos se retira as informações necessárias para que o montador faça a correspondência para a linguagem assembly para que esta seja traduzida para a linguagem binária ou hexadecimal. No presente trabalho apresentaremos a primeira etapa da construção do compilador, a tabela de símbolos.
Contudo para que essa tabela de símbolos seja implementada antes se precisa fazer duas analise que verificaram no código a presença de elementos importantes para que seja estabelecida a tabela de símbolos. Essas análises são as análise léxica e análise sintática. A primeira permite que  sejam identificados os *tokens*, como citado anteriormente, que são as palavras que possuem algum significado para a linguagem e tem um determinado papel para que a ação que código-fonte deseja fazer seja realizada, como por exemplo, se é um número ou uma operação matemática ou se o tipo da variável.
(inserir imagem)
Neste momento é feito a declaração de quais tokens essa linguagem possui estabelecendo assim um padrão na linguagem. 
Já na análise sintática é feita uma varredura no código para encontrar os tokens estabelecidos na parte análise léxica e verifica se a mesma pode ser gerada pela gramática da linguagem fonte. A partir disso é gerada a tabela de símbolos, onde é colocada os tokens e suas características.


- Ferramentas

 - Bison

O Bison é um gerador análise de uso geral open-source, isto é um software livre, escrito para o projeto GNU que converte uma sequência gramatical para uma gramática livre de contexto em um programa em C para analisar essa cadeia de caracteres. O analisador Bison é um analisador de baixo para cima. Ele tenta com voltas e reduções , reduzir toda cadeia de entrada para um único agrupamento cujo o símbolo é o símbolo inicial da gramática. 


Sua implementação é feita da seguinte forma: primeiro é criado um arquivo em Bison, cuja a extensão *.y, passando pelo analisador Bison sua saída será um arquivo com a extensão em *.tab.c. Este arquivo *.tab.c é compilado no compilador C e o resultado será um arquivo de saída *a.out*, esse arquivo é dado para entrada do *parse* escrito, e seu resultado é a árvore de *parsing*. No presente trabalho sua utilização foi bastante útil na escrita do código do parser, com a extensão parser.y, para que a sua saída seja a tabela de simbolos e a árvore sintática.

 - Flex


 O Flex é uma ferramenta semelhante ao Bison mas se difere pelo fato dele estar na parte do analisador léxico do programa onde são estabelecidos os tokens e as regras da linguagem do programa a ser compilado. Permite também que seja colocado trechos de códigos da linguagem C no corpo do programa e para separar o código flex do código C usa-se como delimitadores dois símbolos de porcentagem (%%). Os arquivos flex quem como extensão *.l. O código flex gera um outro programa em C (lex.yy.c) que é vinculada biblioteca -lfl, logo em seguida é executado.

 - VsCode

O visual Studio Code é uma IDE de código-fonte desenvolvido pela Microsoft para os sietams operacionais Windons, Linux e macOS. Possuiu suporte a diversas linguagens de programação como C, C#, Python 

 - Credux

Introduzir as ferramentas utilizadas, suas características e possíveis uso, especialmente o Bison e o Flex.




- A solução
Explicar em detalhes a implementação do seu parser, explicar os principais elementos da implementação
especialmente o que diz respeito à análise léxica e sintática, como tokens e produções.
- Conclusão




referencias
[Link](https://www.oreilly.com/library/view/flex-bison/9780596805418/ch01.html)
https://pt.wikipedia.org/wiki/GNU_bison
http://alumni.cs.ucr.edu/~lgao/teaching/bison.html


