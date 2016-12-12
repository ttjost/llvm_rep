
int a[100];

int b[100];

int main(){

	int i;

	for (i = 0; i < 100; i++){
		a[i] = i;
		b[i] = 100 - i;
	}

	for (i = 0; i < 100 ; i++){
		if (a[i] == b[i])
			return 3;
	}

	return 1;
}
