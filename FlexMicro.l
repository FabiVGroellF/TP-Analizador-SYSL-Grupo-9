%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"
	
	extern int flag_de_error;
	extern int check_id(const char* id);
%}

DIGITO 				[0-9]
LETRA				[a-zA-Z]
IDENTIFICADOR		{LETRA}({LETRA}|{DIGITO})*
constEntera			{DIGITO}({DIGITO})* 
INICIO				"inicio"
FIN 				"fin"
LEER				"leer"
ESCRIBIR			"escribir"

%%

":=" 				{return ASIGNACION;}
";" 				{return PYCOMA;}
"," 				{return COMA;}
"(" 				{return PARENIZQUIERDO;}
")" 				{return PARENDERECHO;}
"+" 				{return SUMA;}
"-" 				{return RESTA;}

{constEntera}		{yylval.num=atoi(yytext); return CONSTANTE;}

{INICIO} 			{return INICIO;}
{FIN} 				{return FIN;}
{LEER} 				{return LEER;}
{ESCRIBIR} 			{return ESCRIBIR;}

{IDENTIFICADOR}		{yylval.cadena = strdup(yytext); return ID;}

[ \t\n]
<<EOF>>             {return 0;}
.                   { printf("Caracter No Reconocido: %s \n", yytext); flag_de_error = 1;}

%%