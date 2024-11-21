#include <stdio.h>
#include <stdlib.h>

extern int yyparse();
extern FILE *yyin; // Archivo con el codigo de Micro que se pasara a Flex

int main(int argc, char **argv) {  // nombre del programa analizador, archivo a analizar
    if (argc < 2) {
        printf("Falta el nombre del archivo a analizar. Debe escribir el comando asi: %s <archivo_con_codigo_en_micro>\n", argv[0]);
        return 1;
    }

    // Abrir el archivo de micro
    FILE *archivo = fopen(argv[1], "r");  // se abre en modo lectura, esto obliga a que el archivo con el codigo micro exista
    if (!archivo) {
        printf("Error al abrir el archivo");
        return 1;
    }

    // Se le pide a Flex que lea los caracteres del archivo de micro
    yyin = archivo;

    // Ejecutar el análisis lexico, sintactico y semantico del archivo con codigo micro
    if (yyparse() == 0) {
        printf("Felicidades! Tu codigo Micro esta correcto!\n");
    } else {
        printf("Oh no! Tu codigo Micro tiene errores!\n");
    }

    // Cerrar el archivo
    fclose(archivo);
    return 0;
}
