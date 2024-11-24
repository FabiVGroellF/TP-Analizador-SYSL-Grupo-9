%{

#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include <math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
extern FILE *yyin;
FILE *archivo;
int variable=0;
int flag_de_error = 0;
int in_escribir = 0;
#define YYDEBUG 1

char* ids[100];
int id_count = 0;

void add_id(const char* id) {
	for (int i = 0; i < id_count; ++i) {
		if (strcmp(ids[i], id) == 0) {
			return;
			} 
	} 
	if (id_count < 100) {
		ids[id_count++] = strdup(id);
	} else { 
		printf("Error, tu codigo tiene mas de 100 identificadores!");
		flag_de_error = 1;
		} 
	}
	
int check_id(const char* id) {
	for (int i = 0; i < id_count; ++i) {
		if (strcmp(ids[i], id) == 0) {
			return 1; 
		}
	}
	return 0;
}

%}

%union{
   char* cadena;
   int num;
} 

%token ASIGNACION PYCOMA COMA SUMA RESTA PARENIZQUIERDO PARENDERECHO INICIO FIN LEER ESCRIBIR
%token <cadena> ID
%token <num> CONSTANTE
%%

programa: INICIO listaSentencias FIN
;

listaSentencias: listaSentencias sentencia 
|sentencia
;

sentencia: ID {if(yyleng>32) yyerror("tu identificador tiene mas de 32 caracteres"); add_id($1);} ASIGNACION expresion PYCOMA {printf("Asignacion correcta! \n");}
|LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA
|ESCRIBIR { in_escribir = 1;} PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA { in_escribir = 0; }
;

listaIdentificadores: listaIdentificadores COMA ID
|ID
;

listaExpresiones: listaExpresiones COMA expresion
|expresion
;

expresion: primaria 
|expresion operadorAditivo primaria 
; 

primaria: ID {if (in_escribir && check_id(yytext) == 0) { printf("Warning: La variable '%s' no ha sido inicializada!\n", yytext);}add_id($1); }
|CONSTANTE
|PARENIZQUIERDO expresion PARENDERECHO
;

operadorAditivo: SUMA 
| RESTA
;
%%

int main(int argc, char **argv) {
extern int yydebug;
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

printf("Bienvenido al analizador de codigo Micro!\n\n");
if (yyparse() == 0 && flag_de_error == 0) {
printf("\nFelicidades! Tu codigo Micro es correcto!\n");
} else {
printf("\nOh no! Tu codigo Micro tiene errores!");
}

fclose(archivo);
return 0;
}

void yyerror (char *s){
printf ("Ha ocurrido un error: %s, inesperado %s",s,yytext);
}

int yywrap()  {
  return 1;  
}
