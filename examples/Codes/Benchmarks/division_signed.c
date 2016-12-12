#include <stdio.h>

int a = 10;
int b = -10;
int c = 5;
int d = -2;
int key;

int division() {
	printf("%d\n", a/b);
	printf("%d\n", a/c);
	printf("%d\n", b/c);
	printf("%d\n", b/d);
	a = a/b+a/c+b/c+b/d;
	return a;
}

int main() {
	
	key = division();

	printf("Div is %d\n", key);
	return 0;
}
