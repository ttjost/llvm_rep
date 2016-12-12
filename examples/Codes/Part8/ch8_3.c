// clang -O1 -target mips-unknown-linux-gnu -c ch8_3.cpp -emit-llvm -o ch8_3.bc
// ~/llvm/test/cmake_debug_build/Debug/bin/llc -march=cpu0 -mcpu=cpu032I -relocation-model=static -filetype=asm ch8_3.bc -o -
// /usr/local/llvm/test/cmake_debug_build/bin/llc -march=cpu0 -mcpu=cpu032I -relocation-model=static -filetype=asm ch8_3.bc -o -

#ifdef C
#include <stdio.h>
#endif
volatile int a = 1;
volatile int b = 2;
//int a = 1;
//int b = 2;

/// start
int select_1()
{
  int c = 0;

  if (a < b)
    return 1;
  else
    return 2;
}

int select_2()
{
  int c = 0;

  if (a)
    c = 1;
  else
    c = 3;

  return c;
}

int select_3()
{
  int c = 0;

  c = a ? 3:1;

  return c;
}

int main(){

	#ifdef C
	printf("%d %d %d\n", select_1(), select_2(), select_3() );
	#endif
	return select_1() + select_2() + select_3();



}

