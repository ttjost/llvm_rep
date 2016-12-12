/*
 * Levenshtein Distance
 *
 * @version $Id: levenshtein.c 1.0 "based on
 *               http://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#C"
 *               2015-01-27 11:25:00 neliton@ufv.br $;
 */

#ifdef VERBOSE
#include <stdio.h>
#include <ctype.h>
#endif

#define MIN3(a, b, c) ((a) < (b) ? ((a) < (c) ? (a) : (c)) : ((b) < (c) ? (b) : (c)))

int levenshtein(char *s1, int s1len, char *s2, int s2len)
{
    unsigned int x, y;
    unsigned int matrix[256][256];
    matrix[0][0] = 0;
    for (x = 1; x <= s2len; x++)
        matrix[x][0] = matrix[x - 1][0] + 1;
    for (y = 1; y <= s1len; y++)
        matrix[0][y] = matrix[0][y - 1] + 1;
    for (x = 1; x <= s2len; x++)
        for (y = 1; y <= s1len; y++)
            matrix[x][y] = MIN3(matrix[x - 1][y] + 1, matrix[x][y - 1] + 1, matrix[x - 1][y - 1] + (s1[y - 1] == s2[x - 1] ? 0 : 1));

    return matrix[s2len][s1len];
}

int main()
{
    char s1[256], s2[256];
    unsigned int s1len, s2len, i, n;

#ifdef SEMENTE
    srand(SEMENTE);
#else
    srand(time(0));
#endif
    s1len = rand() % 254;
    for (i = 0; i < s1len;) {
        s1[i] = (char)(rand() % 0xff);
        if (!isprint(s1[i]))
            continue;
        i++;
    }
    s1[s1len] = '\0';

    s2len = rand() % 254;
    for (i = 0; i < s2len; i++) {
        s2[i] = (char)(rand() % 0xff);
        if (!isprint(s2[i]))
            continue;
        i++;
    }
    s2[s1len] = '\0';

    n = levenshtein(s1, s1len, s2, s2len);

#ifdef VERBOSE
    printf("==> %s\n==> %s\n===> %i\n", s1, s2, n);
#endif

    return 0;
}
