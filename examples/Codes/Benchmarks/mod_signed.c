#include <stdio.h>

int a = 20;
int b = -11;
int c = 6;
int d = -2;
int key;

int division() {
        printf("%d\n", a%b);
        printf("%d\n", a%c);
        printf("%d\n", b%c);
        printf("%d\n", b%d);
        printf("%d\n", a%d);
        a = a%b+a%c+b%c+b%d+a%d;
        return a;
}

int main() {
	
//	printf("Type a number: ");
//	scanf("%d",&key);
	
	key = division();

	printf("\nDiv is %d\n", key);
	return 0;
}
