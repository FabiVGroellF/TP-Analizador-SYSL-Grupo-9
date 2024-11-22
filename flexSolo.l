%{
	#include <stdio.h>
	#include <stdlib.h>
    extern FILE *yyin;
    FILE *archivo;
	
#ifndef yywrap
    static int yywrap(void) { return 1;}
#endif
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

":=" 				printf( "Un operador de asignacion: %s\n", yytext);
";" 				printf( "Un punto y coma: %s\n", yytext);
"," 				printf( "Una coma: %s\n", yytext);
"(" 				printf( "Un parentesis izquierdo: %s\n", yytext);
")" 				printf( "Un parentesis derecho: %s\n", yytext);
"+" 				printf( "Un operador de suma: %s\n", yytext);
"-" 				printf( "Un operador de resta: %s\n", yytext);

{constEntera}		{atoi(yytext); printf( "Una constante de valor: %s\n", yytext);}

{INICIO} 			printf( "Palabra Clave inicio: %s\n", yytext);
{FIN} 				printf( "Palabra Clave fin: %s\n", yytext);
{LEER} 				printf( "Palabra Clave leer: %s\n", yytext);
{ESCRIBIR} 			printf( "Palabra Clave escribir: %s\n", yytext);

{IDENTIFICADOR}		printf( "Un operador de identificador: %s de longitud %d\n", yytext, yyleng );

yyerror("No se pudo reconocer el token");

%%

int main(int argc, char **argv) {

if (argc < 2) {
printf("Falta el nombre del archivo a analizar. Debe escribir el comando asi: ./%s <archivo_con_codigo_en_micro>\n", argv[0]);
return 1;
}
FILE *archivo = fopen(argv[1], "r"); 
if (!archivo) {
printf("Error al abrir el archivo");
return 1;
}
yyin = archivo;

printf("Bienvenido al analizador lexico de codigo Micro!\n");
while (!yywrap) {
yylex();
}
printf("Felicidades! Tu codigo Micro no tiene errores lexicos!\n");


fclose(archivo);
return 0;
}

void yyerror (char *s){
printf ("Ha ocurrido un error: %s\n",s);
}