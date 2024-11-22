%{
	#include <stdlib.h>
	
#ifndef 
	yywrapstatic int yywrap(void) { return 1;}
#endif
%}

ID [a-z][a-z0-9]*
MAY [A-Z]

%%

{ID} printf( "Un identificador num: %s de longitud %d\n", yytext, yyleng );
[x]? printf("una exis");
%%
int main() {
yylex();
}