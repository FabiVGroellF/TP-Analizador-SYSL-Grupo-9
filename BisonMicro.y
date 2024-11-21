%{

#include <stdio.h>
#include <stdlib.h> 
#include <math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
extern FILE *yyin;
FILE *archivo;
int variable=0;

%}

%union{
   char* cadena;
   int num;
} 

%token ASIGNACION PYCOMA COMA SUMA RESTA PARENIZQUIERDO PARENDERECHO INICIO FIN LEER ESCRIBIR FDT
%token <cadena> ID
%token <num> CONSTANTE
%%

objetivo: programa FDT
;

programa: INICIO listaSentencias FIN
;

listaSentencias: listaSentencias sentencia 
|sentencia
;

sentencia: ID {if(yyleng>32) yyerror("tu identificador tiene mas de 32 caracteres");} ASIGNACION expresion PYCOMA {printf("Se hizo la asignacion");}
|LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA
|ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA
;

listaIdentificadores: listaIdentificadores COMA ID
|ID
;

listaExpresiones: listaExpresiones COMA ID
|ID
;

expresion: primaria 
|expresion operadorAditivo primaria 
; 

primaria: ID
|CONSTANTE
|PARENIZQUIERDO expresion PARENDERECHO
;

operadorAditivo: SUMA 
| RESTA
;
%%

int main(int argc, char **argv) {
if (argc < 2) {
printf("Falta el nombre del archivo a analizar. Debe escribir el comando asi: ./analizador <archivo_con_codigo_en_micro>\n");
return 1;
}

FILE *archivo = fopen(argv[1], "r"); 
if (!archivo) {
printf("Error al abrir el archivo");
return 1;
}

yyin = archivo;

printf("Bienvenido al analizador de codigo Micro!\n");

if (yyparse() == 0) {
printf("Felicidades! Tu codigo Micro esta correcto!\n");
} else {
printf("\nOh no! Tu codigo Micro tiene errores!");
}

fclose(archivo);
return 0;
}

void yyerror (char *s){
printf ("Ha ocurrido un error: %s\n",s);
}

int yywrap()  {
  return 1;  
}
