/* Escreva uma analisador capaz de extrair os tokens de uma expressão
 * aritimética simples, incluindo parenteses.*/

%{

/* Código Global C que será copiado para o fonte */
/* #includes, variáveis globais e constantes vão aqui... */

#include "parser.tab.h"

%}

/* Definições */
NUMBER [0-9]+
ID [a-zA-Z_][a-zA-Z_]*
TIPO int|float|double|char
VETOR [a-zA-Z_][a-zA-Z_]*\[[1-9][0-9]*\]

/* Início das Regras */
%%
"if"        {return IF;}
"else"        {return ELSE;}
"for"        {return FOR;}
{NUMBER}    {strncpy(yylval.simbolo, yytext, 50); return NUM;}
{TIPO}      {strncpy(yylval.simbolo, yytext, 50); return TIPO;}
{ID}        {strncpy(yylval.simbolo, yytext, 50); return ID;}
";"         {strncpy(yylval.simbolo, yytext, 50); return PV;}
"\*"        {return MUL;}
"/"         {return DIV;}
"\+"         {return ADD;}
"\-"         {return SUB;}
"\("         {return APAR;}
"\)"         {return FPAR;}
"\n"         {return EOL;}
"="         {return ATR;}
"=="         {return EQ;}
">="         {return GEQT;}
"<="         {return LEQT;}
">"         {return GT;}
"<"         {return LT;}
"!="         {return DIF;}
"&&"         {return AND;}
"||"        {return OR;}
"\{"         {return ACH;}
"\}"         {return FCH;}
"\["         {return ACOL;}
"\]"         {return FCOL;}
","         {return VIRG;}
{VETOR}        {strncpy(yylval.simbolo, yytext, 50); return VET;}

%%
/* Fim das Regras */
/* Código C abaixo será incluído nos fontes. */

int yywrap() {}

