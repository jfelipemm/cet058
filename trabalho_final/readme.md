# **Relatório**
 
- Introdução
 
Um compilador é um programa que traduz outro programa escrito em linguagem de alto nível, isto é, aquela que é entendida pelo humano, para a linguagem de máquina, isto é, linguagem entendida pela parte física do computador. O compilador geralmente é dividido em duas etapas: a tabela de símbolos e o montador.
A tabela de símbolos é onde fica armazenados os tokens da linguagem separados por *token*, lexema(nome da variável), tipo da variável e o endereço na memória de onde aquela variável está armazenada. O montador é a parte que realmente faz a tradução do código-fonte para linguagem de máquina. A partir da tabela de símbolos se retira as informações necessárias para que o montador faça a correspondência para a linguagem assembly para que esta seja traduzida para a linguagem binária ou hexadecimal. No presente trabalho apresentaremos a primeira etapa da construção do compilador, a tabela de símbolos.
Contudo para que essa tabela de símbolos seja implementada antes se precisa fazer duas analise que verificaram no código a presença de elementos importantes para que seja estabelecida a tabela de símbolos. Essas análises são as análise léxica e análise sintática. A primeira permite que  sejam identificados os *tokens*, como citado anteriormente, que são as palavras que possuem algum significado para a linguagem e tem um determinado papel para que a ação que código-fonte deseja fazer seja realizada, como por exemplo, se é um número ou uma operação matemática ou se o tipo da variável.
Neste momento é feito a declaração de quais tokens essa linguagem possui estabelecendo assim um padrão na linguagem. 
Já na análise sintática é feita uma varredura no código para encontrar os tokens estabelecidos na parte análise léxica e verifica se a mesma pode ser gerada pela gramática da linguagem fonte. A partir disso é gerada a tabela de símbolos, onde é colocada os tokens e suas características.
 
 
- Ferramentas
 
  - Bison
 
O Bison é um gerador análise de uso geral open-source, isto é um software livre, escrito para o projeto GNU que converte uma sequência gramatical para uma gramática livre de contexto em um programa em C para analisar essa cadeia de caracteres. O analisador Bison é um analisador de baixo para cima. Ele tenta com voltas e reduções , reduzir toda cadeia de entrada para um único agrupamento cujo o símbolo é o símbolo inicial da gramática.  
Sua implementação é feita da seguinte forma: primeiro é criado um arquivo em Bison, cuja a extensão *.y, passando pelo analisador Bison sua saída será um arquivo com a extensão em *.tab.c. Este arquivo *.tab.c é compilado no compilador C e o resultado será um arquivo de saída *a.out*, esse arquivo é dado para entrada do *parse* escrito, e seu resultado é a árvore de *parsing*. No presente trabalho sua utilização foi bastante útil na escrita do código do parser, com a extensão parser.y, para que a sua saída seja a tabela de simbolos e a árvore sintática.
 
  - Flex
 
 
 O Flex é uma ferramenta semelhante ao Bison mas se difere pelo fato dele estar na parte do analisador léxico do programa onde são estabelecidos os tokens e as regras da linguagem do programa a ser compilado. Permite também que seja colocado trechos de códigos da linguagem C no corpo do programa e para separar o código flex do código C usa-se como delimitadores dois símbolos de porcentagem (%%). Os arquivos flex quem como extensão *.l. O código flex gera um outro programa em C (lex.yy.c) que é vinculada biblioteca -lfl, logo em seguida é executado.
 
  - VsCode
 
O visual Studio Code é uma IDE(Ambiente Integrado de desenvolvimento) de código-fonte desenvolvido pela Microsoft para os sistemas operacionais Windows, Linux e macOS. Possui suporte a diversas linguagens de programação como C, C#, Python, PHP entre outros.
 
 - Credux
 
Credux , se lê "C redux", foi uma linguagem criada para fins desse trabalho para ser a entrada de dados do compilador. Seus padrões de linguagens recorda um pouco da linguagem C, contudo possui algumas diferenças consideráveis:
  1. Não possui funções, logo não existe a função main();
  2. Sua estrutura de execução é top-down;
  3. O tipo de variável string não pertence a essa linguagem. Para escrever uma palavra com mais de dois caracteres pode-se usar um vetor do tipo char;
 
 
A linguagem é ideal para quem está iniciando na programação pois visa oferecer ao programador um conhecimento dos tipos de variáveis, expressões aritméticas básicas, expressões relacionais e lógicas, estrutura de seleção, uma estrutura de repetição e vetores sem que se preocupe com funções neste primeiro momento de sua aprendizagem.
 
 
- A solução


Os tokens utilizados para a análise léxica foram os seguintes: NUMBER, ID,TIPO, VETOR. Todos estes obtidos por regex, enquanto os outros tokens foram definidos diretamente, tais como: as palavras reservadas if, else, for; ponto e vírgula; os operadores aritméticos de multiplicação(*) divisão(/), adição(+), subtração(-); delimitadores de expressão parênteses, quebra de linha, abre e fecha chaves; operador de atribuição (=); operadores lógicos(==, >=, <=, >, <, !=, && e ||).
As produções utilizadas para as regras sintáticas foram as seguintes: 
  - const: pode ser um NUMBER, ID ou VETOR;
  - fator: pode ser um const, ou uma multiplicação ou divisão de um fator com um const;
  - termo: pode ser um fator, ou uma adição ou subtração de um termo com um fator;
  - exp e exp2: podem ser um termo ou uma concatenação de termos; O exp inclui ponto e vírgula e final de linha no final da produção, diferente do exp2 que não as possui. Isso foi feito para facilitar a construção da produção do for(usando exp2) e permitir a utilização de expressão como um comando próprio(exp);
   - atr e atr2: representam a atribuição, sendo compostos pelo token ID seguido do token atribuição(ATR) e de um termo. No atr foi incrementado o ponto e vírgula(PV) e final de linha(EOL). Isso foi feito para facilitar a construção da produção do for(usando atr2) e permitir a utilização de atribuição como um comando próprio(atr);
   - dec: pode ser um tipo de variável seguido de ID ou VET, com o ponto e vírgula e finalizado com a quebra de linha. Isso permite declaração de variáveis primitivas e vetores;
   - como: são os operadores de comparação, apelidados de EQ(==), GEQT (>=), LEQT(<=>), GT(>), LT(<), DIF(!=)
   - cond: pode ser um termo seguido de um comp e outro termo, ou 2 cond separados pelo token AND(&&) ou OR(||);
   - for: é definido pelo token FOR seguido por: APAR(abre parênteses), a produção atr2, token PV(ponto e vírgula), produção cond, token PV, a produção exp2, FPAR(fecha parêntese), o token ELSE, o ACH(abre chaves), EOL(quebra de linha), a produção prog, FCH(fecha chaves) e EOL. 
   - if: essa produção pode ser um IF sozinho ou um IF...ELSE. É definido pelo token IF seguido por: APAR(abre parenteses), produção cond,  FPAR(fecha parentese), o ACH(abre chaves), EOL(quebra de linha), a produção prog, FCH(fecha chaves) e EOL. Ou depois que fechar a primeira chave, pode ser colocado um token ELSE seguido por ACH(abre chaves), EOL(quebra de linha), a produção prog, FCH(fecha chaves) e EOL.
   - prog: é definido pelo token EOL, ou: uma declaração(dec), uma expressão(exp), atribuição(atr), condição(if) ou loop(for). Ou uma sequência de progs pois ele é recursivo. 
 
   Quando aparece um ID ou VETOR, o parser imprime a tabela de símbolos com o token, o lexema, o tipo e o endereço de cada símbolo já declarado símbolo. E imprime a árvore sintática quando aparece um cond, um dec, uma atr ou uma exp.  
 
   Os problemas encontrados e que não conseguiram ser solucionados foram: não é possível fazer uma atribuição após uma expressão e não aceita linha em branco.
 
- Conclusão
 
    Ao desenvolver esse trabalho notamos que o compilador é uma importante ferramenta na área do desenvolvimento do mundo tecnológico. Embora o trabalho proposto não exigiu uma montagem completa de um compilador, pode ser notado que a primeira parte do parser é de grande importância para o reconhecimento da tabela de tokens que posteriormente será utilizada. A construção de um compilador é uma tarefa que demanda tempo e com o bison e o flex fica mais ágil de acontecer. 
 
 
Referências
[Introdução ao Flex e Bison](https://www.oreilly.com/library/view/flex-bison/9780596805418/ch01.html)


[Bison](https://pt.wikipedia.org/wiki/GNU_bison)


[Bison](http://alumni.cs.ucr.edu/~lgao/teaching/bison.html)
