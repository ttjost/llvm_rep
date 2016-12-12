#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 <Benchmark1> <Benchmark2> ... "; exit 1; }

BENCHMARKS=($@)

echo "****************************************"
echo "  Benchmarks:"
for arg in "${BENCHMARKS[@]}"; do
   echo -e "\t$arg"
done
echo "****************************************"

TYPES=(32)
OPT=(O0 O1 O2 O3)
#OPT=(O0 O3)
#OPT=(O0)
#OPT=(O1)
#OPT=(O2)
OPT=(O3)
#FILES=(pipe4.mm pipe8.mm)
FILES=(pipe8.mm)
LLVM_BIN_PATH=~/llvm_build/build/bin
VEX_BIN_PATH=~/vex-3.43/bin

FOLDER=./tmp

success=0
errors=0

successClang=0
errorsClang=0

successLLC=0
errorsLLC=0

successVEX=0
errorsVEX=0

totalExec=0


if [ ! -d "$FOLDER" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir "$FOLDER"
fi

export PATH=${PATH}:${LLVM_BIN_PATH}
rm tmp.txt

for i in ${BENCHMARKS[@]}; do
	for (( j=0; j<${#TYPES[@]}; j++ )); do
		for k in ${OPT[@]}; do
		for w in ${FILES[@]}; do
			totalExec=$((totalExec+1))
			# Generate Front-end file with CLANG
			if [ ! -a ${FOLDER}/${i}_${TYPES[$j]}_$k.ll ]
			then
				echo "CLANG: Creating file ${i}_${TYPES[$j]}_$k.ll "
				clang -c -m32 $i.c -$k -emit-llvm -S -o ${FOLDER}/${i}_${TYPES[$j]}_$k.ll &> tmp.txt
				if [ -s tmp.txt ]
				then
					variable=$(cat tmp.txt)
                    substring=" error"
                    if echo "$variable" | grep -q "$substring"; then
        				echo "CLANG Error: Failed to create ${i}_${TYPES[$j]}_$k.ll. Check tmp.txt file"
        				errorsClang=$((errorsClang+1))
					else
						successClang=$((successClang+1))
						echo "CLANG: OK"
					fi
				else
					successClang=$((successClang+1))
					echo "CLANG: OK"
				fi
			else	
				successClang=$((successClang+1))
				echo "CLANG: File ${i}_${TYPES[$j]}_$k.ll already exists "
			fi
	
			# Generate Assembly with LLC
			if [ ! -a ${FOLDER}/${i}_${TYPES[$j]}_$k.s ]; then
				echo "LLC: Creating file ${i}_${TYPES[$j]}_$k.s"
				#llc -enable-vliw-scheduling -fmm=$w -march=vex -filetype=asm ${FOLDER}/${i}_${TYPES[$j]}_$k.ll -o ${FOLDER}/${i}_${TYPES[$j]}_$k.s &> tmp${i}_${TYPES[$j]}_$k.txt
				llc -enable-vliw-scheduling -march=vex -filetype=asm ${FOLDER}/${i}_${TYPES[$j]}_$k.ll -o ${FOLDER}/${i}_${TYPES[$j]}_$k.s &> tmp${i}_${TYPES[$j]}_$k.txt
				
				line=$(head -n 1 tmp.txt)
				if [ -s tmp.txt ] ; then
					substring1=$(grep -H "Stack dump" tmp.txt);
					substring2=$(grep -H "ERROR" tmp.txt);
					if [ ! -z "$substring1" -o ! -z "$substring2" ]; then
						errorsLLC=$((errorsLLC+1))
						echo "*************      ERROR      **************"
						echo "LLC Error: Failed to ${i}_${TYPES[$j]}_$k.s. Check tmp.txt file"
						echo "**********************************************************";
					else
						successLLC=$((successLLC+1))
						echo "LLC: OK"
						sed -i -e 's/\.rodata.*/\.data/g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						sed -i -e 's/\.bss.*/\.bss \.section \.data/g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						sed -i -e 's/\.comm/\.section \.data  \.comm /g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						echo '.import printf' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						echo '.type printf, @function' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						echo '.import puts' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
						echo '.type puts, @function' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					fi
				else
					successLLC=$((successLLC+1))
					echo "LLC: OK"
					sed -i -e 's/\.rodata.*/\.data/g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					sed -i -e 's/\.bss.*/\.bss \.section \.data/g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					sed -i -e 's/\.comm/\.section \.data  \.comm /g' ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					echo '.import printf' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					echo '.type printf, @function' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					echo '.import puts' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
					echo '.type puts, @function' >> ${FOLDER}/${i}_${TYPES[$j]}_$k.s
				fi
			else
				successLLC=$((successLLC+1))
				echo "LLC: File ${i}_${TYPES[$j]}_$k.s already exists"
			fi
		
			# Simulate Executable
			#if [ ! -a ${FOLDER}/${i}_${TYPES[$j]}_$k.log ]; then
				echo "VEX CC: Executing benchmark ${i}_${TYPES[$j]}_$k.s"
				${VEX_BIN_PATH}/cc ${FOLDER}/${i}_${TYPES[$j]}_$k.s -o ${FOLDER}/${i}_${TYPES[$j]}_$k &> tmp.txt
				if [ -s tmp.txt ]; then
					echo "**************      ERROR      **************"
					echo "VEX CC Error: Failed to create executable for ${i}_${TYPES[$j]}_$k.s. Check tmp.txt file"
					echo "***************************************************************";
					errorsVEX=$((errorsVEX+1))
				else
					successVEX=$((successVEX+1))
					echo "VEX CC: OK"
					${FOLDER}/${i}_${TYPES[$j]}_$k > ${FOLDER}/${i}_${TYPES[$j]}_$k.log
					# Save log
					line=$(grep "Avg. IPC (no stalls)" ta.log.000)
					echo "$line"
					echo "$line" >> ${FOLDER}/${i}_${TYPES[$j]}_$k.log
					line=$(grep "cycle counter =" ta.log.000)
					echo "$line"
					echo "$line" >> ${FOLDER}/${i}_${TYPES[$j]}_$k.log
					rm ta.log.000
					
					line=$(head -n 1 ${FOLDER}/${i}_${TYPES[$j]}_$k.log)
					if [ $line == "-1" ]; then
						echo "***************************************************************";
						echo "Success ${i}_${TYPES[$j]}_$k.s";
						echo "***************************************************************";
						success=$((success+1))
					else
						errors=$((errors+1))
						echo "**************  ERROR in ${i}_${TYPES[$j]}_$k.s ***************"
					fi
				fi
		#	fi
		done
		done
	done
done
echo ""
echo "***************************************************************";
echo "                         Statistics"
echo "***************************************************************";
echo "  CLANG "
echo "    Success: $successClang"
echo "    Errors: $errorsClang"
echo "***************************************************************";
echo "  LLC "
echo "    Success: $successLLC"
echo "    Errors: $errorsLLC"
echo "***************************************************************";
echo "  VEX_CC "
echo "    Success: $successVEX"
echo "    Errors: $errorsVEX"
echo "***************************************************************";
echo "  Execution "
echo "    Success: $success"
echo "    Errors: $errors"
echo "***************************************************************";
echo "  Total: $totalExec"
echo "***************************************************************";
