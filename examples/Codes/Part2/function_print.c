#include<stdio.h> 

int global_a = 50;
int global_b = 100;
int global_c = 1000;

int sum(int a, int b){
	return  a + b + global_a;
}

int main (){

	int a = 10;
	int b = 20;
	int c = sum(global_b, global_c);	// 1150
	int d = sum(a, b);			// 80
	printf ("%d\n", sum(c, d));
	return sum(c, d);			// 1280
}
