// clang -target mips-unknown-linux-gnu -c ch7_1.cpp -emit-llvm -o ch7_1.bc
// /Users/Jonathan/llvm/test/cmake_debug_build/Debug/bin/llc -march=cpu0 -relocation-model=pic -filetype=asm ch7_1.bc -o -

#include <stdio.h> 

/// start
int test_local_pointer()
{
  int b = 3;
  
  int* p = &b;

  return *p;
}

int main() {

	int a = test_local_pointer();
	printf("%d\n", 1000 + a);

	return 1000 + a;

}
