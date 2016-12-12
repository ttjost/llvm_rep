
int global_a = 50;
int global_b = 100;
int global_c = 1000;

int sum(int a, int b){
	return  a + b + global_a;
}

int main (){

	return sum(global_c, global_b);			// 1280
}
