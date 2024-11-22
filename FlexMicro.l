%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
%}

DIGITO 				[0-9]
LETRA				[a-zA-Z]
IDENTIFICADOR		{LETRA}({LETRA}|{DIGITO})*
constEntera			{DIGITO}({DIGITO})* 
INICIO				"INICIO"
FIN 				"FIN"
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

{IDENTIFICADOR}		{return ID;}

%%