#include <stdio.h>
int mul(int a, int b){
	return a*b*10;
}

int main() {
	
	int mult = mul(2,3);
	mult = mul(mult, 3);
	mult = mult + mul(2, 3);

	printf("%d\n", mul(2, 3) + mul(mul(2, 3), 3));
	printf("%d\n", mult);
	return mult;
	
}
