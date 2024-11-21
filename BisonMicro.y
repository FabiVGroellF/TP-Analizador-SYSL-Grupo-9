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

%token ASIGNACION PYCOMA SUMA RESTA PARENIZQUIERDO PARENDERECHO
%token <cadena> ID INICIO FIN LEER ESCRIBIR
%token <num> CONSTANTE
%%

sentencias: sentencias sentencia 
|sentencia
;

sentencia: ID {printf("LA LONG es: %d",yyleng); if(yyleng>4) yyerror("metiste la pata");} ASIGNACION expresion PYCOMA
;

expresion: primaria 
|expresion operadorAditivo primaria 
; 

primaria: ID
|CONSTANTE {printf("valores %d %d",atoi(yytext),$1); }
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
printf ("mi error personalizado es %s\n",s);
}

int yywrap()  {
  return 1;  
}
