#ifdef C
#include <stdio.h>
#endif
int mul(int a, int b){
	return a*b*10;
}

int main() {
	
	int mult = mul(2, 3) + mul(mul(2, 3), 3);
	#ifdef C
	printf("%d\n", mul(2, 3) + mul(mul(2, 3), 3));
	#endif
	
}
