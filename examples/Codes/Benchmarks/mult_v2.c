#ifdef C
#include <stdio.h>
#endif
int mul(int a, int b){
	return a*b*10;
}

int main() {
	
	#ifdef C
	printf("%d\n", mul(mul(2, 3), 3));
	#endif
	return  mul(mul(2, 3), 3);
	
}
