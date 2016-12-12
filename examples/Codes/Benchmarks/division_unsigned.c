#include <stdio.h>

int key;
unsigned ua = 10;
unsigned ub = 2;
unsigned uc = 5;

int division() {
	return ua/uc+ua/ub;	
}

int main() {
	
	key = division();
	printf("\nDiv is %d\n", key);
	return 0;
}
