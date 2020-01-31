%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct No {
    char token[50];
    int num_filhos;
    struct No** filhos;
} No;

char ultimo_erro[1024];

enum tipos{INT, FLOAT, CHAR, STRING};

typedef struct registro_da_tabela_de_simbolo {
    char token[50];
    char lexema[50];
    char* tipo;
    int endereco;
} RegistroTS;

#define TAM_TABELA_DE_SIMBOLOS 1024
RegistroTS tabela_de_simbolos[TAM_TABELA_DE_SIMBOLOS];
int prox_posicao_livre = 0;
int prox_mem_livre = 0;
    

No* allocar_no();
void liberar_no(No* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], No**, int);
void imprimir_tabela_de_simbolos(RegistroTS*);
int verifica_entrada_na_tabela_de_simbolos(char*);
void inserir_na_tabela_de_simbolos(RegistroTS);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    char simbolo[50];
    struct No* no;
}
%token NUM
%token ADD
%token SUB
%token MUL
%token DIV
%token APAR
%token FPAR
%token EOL
%token ID
%token TIPO
%token PV
%token ATR
%token IF
%token ELSE
%token FOR
%token EQ
%token GEQT
%token LEQT
%token GT
%token LT
%token DIF
%token AND
%token OR
%token ACH
%token FCH
%token ACOL
%token FCOL
%token VIRG
%token VET

%type<no> termo
%type<no> fator
%type<no> const
%type<number> exp
%type<number> dec
%type<number> atr
%type<number> atr2
%type<simbolo> TIPO
%type<simbolo> NUM
%type<simbolo> MUL
%type<simbolo> DIV
%type<simbolo> SUB
%type<simbolo> ADD
%type<simbolo> APAR
%type<simbolo> FPAR
%type<simbolo> ID
%type<simbolo> PV
%type<simbolo> ATR
%type<simbolo> IF
%type<simbolo> ELSE
%type<simbolo> FOR
%type<no> cond;
%type<no> comp;
%type<simbolo> EQ;
%type<simbolo> GEQT;
%type<simbolo> LEQT;
%type<simbolo> GT;
%type<simbolo> LT;
%type<simbolo> DIF;
%type<simbolo> AND;
%type<simbolo> OR;
%type<simbolo> ACH
%type<simbolo> FCH
%type<simbolo> ACOL
%type<simbolo> FCOL
%type<simbolo> VIRG
%type<simbolo> VET


%%
/* Regras de Sintaxe */

prog: EOL {
            imprimir_tabela_de_simbolos(tabela_de_simbolos);
    }
   | dec | exp | atr | if | for
   | prog dec 
   | prog exp
   | prog atr
   | prog if
   | prog for
;

if: IF APAR cond FPAR ACH EOL prog FCH EOL {
    }
    | IF APAR cond FPAR ACH EOL prog FCH ELSE ACH EOL prog FCH EOL {
    }
    ;

for: FOR APAR atr2 PV cond PV exp2 FPAR ACH EOL prog FCH EOL {
    };

cond: termo comp termo {
        No** filhos = (No**) malloc(sizeof(No*)*3);
        filhos[0] = $1;
        filhos[1] = $2;
        filhos[2] = $3;
        No* raiz_exp = novo_no("cond", filhos, 3); 
        $$ = raiz_exp;
        imprimir_arvore(raiz_exp);printf("\n\n");
    }
    | cond AND cond {
        No** filhos = (No**) malloc(sizeof(No*)*3);
        filhos[0] = $1;
        filhos[1] = novo_no("&&", NULL, 0);
        filhos[2] = $3;
        No* raiz_exp = novo_no("cond", filhos, 3); 
        $$ = raiz_exp;
        imprimir_arvore(raiz_exp);printf("\n\n");
    }
    | cond OR cond {
        No** filhos = (No**) malloc(sizeof(No*)*3);
        filhos[0] = $1;
        filhos[1] = novo_no("||", NULL, 0);
        filhos[2] = $3;
        No* raiz_exp = novo_no("cond", filhos, 3); 
        $$ = raiz_exp;
        imprimir_arvore(raiz_exp);printf("\n\n");
    }
    ;

comp: EQ {$$ = novo_no("==", NULL, 0);}
    | GEQT {$$ = novo_no(">=", NULL, 0);}
    | LEQT {$$ = novo_no("<=", NULL, 0);}
    | GT {$$ = novo_no(">", NULL, 0);}
    | LT {$$ = novo_no("<", NULL, 0);}
    | DIF {$$ = novo_no("!=", NULL, 0);}
    ;

dec: TIPO ID PV EOL {
            int var_existe = verifica_entrada_na_tabela_de_simbolos($2);
            if (!var_existe) { 
                RegistroTS registro;
                strncpy(registro.token, "ID", 50);
                strncpy(registro.lexema, $2, 50);
                char* tipo = malloc(sizeof(char) * 50);
                strcpy(tipo, $1);
                registro.tipo = tipo;
                registro.endereco = prox_mem_livre;
                prox_mem_livre += sizeOfTipo($1);
                inserir_na_tabela_de_simbolos(registro);
                $$ = 1;
            }
            else {
                printf("Erro! Múltiplas declarações de variável");
                exit(1);
            }
            imprimir_arvore($2);printf("\n\n");
            imprimir_tabela_de_simbolos(tabela_de_simbolos);
        }
    | TIPO VET PV EOL {
            char* vetor = malloc(sizeof(char) * 50);
            strcpy(vetor, $2);
            char* var = strtok($2, "["); 
            int var_existe = verifica_entrada_na_tabela_de_simbolos(var);
            if (!var_existe) { 
                RegistroTS registro;
                strncpy(registro.token, "VET", 50);
                strncpy(registro.lexema, var, 50);
                char* tipo = malloc(sizeof(char) * 50);
                strcpy(tipo, $1);
                registro.tipo = tipo;
                registro.endereco = prox_mem_livre;
                prox_mem_livre += sizeOfTipo($1) * sizeOfVetor(vetor);
                inserir_na_tabela_de_simbolos(registro);
                $$ = 1;
            }
            else {
                printf("Erro! Múltiplas declarações de variável");
                exit(1);
            }
            imprimir_arvore($2);printf("\n\n");
            imprimir_tabela_de_simbolos(tabela_de_simbolos);
        }
    ;

atr: ID ATR termo PV EOL {
        No** filhos = (No**) malloc(sizeof(No*)*3);
        filhos[0] = $1;
        filhos[1] = novo_no("=", NULL, 0);
        filhos[2] = $3;
        No* raiz_exp = novo_no("atr", filhos, 3);
        imprimir_arvore(raiz_exp);printf("\n\n");
        $$ = 2;
    }
    ;

atr2: ID ATR termo {
        No** filhos = (No**) malloc(sizeof(No*)*3);
        filhos[0] = $1;
        filhos[1] = novo_no("=", NULL, 0);
        filhos[2] = $3;
        No* raiz_exp = novo_no("atr", filhos, 3);
        imprimir_arvore(raiz_exp);printf("\n\n");
        $$ = 2;
    }

exp: 
    | PV EOL {
        imprimir_tabela_de_simbolos(tabela_de_simbolos);
        $$ = 3;
    }
    | exp termo PV  EOL    { 
                            imprimir_arvore($2);printf("\n\n");
                            imprimir_tabela_de_simbolos(tabela_de_simbolos);
                            $$ = 3;
                        }
    ;

exp2: termo {
        imprimir_arvore($1);printf("\n\n");
    }
    | exp termo {
        imprimir_arvore($2);printf("\n\n");
    }

termo: fator               
   | termo ADD fator       { 
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("+", NULL, 0);
                            filhos[2] = $3;
                            No* raiz_exp = novo_no("termo", filhos, 3); 
                            $$ = raiz_exp;
                         }
   | termo SUB fator       { 
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("-", NULL, 0);
                            filhos[2] = $3;
                            No* raiz_exp = novo_no("termo", filhos, 3); 
                            $$ = raiz_exp;
                        }
   ;
fator: const    
     | fator MUL const  { 
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("*", NULL, 0);
                            filhos[2] = $3;
                            No* raiz_termo = novo_no("fator", filhos, 3); 
                            $$ = raiz_termo;
                        }
     | fator DIV const  {  
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("/", NULL, 0);
                            filhos[2] = $3;
                            No* raiz_termo = novo_no("fator", filhos, 3); 
                            $$ = raiz_termo;
                        }
     ;

const: NUM { $$ = novo_no($1, NULL, 0);}  
    |  ID  { 
               int var_existe = verifica_entrada_na_tabela_de_simbolos($1);
               if(var_existe) {
                   $$ = novo_no($1, NULL, 0);  
               }
               else {
                   printf("Variável %s não declarada;", $1);
                   exit(1);
               }
           }
    | VET { 
            char* vetor = malloc(sizeof(char) * 50);
            strcpy(vetor, $1);
            for (int i = 0; i <= strlen(vetor); i++) {
                if (vetor[i] == '[') {
                    vetor[i] = '(';
                } else if (vetor[i] == ']') {
                    vetor[i] = ')';
                }
            }
            char* var = strtok($1, "[");
            int var_existe = verifica_entrada_na_tabela_de_simbolos(var);
            if(var_existe) {
                $$ = novo_no(vetor, NULL, 0);
            }
            else {
                printf("Variável %s não declarada;", var);
                exit(1);
            }
    }
%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

No* allocar_no(int num_filhos) {
    No* no = (No*) malloc(sizeof(No));
    no->num_filhos = num_filhos;
    if (no->num_filhos == 0) {
        no->filhos = NULL;
    }

    return no;
    
}

void liberar_no(No* no) {
    free(no);
}

No* novo_no(char token[50], No** filhos, int num_filhos) {
   No* no = allocar_no(num_filhos);
   no->filhos = filhos;
   snprintf(no->token, 50, "%s", token);

   return no;
}

void imprimir_arvore(No* raiz) {
    if(raiz->filhos != NULL) {
        printf("[%s", raiz->token);
        for(int i = 0; i < raiz->num_filhos; i++) {
            imprimir_arvore(raiz->filhos[i]);
        }
        printf("]");
    }
    else {
        printf("[%s]", raiz->token);
    }
}

int verifica_entrada_na_tabela_de_simbolos(char *variavel) {
    for(int i = 0; i < prox_posicao_livre; i++) {
            if( strncmp(tabela_de_simbolos[i].lexema, variavel, 50) == 0) {
            return 1;
        }
    }
    return 0;
}

void inserir_na_tabela_de_simbolos(RegistroTS registro) {
    if (prox_posicao_livre == TAM_TABELA_DE_SIMBOLOS) {
        printf("Erro! Tabela de Símbolos Cheia!");
        return;
    }
    tabela_de_simbolos[prox_posicao_livre] = registro;
    prox_posicao_livre++;
}

void imprimir_tabela_de_simbolos(RegistroTS *tabela_de_simbolos) {
    printf("----------- Tabela de Símbolos ---------------\n");
    for(int i = 0; i < prox_posicao_livre; i++) {
        printf("{%s} -> {%s} -> {%s} -> {%x}\n", tabela_de_simbolos[i].token, \
                                               tabela_de_simbolos[i].lexema, \
                                               tabela_de_simbolos[i].tipo, \
                                               tabela_de_simbolos[i].endereco);
        printf("---------\n");
    }
    printf("----------------------------------------------\n");
}

int sizeOfTipo(char* tipo) {
    if (strcmp("int", tipo) == 0) {
        return 4;
    } else if (strcmp("float", tipo) == 0) {
        return 4;
    } else if (strcmp("double", tipo) == 0) {
        return 8;
    } else if (strcmp("char", tipo) == 0) {
        return 1;
    } else {
        return 0;
    }
}

int sizeOfVetor(char* var) {
    char* token = strtok(var, "[");
    token = strtok(NULL, " ");
    token = strtok(token, "]");
    return atoi(token);
}

int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}

