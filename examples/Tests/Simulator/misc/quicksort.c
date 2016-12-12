/**
 * Quick Sort
 *
 * @see http://pt.wikipedia.org/wiki/Quicksort
 */

#include <stdio.h>
#include <time.h>

#ifndef TAMANHO
#define TAMANHO 65536
#endif

#ifndef SEMENTE
#define SEMENTE 0
#endif

void trocaValores(int* a, int* b)
{
    int aux;
    aux = *a;
    *a = *b;
    *b = aux;
}

int divide(int vec[], int esquerdo, int direito)
{
    int i, j;

    i = esquerdo;
    for (j = esquerdo + 1; j <= direito; ++j) {
        if (vec[j] < vec[esquerdo]) {
            ++i;
            trocaValores(&vec[i], &vec[j]);
        }
    }
    trocaValores(&vec[esquerdo], &vec[i]);

    return i;
}

void quickSort(int vec[], int esquerdo, int direito)
{
    int r;

    if (direito > esquerdo) {
        r = divide(vec, esquerdo, direito);
        quickSort(vec, esquerdo, r - 1);
        quickSort(vec, r + 1, direito);
    }
}

main(int argc, char *argv[])
{
    int vector[TAMANHO];
    int i;
    srand(SEMENTE);
    for (i = 0; i < TAMANHO; i++)
        vector[i] = rand();
#ifdef VERBOSE
    printf("\nSorting %d elements.\n\n", TAMANHO);
#endif
    quickSort(vector, 0, TAMANHO - 1);
#ifdef VERBOSE
    for(i=0; i < TAMANHO; i++)
        printf("%d %d\n", argc, vector[i]);
#endif
    return 0;
}
