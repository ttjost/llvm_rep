#!/bin/sh
llvm_build="/home/larissa/Desktop/drygin/llvm_2/build"
cc="/home/larissa/Desktop/drygin/vex/bin/"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied: <folder_name>"
    exit 1
fi
## rvex_examples, wcet_bench ##
bench=$1



for file in $1/*.c
do
tmp=$(basename $file)
i="${tmp%.*}"
$llvm_build/bin/clang -O3 -freg-struct-return -m32 -fno-gnu-inline-asm -ffinite-math-only $1/${i}.c -emit-llvm -S -o ${i}.ll
done

$llvm_build/bin/llvm-link *.ll -S -o link.ll

$llvm_build/bin/llc -march=vex -mcpu=rvex-4issue  link.ll -o ${bench}.s

./script.sh ${bench}.s
cp ../SoftFloat-2b/softfloat/bits32/VEX/rvex-4issue/softfloat_sim.s ./
./script.sh softfloat_sim.s

$cc/cc softfloat_sim.s ${bench}.s -o a

rm *.ll *.o *.s


	
