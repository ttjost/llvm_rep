#ifdef C
#include <stdio.h>
#endif 
//This program prints the result of a matrix multiplication

int matrix_mul();

int a[2][2] = { {0, -1},
		   {-1, -1}};

int b[2][2] = {{1, 1},
		{-1, 1}};

int c[2][2] = { {0, 0},
		{0, 0}};

int result[2][2] = {{1, -1},
		    {0, -2}};

int main(void)
{
    int i, j, k, var;
    for(i = 0; i < 2; i++){  
	for(j = 0; j < 2; j++){
	    var = 0;
	    for(k = 0; k < 2; k++){
	        var += a[i][k] * b[k][j];
	    }
	    c[i][j] = var;
	}
    }
    for (i = 0; i < 2; i++)
    {
        for (j = 0; j < 2; j++)
	{
	    if (c[i][j] != result[i][j])
	        return 100*i+j;
	}
    }
    #ifdef C
    printf("Success\n");
    #endif      
    return -1;
}
