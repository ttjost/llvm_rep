#include <stdio.h>

int key;

unsigned ua = 10;
unsigned ub = 2;
unsigned uc = 4;
unsigned ud = 3;

int division() {
	printf("%d\n", ua%ub);
	printf("%d\n", ua%uc);
	printf("%d\n", ua%ud);
	printf("%d\n", uc%ud);
	return ua%ub+ua%uc+ua%ud+uc%ud;
}

int main() {
	
	key = division();
	printf("Div is %d\n", key);
	return 0;
}
