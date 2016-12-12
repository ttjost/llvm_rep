	.text
	.file	"/Users/ttjost/Dropbox/Universidade/Mestrado/llvm/examples/pcpowerplus/simple.ll"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
# BB#0:                                 # %entry
	vmovdqu	b, %ymm0
	vpaddd	a, %ymm0, %ymm0
	vmovdqu	%ymm0, c
	vmovdqu	b+32, %ymm0
	vpaddd	a+32, %ymm0, %ymm0
	vmovdqu	%ymm0, c+32
	vmovdqu	b+64, %ymm0
	vpaddd	a+64, %ymm0, %ymm0
	vmovdqu	%ymm0, c+64
	vmovdqu	b+96, %ymm0
	vpaddd	a+96, %ymm0, %ymm0
	vmovdqu	%ymm0, c+96
	vmovdqu	b+128, %ymm0
	vpaddd	a+128, %ymm0, %ymm0
	vmovdqu	%ymm0, c+128
	vmovdqu	b+160, %ymm0
	vpaddd	a+160, %ymm0, %ymm0
	vmovdqu	%ymm0, c+160
	vmovdqu	b+192, %ymm0
	vpaddd	a+192, %ymm0, %ymm0
	vmovdqu	%ymm0, c+192
	vmovdqu	b+224, %ymm0
	vpaddd	a+224, %ymm0, %ymm0
	vmovdqu	%ymm0, c+224
	xorl	%eax, %eax
	vzeroupper
	retl
.Lfunc_end0:
	.size	main, .Lfunc_end0-main

	.type	a,@object               # @a
	.comm	a,256,4
	.type	b,@object               # @b
	.comm	b,256,4
	.type	c,@object               # @c
	.comm	c,256,4

	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
