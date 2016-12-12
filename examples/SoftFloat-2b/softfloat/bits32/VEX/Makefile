
PROCESSOR_H = ../../../processors/VEX.h
SOFTFLOAT_MACROS = ../softfloat-macros

ASM = .s
OBJ = .o
IR = .ll
EXE =
INCLUDES = -I. -I..
COMPILE_IR = /llvm_build/build_all/bin/clang -c --target=sparc64-unknown-gnu-linux -S -emit-llvm $(INCLUDES) -c -o $@  -O3
COMPILE_ASM = /llvm_build/build_all/bin/llc -hp-sim=true -march=vex -mcpu=rvex-4issue -o $@
#LINK = gcc -m32 -o $@

ALL: softfloat$(ASM)
#ALL: softfloat$(OBJ) timesoftfloat$(EXE)

milieu.h: $(PROCESSOR_H)
	touch milieu.h

softfloat$(IR): milieu.h softfloat.h softfloat-specialize $(SOFTFLOAT_MACROS) ../softfloat.c
	$(COMPILE_IR) ../softfloat.c

softfloat$(ASM): softfloat$(IR)
	$(COMPILE_ASM) softfloat$(IR)

# softfloat$(OBJ): milieu.h softfloat.h softfloat-specialize $(SOFTFLOAT_MACROS) ../softfloat.c
# 	$(COMPILE_C) ../softfloat.c

# timesoftfloat$(OBJ): milieu.h softfloat.h ../timesoftfloat.c
# 	$(COMPILE_C) ../timesoftfloat.c

# timesoftfloat$(EXE): softfloat$(OBJ) timesoftfloat$(OBJ)
# 	$(LINK) softfloat$(OBJ) timesoftfloat$(OBJ)
