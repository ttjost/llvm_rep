#include <stdio.h>

int a = 100000;

int b = 20;

char c = 'a';

int main (){

	int d;

	if (a == 3)
		d = b + c;
	else
		d = b - c;

	printf("%d\n",d);
	return d;
}
