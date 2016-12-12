.section .text
#.globl shift32RightJamming
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shift32RightJamming
shift32RightJamming::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB0_4
;;
## BB#1:                                ## %if.else
	c0	cmpgt $b0.0 = $r0.4, 31
;;
;;
	c0	br $b0.0, LBB0_3
;;
## BB#2:                                ## %if.then.2
	c0	mov $r0.2 = 0
;;
	c0	sub $r0.2 = $r0.2, $r0.4
;;
	c0	and $r0.2 = $r0.2, 31
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
	c0	shru $r0.2 = $r0.3, $r0.4
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.3, $r0.2
;;
.return ret()
	c0	stw 0[$r0.5] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB0_3:                                 ## %if.else.4
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
LBB0_4:                                 ## %if.end.7
.return ret()
	c0	stw 0[$r0.5] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl shift64Right
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shift64Right
shift64Right::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB1_1
;;
## BB#2:                                ## %if.else
	c0	cmpgt $b0.0 = $r0.5, 31
	c0	mov $r0.2 = 0
;;
;;
	c0	br $b0.0, LBB1_4
;;
## BB#3:                                ## %if.then.4
	c0	sub $r0.2 = $r0.2, $r0.5
	c0	shru $r0.4 = $r0.4, $r0.5
;;
	c0	and $r0.8 = $r0.2, 31
	c0	shru $r0.2 = $r0.3, $r0.5
;;
	c0	shl $r0.3 = $r0.3, $r0.8
;;
	c0	or $r0.4 = $r0.3, $r0.4
	c0	goto LBB1_5
;;
LBB1_1:
	c0	mov $r0.2 = $r0.3
	c0	goto LBB1_5
;;
LBB1_4:                                 ## %if.else.7
	c0	and $r0.4 = $r0.5, 31
	c0	cmplt $b0.0 = $r0.5, 64
;;
	c0	shru $r0.3 = $r0.3, $r0.4
;;
	c0	slct $r0.4 = $b0.0, $r0.3, 0
;;
LBB1_5:                                 ## %if.end.12
	c0	stw 0[$r0.7] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.6] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl shift64RightJamming
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shift64RightJamming
shift64RightJamming::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB2_1
;;
## BB#2:                                ## %if.else
	c0	mov $r0.2 = 0
	c0	cmpgt $b0.0 = $r0.5, 31
;;
	c0	sub $r0.8 = $r0.2, $r0.5
;;
	c0	and $r0.8 = $r0.8, 31
	c0	br $b0.0, LBB2_4
;;
## BB#3:                                ## %if.then.4
	c0	shl $r0.2 = $r0.4, $r0.8
	c0	shl $r0.8 = $r0.3, $r0.8
	c0	shru $r0.4 = $r0.4, $r0.5
;;
	c0	cmpne $b0.0 = $r0.2, 0
	c0	shru $r0.2 = $r0.3, $r0.5
	c0	or $r0.3 = $r0.8, $r0.4
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.4 = $r0.3, $r0.4
	c0	goto LBB2_9
;;
LBB2_1:
	c0	mov $r0.2 = $r0.3
	c0	goto LBB2_9
;;
LBB2_4:                                 ## %if.else.12
	c0	cmpne $b0.0 = $r0.5, 32
;;
;;
	c0	brf $b0.0, LBB2_5
;;
## BB#6:                                ## %if.else.19
	c0	cmpgt $b0.0 = $r0.5, 63
;;
;;
	c0	br $b0.0, LBB2_8
;;
## BB#7:                                ## %if.then.22
	c0	shl $r0.8 = $r0.3, $r0.8
	c0	and $r0.5 = $r0.5, 31
;;
	c0	or $r0.4 = $r0.8, $r0.4
	c0	shru $r0.3 = $r0.3, $r0.5
;;
LBB2_5:                                 ## %if.then.15
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.4 = $r0.4, $r0.3
	c0	goto LBB2_9
;;
LBB2_8:                                 ## %if.else.31
	c0	or $r0.3 = $r0.4, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
LBB2_9:                                 ## %if.end.37
	c0	stw 0[$r0.7] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.6] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl shift64ExtraRightJamming
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shift64ExtraRightJamming
shift64ExtraRightJamming::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB3_8
;;
## BB#1:                                ## %if.else
	c0	mov $r0.2 = 0
	c0	cmpgt $b0.0 = $r0.6, 31
;;
	c0	sub $r0.10 = $r0.2, $r0.6
;;
	c0	and $r0.10 = $r0.10, 31
	c0	br $b0.0, LBB3_3
;;
## BB#2:                                ## %if.then.4
	c0	shru $r0.11 = $r0.4, $r0.6
	c0	shl $r0.12 = $r0.3, $r0.10
	c0	shru $r0.2 = $r0.3, $r0.6
	c0	shl $r0.4 = $r0.4, $r0.10
;;
	c0	or $r0.3 = $r0.12, $r0.11
	c0	goto LBB3_7
;;
LBB3_3:                                 ## %if.else.9
	c0	cmpeq $b0.0 = $r0.6, 32
;;
;;
	c0	br $b0.0, LBB3_7
;;
## BB#4:                                ## %if.else.13
	c0	cmpgt $b0.0 = $r0.6, 63
	c0	or $r0.5 = $r0.5, $r0.4
;;
;;
	c0	br $b0.0, LBB3_6
;;
## BB#5:                                ## %if.then.17
	c0	and $r0.6 = $r0.6, 31
	c0	shl $r0.4 = $r0.3, $r0.10
;;
	c0	shru $r0.3 = $r0.3, $r0.6
	c0	goto LBB3_7
;;
LBB3_6:                                 ## %if.else.22
	c0	cmpne $b0.0 = $r0.3, 0
	c0	cmpeq $b0.1 = $r0.6, 64
	c0	mov $r0.2 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	slct $r0.4 = $b0.1, $r0.3, $r0.4
	c0	mov $r0.3 = $r0.2
;;
LBB3_7:                                 ## %if.end.28
	c0	cmpne $b0.0 = $r0.5, 0
	c0	mov $r0.6 = $r0.3
	c0	mov $r0.3 = $r0.2
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.5 = $r0.2, $r0.4
	c0	mov $r0.4 = $r0.6
;;
LBB3_8:                                 ## %if.end.32
	c0	stw 0[$r0.9] = $r0.5
;;
	c0	stw 0[$r0.8] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.7] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl shortShift64Left
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shortShift64Left
shortShift64Left::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.5, 0
	c0	shl $r0.2 = $r0.4, $r0.5
;;
	c0	stw 0[$r0.7] = $r0.2
;;
	c0	br $b0.0, LBB4_2
;;
## BB#1:                                ## %cond.false
	c0	mov $r0.2 = 0
;;
	c0	sub $r0.2 = $r0.2, $r0.5
;;
	c0	and $r0.2 = $r0.2, 31
	c0	shl $r0.3 = $r0.3, $r0.5
;;
	c0	shru $r0.2 = $r0.4, $r0.2
;;
	c0	or $r0.3 = $r0.2, $r0.3
;;
LBB4_2:                                 ## %cond.end
.return ret()
	c0	stw 0[$r0.6] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl shortShift96Left
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @shortShift96Left
shortShift96Left::
## BB#0:                                ## %entry
	c0	cmplt $b0.0 = $r0.6, 1
	c0	shl $r0.2 = $r0.4, $r0.6
	c0	shl $r0.3 = $r0.3, $r0.6
	c0	shl $r0.10 = $r0.5, $r0.6
;;
;;
	c0	br $b0.0, LBB5_2
;;
## BB#1:                                ## %if.then
	c0	mov $r0.11 = 0
;;
	c0	sub $r0.6 = $r0.11, $r0.6
;;
	c0	and $r0.6 = $r0.6, 31
;;
	c0	shru $r0.5 = $r0.5, $r0.6
	c0	shru $r0.4 = $r0.4, $r0.6
;;
	c0	or $r0.2 = $r0.5, $r0.2
	c0	or $r0.3 = $r0.4, $r0.3
;;
LBB5_2:                                 ## %if.end
	c0	stw 0[$r0.9] = $r0.10
;;
	c0	stw 0[$r0.8] = $r0.2
;;
.return ret()
	c0	stw 0[$r0.7] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl add64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @add64
add64::
## BB#0:                                ## %entry
	c0	add $r0.2 = $r0.6, $r0.4
	c0	add $r0.3 = $r0.5, $r0.3
;;
	c0	cmpltu $r0.4 = $r0.2, $r0.6
;;
	c0	add $r0.3 = $r0.3, $r0.4
	c0	stw 0[$r0.8] = $r0.2
;;
.return ret()
	c0	stw 0[$r0.7] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl add96
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @add96
add96::
## BB#0:                                ## %entry
	c0	add $r0.2 = $r0.8, $r0.5
	c0	add $r0.4 = $r0.7, $r0.4
;;
	c0	cmpltu $r0.5 = $r0.2, $r0.8
	c0	add $r0.3 = $r0.6, $r0.3
	c0	cmpltu $r0.6 = $r0.4, $r0.7
	c0	ldw $r0.7 = 16[$r0.1]
;;
	c0	add $r0.4 = $r0.5, $r0.4
	c0	add $r0.3 = $r0.3, $r0.6
;;
	c0	cmpltu $r0.5 = $r0.4, $r0.5
	c0	stw 0[$r0.7] = $r0.2
;;
	c0	add $r0.2 = $r0.3, $r0.5
	c0	stw 0[$r0.10] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.9] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl sub64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @sub64
sub64::
## BB#0:                                ## %entry
	c0	mov $r0.2 = -1
	c0	cmpltu $r0.9 = $r0.4, $r0.6
;;
	c0	mtb $b0.0 = $r0.9
	c0	sub $r0.3 = $r0.3, $r0.5
	c0	sub $r0.4 = $r0.4, $r0.6
;;
;;
	c0	slct $r0.2 = $b0.0, $r0.2, 0
;;
	c0	add $r0.2 = $r0.3, $r0.2
	c0	stw 0[$r0.8] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.7] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl sub96
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @sub96
sub96::
## BB#0:                                ## %entry
	c0	cmpltu $b0.0 = $r0.5, $r0.8
	c0	cmpltu $r0.2 = $r0.4, $r0.7
	c0	sub $r0.4 = $r0.4, $r0.7
	c0	mov $r0.7 = -1
;;
;;
	c0	mfb $r0.11 = $b0.0
	c0	mtb $b0.0 = $r0.2
;;
	c0	cmpltu $r0.2 = $r0.4, $r0.11
	c0	sub $r0.3 = $r0.3, $r0.6
;;
	c0	slct $r0.6 = $b0.0, $r0.7, 0
	c0	ldw $r0.12 = 16[$r0.1]
	c0	mtb $b0.0 = $r0.2
;;
	c0	add $r0.2 = $r0.3, $r0.6
	c0	sub $r0.3 = $r0.5, $r0.8
;;
	c0	slct $r0.5 = $b0.0, $r0.7, 0
	c0	stw 0[$r0.12] = $r0.3
	c0	sub $r0.3 = $r0.4, $r0.11
;;
	c0	add $r0.2 = $r0.2, $r0.5
	c0	stw 0[$r0.10] = $r0.3
;;
.return ret()
	c0	stw 0[$r0.9] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl mul32To64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @mul32To64
mul32To64::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 16
	c0	zxth $r0.7 = $r0.4
	c0	zxth $r0.8 = $r0.3
;;
	c0	shru $r0.3 = $r0.3, $r0.2
	c0	shru $r0.4 = $r0.4, $r0.2
;;
	c0	mpyhs $r0.9 = $r0.7, $r0.3
	c0	mpylu $r0.10 = $r0.7, $r0.3
;;
	c0	mpylu $r0.11 = $r0.4, $r0.8
	c0	mpyhs $r0.12 = $r0.4, $r0.8
;;
	c0	mpyhs $r0.13 = $r0.7, $r0.8
	c0	add $r0.9 = $r0.10, $r0.9
;;
	c0	add $r0.10 = $r0.11, $r0.12
	c0	mpylu $r0.7 = $r0.7, $r0.8
;;
	c0	add $r0.8 = $r0.10, $r0.9
	c0	mpyhs $r0.9 = $r0.4, $r0.3
	c0	mpylu $r0.3 = $r0.4, $r0.3
;;
	c0	add $r0.4 = $r0.7, $r0.13
	c0	cmpltu $r0.7 = $r0.8, $r0.10
	c0	shl $r0.10 = $r0.8, $r0.2
	c0	shru $r0.8 = $r0.8, $r0.2
;;
	c0	shl $r0.2 = $r0.7, $r0.2
	c0	add $r0.3 = $r0.3, $r0.9
	c0	add $r0.4 = $r0.10, $r0.4
;;
	c0	or $r0.2 = $r0.2, $r0.8
	c0	cmpltu $r0.7 = $r0.4, $r0.10
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
	c0	add $r0.2 = $r0.2, $r0.7
	c0	stw 0[$r0.6] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.5] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl mul64By32To96
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @mul64By32To96
mul64By32To96::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 16
	c0	zxth $r0.9 = $r0.5
;;
	c0	shru $r0.10 = $r0.3, $r0.2
	c0	shru $r0.11 = $r0.4, $r0.2
	c0	shru $r0.5 = $r0.5, $r0.2
	c0	zxth $r0.4 = $r0.4
;;
	c0	zxth $r0.3 = $r0.3
	c0	mpylu $r0.12 = $r0.9, $r0.10
	c0	mpyhs $r0.13 = $r0.9, $r0.10
;;
	c0	mpylu $r0.14 = $r0.5, $r0.4
	c0	mpyhs $r0.15 = $r0.5, $r0.4
;;
	c0	mpyhs $r0.16 = $r0.5, $r0.3
	c0	mpylu $r0.17 = $r0.5, $r0.3
	c0	add $r0.12 = $r0.12, $r0.13
;;
	c0	mpylu $r0.13 = $r0.9, $r0.11
	c0	mpyhs $r0.18 = $r0.9, $r0.11
;;
	c0	add $r0.16 = $r0.17, $r0.16
	c0	add $r0.14 = $r0.14, $r0.15
;;
	c0	add $r0.13 = $r0.13, $r0.18
	c0	mpyhs $r0.15 = $r0.9, $r0.3
	c0	mpylu $r0.3 = $r0.9, $r0.3
	c0	add $r0.12 = $r0.16, $r0.12
;;
	c0	add $r0.13 = $r0.14, $r0.13
	c0	mpylu $r0.17 = $r0.9, $r0.4
	c0	mpyhs $r0.4 = $r0.9, $r0.4
	c0	shl $r0.9 = $r0.12, $r0.2
;;
	c0	mpyhs $r0.18 = $r0.5, $r0.11
	c0	mpylu $r0.11 = $r0.5, $r0.11
	c0	cmpltu $r0.14 = $r0.13, $r0.14
	c0	add $r0.3 = $r0.3, $r0.15
;;
	c0	add $r0.3 = $r0.9, $r0.3
	c0	shru $r0.15 = $r0.13, $r0.2
	c0	shl $r0.14 = $r0.14, $r0.2
	c0	add $r0.4 = $r0.17, $r0.4
;;
	c0	shl $r0.13 = $r0.13, $r0.2
	c0	add $r0.11 = $r0.11, $r0.18
	c0	or $r0.14 = $r0.14, $r0.15
	c0	cmpltu $r0.15 = $r0.12, $r0.16
;;
	c0	add $r0.4 = $r0.13, $r0.4
	c0	add $r0.11 = $r0.3, $r0.11
	c0	mpylu $r0.16 = $r0.5, $r0.10
	c0	mpyhs $r0.5 = $r0.5, $r0.10
;;
	c0	cmpltu $r0.10 = $r0.4, $r0.13
	c0	add $r0.11 = $r0.11, $r0.14
	c0	shl $r0.13 = $r0.15, $r0.2
	c0	shru $r0.2 = $r0.12, $r0.2
;;
	c0	add $r0.10 = $r0.11, $r0.10
	c0	add $r0.5 = $r0.16, $r0.5
	c0	or $r0.2 = $r0.13, $r0.2
	c0	cmpltu $r0.9 = $r0.3, $r0.9
;;
	c0	cmpltu $b0.0 = $r0.10, $r0.3
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.2, $r0.9
;;
	c0	mfb $r0.3 = $b0.0
	c0	stw 0[$r0.8] = $r0.4
;;
	c0	add $r0.2 = $r0.2, $r0.3
	c0	stw 0[$r0.7] = $r0.10
;;
.return ret()
	c0	stw 0[$r0.6] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl mul64To128
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @mul64To128
mul64To128::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 16
	c0	zxth $r0.11 = $r0.6
	c0	zxth $r0.12 = $r0.4
;;
	c0	shru $r0.13 = $r0.5, $r0.2
	c0	shru $r0.4 = $r0.4, $r0.2
	c0	shru $r0.6 = $r0.6, $r0.2
	c0	zxth $r0.5 = $r0.5
;;
	c0	mpylu $r0.14 = $r0.11, $r0.4
	c0	mpyhs $r0.15 = $r0.11, $r0.4
;;
	c0	mpylu $r0.16 = $r0.6, $r0.12
	c0	mpyhs $r0.17 = $r0.6, $r0.12
	c0	shru $r0.18 = $r0.3, $r0.2
;;
	c0	mpylu $r0.19 = $r0.5, $r0.4
	c0	mpyhs $r0.20 = $r0.5, $r0.4
	c0	zxth $r0.3 = $r0.3
;;
	c0	mpylu $r0.21 = $r0.13, $r0.12
	c0	mpyhs $r0.22 = $r0.13, $r0.12
	c0	add $r0.14 = $r0.14, $r0.15
	c0	add $r0.15 = $r0.16, $r0.17
;;
	c0	mpylu $r0.16 = $r0.5, $r0.12
	c0	mpyhs $r0.17 = $r0.5, $r0.12
	c0	add $r0.19 = $r0.19, $r0.20
	c0	add $r0.14 = $r0.15, $r0.14
;;
	c0	add $r0.20 = $r0.21, $r0.22
	c0	mpyhs $r0.21 = $r0.6, $r0.4
	c0	mpylu $r0.22 = $r0.6, $r0.4
	c0	cmpltu $r0.15 = $r0.14, $r0.15
;;
	c0	add $r0.19 = $r0.20, $r0.19
	c0	mpylu $r0.23 = $r0.11, $r0.12
	c0	mpyhs $r0.12 = $r0.11, $r0.12
	c0	add $r0.16 = $r0.16, $r0.17
;;
	c0	shl $r0.17 = $r0.19, $r0.2
	c0	shru $r0.24 = $r0.14, $r0.2
	c0	shl $r0.15 = $r0.15, $r0.2
	c0	shl $r0.14 = $r0.14, $r0.2
;;
	c0	mpyhs $r0.25 = $r0.5, $r0.18
	c0	mpylu $r0.26 = $r0.5, $r0.18
	c0	add $r0.16 = $r0.17, $r0.16
	c0	add $r0.21 = $r0.22, $r0.21
;;
	c0	mpyhs $r0.22 = $r0.13, $r0.3
	c0	mpylu $r0.27 = $r0.13, $r0.3
	c0	add $r0.12 = $r0.23, $r0.12
	c0	add $r0.21 = $r0.16, $r0.21
;;
	c0	mpylu $r0.23 = $r0.5, $r0.3
	c0	mpyhs $r0.5 = $r0.5, $r0.3
	c0	add $r0.25 = $r0.26, $r0.25
	c0	add $r0.12 = $r0.14, $r0.12
;;
	c0	add $r0.22 = $r0.27, $r0.22
	c0	mpylu $r0.26 = $r0.11, $r0.18
	c0	mpyhs $r0.27 = $r0.11, $r0.18
	c0	or $r0.15 = $r0.15, $r0.24
;;
	c0	mpyhs $r0.24 = $r0.6, $r0.3
	c0	mpylu $r0.28 = $r0.6, $r0.3
	c0	add $r0.25 = $r0.22, $r0.25
	c0	cmpltu $r0.20 = $r0.19, $r0.20
;;
	c0	mpyhs $r0.29 = $r0.13, $r0.4
	c0	mpylu $r0.4 = $r0.13, $r0.4
	c0	cmpltu $r0.14 = $r0.12, $r0.14
	c0	add $r0.15 = $r0.21, $r0.15
;;
	c0	shl $r0.21 = $r0.25, $r0.2
	c0	add $r0.5 = $r0.23, $r0.5
	c0	add $r0.23 = $r0.26, $r0.27
	c0	add $r0.24 = $r0.28, $r0.24
;;
	c0	add $r0.23 = $r0.24, $r0.23
	c0	add $r0.14 = $r0.15, $r0.14
	c0	add $r0.5 = $r0.21, $r0.5
	c0	add $r0.4 = $r0.4, $r0.29
;;
	c0	mpylu $r0.15 = $r0.11, $r0.3
	c0	mpyhs $r0.3 = $r0.11, $r0.3
	c0	shru $r0.11 = $r0.19, $r0.2
	c0	shl $r0.19 = $r0.20, $r0.2
;;
	c0	cmpltu $r0.20 = $r0.23, $r0.24
	c0	cmpltu $b0.0 = $r0.14, $r0.16
	c0	mpyhs $r0.24 = $r0.6, $r0.18
	c0	mpylu $r0.6 = $r0.6, $r0.18
;;
	c0	or $r0.11 = $r0.19, $r0.11
	c0	add $r0.4 = $r0.5, $r0.4
	c0	shru $r0.19 = $r0.23, $r0.2
	c0	shl $r0.20 = $r0.20, $r0.2
;;
	c0	shl $r0.23 = $r0.23, $r0.2
	c0	add $r0.3 = $r0.15, $r0.3
	c0	add $r0.4 = $r0.4, $r0.11
	c0	cmpltu $r0.11 = $r0.16, $r0.17
;;
	c0	add $r0.3 = $r0.23, $r0.3
	c0	cmpltu $r0.15 = $r0.25, $r0.22
	c0	add $r0.6 = $r0.6, $r0.24
	c0	or $r0.16 = $r0.20, $r0.19
;;
	c0	mfb $r0.17 = $b0.0
	c0	add $r0.4 = $r0.4, $r0.11
	c0	mpylu $r0.11 = $r0.13, $r0.18
	c0	mpyhs $r0.13 = $r0.13, $r0.18
;;
	c0	add $r0.18 = $r0.14, $r0.3
	c0	add $r0.4 = $r0.4, $r0.17
	c0	shl $r0.15 = $r0.15, $r0.2
	c0	shru $r0.2 = $r0.25, $r0.2
;;
	c0	cmpltu $r0.3 = $r0.3, $r0.23
	c0	add $r0.6 = $r0.16, $r0.6
	c0	cmpltu $b0.0 = $r0.4, $r0.5
	c0	cmpltu $r0.14 = $r0.18, $r0.14
;;
	c0	add $r0.3 = $r0.6, $r0.3
	c0	or $r0.2 = $r0.15, $r0.2
	c0	add $r0.6 = $r0.11, $r0.13
	c0	cmpltu $r0.5 = $r0.5, $r0.21
;;
	c0	add $r0.2 = $r0.2, $r0.6
	c0	add $r0.3 = $r0.3, $r0.14
	c0	mfb $r0.6 = $b0.0
;;
	c0	add $r0.2 = $r0.2, $r0.5
	c0	add $r0.4 = $r0.3, $r0.4
	c0	stw 0[$r0.10] = $r0.12
;;
	c0	cmpltu $r0.3 = $r0.4, $r0.3
	c0	add $r0.2 = $r0.2, $r0.6
	c0	stw 0[$r0.9] = $r0.18
;;
	c0	add $r0.2 = $r0.2, $r0.3
	c0	stw 0[$r0.8] = $r0.4
;;
.return ret()
	c0	stw 0[$r0.7] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl eq64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @eq64
eq64::
## BB#0:                                ## %entry
	c0	cmpeq $b0.0 = $r0.4, $r0.6
	c0	cmpeq $b0.1 = $r0.3, $r0.5
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.2, 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl le64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @le64
le64::
## BB#0:                                ## %entry
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB14_2
;;
## BB#1:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB14_2:                                ## %lor.rhs
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB14_3
;;
## BB#4:                                ## %land.rhs
	c0	cmpleu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB14_3:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl lt64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @lt64
lt64::
## BB#0:                                ## %entry
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB15_2
;;
## BB#1:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB15_2:                                ## %lor.rhs
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB15_3
;;
## BB#4:                                ## %land.rhs
	c0	cmpltu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB15_3:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl ne64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @ne64
ne64::
## BB#0:                                ## %entry
	c0	cmpne $b0.0 = $r0.4, $r0.6
	c0	cmpeq $b0.1 = $r0.3, $r0.5
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float_raise
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float_raise
float_raise::
## BB#0:                                ## %entry
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.3 = $r0.4, $r0.3
;;
.return ret()
	c0	stb 0[$r0.2] = $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_is_nan
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_is_nan
float32_is_nan::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.2, 2139095040
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_is_signaling_nan
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_is_signaling_nan
float32_is_signaling_nan::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 4194303
	c0	and $r0.3 = $r0.3, 2143289344
;;
	c0	cmpne $b0.0 = $r0.2, 0
	c0	cmpeq $b0.1 = $r0.3, 2139095040
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.2, 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_is_nan
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_is_nan
float64_is_nan::
## BB#0:                                ## %entry
	c0	add $r0.2 = $r0.3, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.2, -2097152
;;
;;
	c0	br $b0.0, LBB20_1
;;
## BB#2:                                ## %land.rhs
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB20_4
;;
## BB#3:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB20_1:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB20_4:                                ## %lor.rhs
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_is_signaling_nan
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_is_signaling_nan
float64_is_signaling_nan::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB21_1
;;
## BB#2:                                ## %land.rhs
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB21_4
;;
## BB#3:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB21_1:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB21_4:                                ## %lor.rhs
	c0	and $r0.2 = $r0.3, 524287
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat32Frac
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat32Frac
extractFloat32Frac::
## BB#0:                                ## %entry
.return ret($r0.3:u32)
	c0	and $r0.3 = $r0.3, 8388607
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat32Exp
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat32Exp
extractFloat32Exp::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 23
;;
	c0	shru $r0.2 = $r0.3, $r0.2
;;
.return ret($r0.3:u32)
	c0	zxtb $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat32Sign
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat32Sign
extractFloat32Sign::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 31
;;
.return ret($r0.3:u32)
	c0	shru $r0.3 = $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl packFloat32
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @packFloat32
packFloat32::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 31
	c0	mov $r0.6 = 23
;;
	c0	shl $r0.2 = $r0.3, $r0.2
	c0	shl $r0.3 = $r0.4, $r0.6
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
.return ret($r0.3:u32)
	c0	add $r0.3 = $r0.2, $r0.5
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat64Frac1
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat64Frac1
extractFloat64Frac1::
## BB#0:                                ## %entry
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat64Frac0
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat64Frac0
extractFloat64Frac0::
## BB#0:                                ## %entry
.return ret($r0.3:u32)
	c0	and $r0.3 = $r0.3, 1048575
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat64Exp
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat64Exp
extractFloat64Exp::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 20
;;
	c0	shru $r0.2 = $r0.3, $r0.2
;;
.return ret($r0.3:u32)
	c0	and $r0.3 = $r0.2, 2047
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl extractFloat64Sign
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @extractFloat64Sign
extractFloat64Sign::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 31
;;
.return ret($r0.3:u32)
	c0	shru $r0.3 = $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl packFloat64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @packFloat64
packFloat64::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 31
	c0	mov $r0.7 = 20
;;
	c0	shl $r0.2 = $r0.3, $r0.2
	c0	shl $r0.3 = $r0.4, $r0.7
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.3 = $r0.2, $r0.5
	c0	mov $r0.4 = $r0.6
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl int32_to_float32
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @int32_to_float32
int32_to_float32::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = $r0.3
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB31_2
;;
## BB#1:
	c0	mov $r0.3 = 0
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB31_2:                                ## %entry
	c0	cmpne $b0.0 = $r0.2, -2147483648
;;
;;
	c0	br $b0.0, LBB31_4
;;
## BB#3:                                ## %if.then.2
	c0	mov $r0.3 = -822083584
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB31_4:                                ## %if.end.3
	c0	mov $r0.3 = 31
	c0	mov $r0.4 = 0
	c0	mov $r0.5 = 16
;;
	c0	shru $r0.3 = $r0.2, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
	c0	sub $r0.4 = $r0.4, $r0.2
;;
;;
	c0	slct $r0.2 = $b0.0, $r0.4, $r0.2
;;
	c0	cmpltu $b0.0 = $r0.2, 65536
	c0	shl $r0.4 = $r0.2, $r0.5
;;
;;
	c0	slct $r0.4 = $b0.0, $r0.4, $r0.2
	c0	mov $r0.5 = 4
	c0	mfb $r0.6 = $b0.0
;;
	c0	cmpgtu $b0.0 = $r0.4, 16777215
	c0	shl $r0.5 = $r0.6, $r0.5
;;
;;
	c0	br $b0.0, LBB31_6
;;
## BB#5:                                ## %if.then.4.i.i
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.6 = 8
;;
	c0	shl $r0.4 = $r0.4, $r0.6
	c0	zxtb $r0.5 = $r0.5
;;
LBB31_6:                                ## %normalizeRoundAndPackFloat32.exit
	c0	mov $r0.6 = 24
	c0	mov $r0.7 = countLeadingZeros32.countLeadingZerosHigh
	c0	mov $r0.8 = 156
;;
	c0	shru $r0.4 = $r0.4, $r0.6
;;
	c0	add $r0.4 = $r0.7, $r0.4
;;
	c0	ldb $r0.4 = 0[$r0.4]
;;
;;
	c0	add $r0.4 = $r0.4, $r0.5
;;
	c0	shl $r0.4 = $r0.4, $r0.6
;;
	c0	add $r0.4 = $r0.4, -16777216
;;
	c0	shr $r0.4 = $r0.4, $r0.6
;;
	c0	shl $r0.5 = $r0.2, $r0.4
	c0	sub $r0.4 = $r0.8, $r0.4
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl int32_to_float64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @int32_to_float64
int32_to_float64::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 0
	c0	cmpeq $b0.0 = $r0.3, 0
;;
	c0	mov $r0.4 = $r0.2
;;
	c0	br $b0.0, LBB32_10
;;
## BB#1:                                ## %if.end
	c0	mov $r0.2 = 31
	c0	mov $r0.4 = 0
	c0	mov $r0.6 = 16
;;
	c0	shru $r0.5 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	sub $r0.7 = $r0.4, $r0.3
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.7, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.3, 65536
	c0	shl $r0.6 = $r0.3, $r0.6
;;
;;
	c0	slct $r0.6 = $b0.0, $r0.6, $r0.3
	c0	mov $r0.7 = 4
	c0	mfb $r0.8 = $b0.0
;;
	c0	cmpgtu $b0.0 = $r0.6, 16777215
	c0	shl $r0.7 = $r0.8, $r0.7
;;
;;
	c0	br $b0.0, LBB32_3
;;
## BB#2:                                ## %if.then.4.i.36
	c0	or $r0.7 = $r0.7, 8
	c0	mov $r0.8 = 8
;;
	c0	shl $r0.6 = $r0.6, $r0.8
	c0	zxtb $r0.7 = $r0.7
;;
LBB32_3:                                ## %countLeadingZeros32.exit
	c0	mov $r0.8 = 24
	c0	mov $r0.9 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.6 = $r0.6, $r0.8
;;
	c0	add $r0.6 = $r0.9, $r0.6
;;
	c0	ldb $r0.6 = 0[$r0.6]
;;
;;
	c0	add $r0.6 = $r0.6, $r0.7
;;
	c0	shl $r0.6 = $r0.6, $r0.8
;;
	c0	add $r0.7 = $r0.6, -184549376
;;
	c0	cmplt $b0.0 = $r0.7, -16777215
	c0	shr $r0.6 = $r0.7, $r0.8
;;
;;
	c0	br $b0.0, LBB32_5
;;
## BB#4:                                ## %if.then.11
	c0	shl $r0.3 = $r0.3, $r0.6
	c0	goto LBB32_9
;;
LBB32_5:                                ## %if.else
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB32_9
;;
## BB#6:                                ## %if.else.i
	c0	cmplt $b0.0 = $r0.7, -536870911
	c0	sub $r0.4 = $r0.4, $r0.6
;;
;;
	c0	br $b0.0, LBB32_8
;;
## BB#7:                                ## %if.then.4.i
	c0	shru $r0.7 = $r0.3, $r0.4
	c0	and $r0.4 = $r0.6, 31
;;
	c0	shl $r0.4 = $r0.3, $r0.4
	c0	mov $r0.3 = $r0.7
	c0	goto LBB32_9
;;
LBB32_8:                                ## %if.else.7.i
	c0	and $r0.4 = $r0.4, 31
	c0	cmpgt $b0.0 = $r0.7, -1073741824
;;
	c0	shru $r0.4 = $r0.3, $r0.4
	c0	mov $r0.3 = 0
;;
	c0	slct $r0.4 = $b0.0, $r0.4, 0
;;
LBB32_9:                                ## %if.end.15
	c0	mov $r0.7 = 1042
	c0	mov $r0.8 = 20
	c0	shl $r0.2 = $r0.5, $r0.2
;;
	c0	sub $r0.5 = $r0.7, $r0.6
;;
	c0	shl $r0.5 = $r0.5, $r0.8
;;
	c0	add $r0.2 = $r0.5, $r0.2
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
LBB32_10:                               ## %cleanup
.return ret($r0.3:u32,$r0.4:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_to_int32
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_to_int32
float32_to_int32::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 23
	c0	mov $r0.8 = 31
;;
	c0	shru $r0.6 = $r0.3, $r0.2
;;
	c0	zxtb $r0.4 = $r0.6
;;
	c0	add $r0.7 = $r0.4, -150
;;
	c0	cmplt $b0.0 = $r0.7, 0
	c0	and $r0.5 = $r0.3, 8388607
	c0	shru $r0.2 = $r0.3, $r0.8
;;
;;
	c0	br $b0.0, LBB33_8
;;
## BB#1:                                ## %if.then
	c0	cmpltu $b0.0 = $r0.4, 158
;;
;;
	c0	br $b0.0, LBB33_7
;;
## BB#2:                                ## %if.then.4
	c0	cmpeq $b0.0 = $r0.3, -822083584
;;
;;
	c0	br $b0.0, LBB33_6
;;
## BB#3:                                ## %if.then.6
	c0	mov $r0.6 = float_exception_flags
	c0	cmpeq $b0.0 = $r0.2, 0
;;
	c0	ldb $r0.2 = 0[$r0.6]
	c0	mov $r0.3 = 2147483647
;;
;;
	c0	or $r0.2 = $r0.2, 1
;;
	c0	stb 0[$r0.6] = $r0.2
	c0	br $b0.0, LBB33_20
;;
## BB#4:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB33_6
;;
## BB#5:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.4, 255
;;
;;
	c0	br $b0.0, LBB33_20
;;
LBB33_6:                                ## %if.end.10
.return ret($r0.3:u32)
	c0	mov $r0.3 = -2147483648
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB33_8:                                ## %if.else
	c0	cmpgtu $b0.0 = $r0.4, 125
;;
;;
	c0	br $b0.0, LBB33_10
;;
## BB#9:                                ## %if.then.17
	c0	mov $r0.3 = 0
	c0	or $r0.4 = $r0.4, $r0.5
	c0	goto LBB33_11
;;
LBB33_7:                                ## %if.end.11
	c0	or $r0.3 = $r0.5, 8388608
	c0	cmpeq $b0.0 = $r0.2, 0
;;
	c0	shl $r0.2 = $r0.3, $r0.7
	c0	mov $r0.3 = 0
;;
	c0	sub $r0.3 = $r0.3, $r0.2
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.0, $r0.2, $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB33_10:                               ## %if.else.19
	c0	add $r0.3 = $r0.6, 10
	c0	mov $r0.6 = 150
	c0	or $r0.5 = $r0.5, 8388608
;;
	c0	sub $r0.4 = $r0.6, $r0.4
	c0	and $r0.6 = $r0.3, 31
;;
	c0	shru $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.6
;;
LBB33_11:                               ## %if.end.23
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB33_13
;;
## BB#12:                               ## %if.then.25
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.6 = 0[$r0.5]
;;
;;
	c0	or $r0.6 = $r0.6, 32
;;
	c0	stb 0[$r0.5] = $r0.6
;;
LBB33_13:                               ## %if.end.28
	c0	mov $r0.5 = float_rounding_mode
;;
	c0	ldbu $r0.5 = 0[$r0.5]
;;
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB33_14
;;
## BB#17:                               ## %if.else.47
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB33_19
;;
## BB#18:                               ## %if.then.51
	c0	cmpeq $b0.0 = $r0.5, 1
	c0	cmpne $b0.1 = $r0.4, 0
	c0	mov $r0.2 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
	c0	mfb $r0.5 = $b0.1
;;
	c0	and $r0.4 = $r0.5, $r0.4
;;
	c0	and $r0.4 = $r0.4, 1
;;
	c0	add $r0.3 = $r0.3, $r0.4
;;
.return ret($r0.3:u32)
	c0	sub $r0.3 = $r0.2, $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB33_14:                               ## %if.then.32
	c0	cmpgt $b0.0 = $r0.4, -1
;;
;;
	c0	br $b0.0, LBB33_16
;;
## BB#15:                               ## %if.then.35
	c0	and $r0.4 = $r0.4, 2147483647
	c0	add $r0.3 = $r0.3, 1
;;
	c0	and $r0.5 = $r0.3, -2
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.5, $r0.3
;;
LBB33_16:                               ## %if.end.42
	c0	mov $r0.4 = 0
	c0	cmpeq $b0.0 = $r0.2, 0
;;
	c0	sub $r0.2 = $r0.4, $r0.3
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB33_19:                               ## %if.else.57
	c0	cmpeq $b0.0 = $r0.5, 2
	c0	cmpne $b0.1 = $r0.4, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
	c0	mfb $r0.4 = $b0.1
;;
	c0	and $r0.2 = $r0.4, $r0.2
;;
	c0	and $r0.2 = $r0.2, 1
;;
	c0	add $r0.3 = $r0.2, $r0.3
;;
LBB33_20:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_to_int32_round_to_zero
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_to_int32_round_to_zero
float32_to_int32_round_to_zero::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 23
	c0	mov $r0.4 = 31
;;
	c0	shru $r0.6 = $r0.3, $r0.2
;;
	c0	zxtb $r0.2 = $r0.6
;;
	c0	add $r0.5 = $r0.2, -158
;;
	c0	cmplt $b0.0 = $r0.5, 0
	c0	and $r0.5 = $r0.3, 8388607
	c0	shru $r0.4 = $r0.3, $r0.4
;;
;;
	c0	br $b0.0, LBB34_6
;;
## BB#1:                                ## %if.then
	c0	cmpeq $b0.0 = $r0.3, -822083584
;;
;;
	c0	br $b0.0, LBB34_5
;;
## BB#2:                                ## %if.then.4
	c0	mov $r0.6 = float_exception_flags
	c0	cmpeq $b0.0 = $r0.4, 0
;;
	c0	ldb $r0.4 = 0[$r0.6]
	c0	mov $r0.3 = 2147483647
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.6] = $r0.4
	c0	br $b0.0, LBB34_12
;;
## BB#3:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB34_5
;;
## BB#4:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB34_12
;;
LBB34_5:                                ## %if.end.8
.return ret($r0.3:u32)
	c0	mov $r0.3 = -2147483648
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB34_6:                                ## %if.else
	c0	cmpgtu $b0.0 = $r0.2, 126
;;
;;
	c0	br $b0.0, LBB34_9
;;
## BB#7:                                ## %if.then.10
	c0	or $r0.2 = $r0.2, $r0.5
	c0	mov $r0.3 = 0
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB34_12
;;
## BB#8:                                ## %if.then.12
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 32
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB34_9:                                ## %if.end.17
	c0	mov $r0.3 = 8
	c0	add $r0.6 = $r0.6, 2
	c0	mov $r0.7 = 158
;;
	c0	shl $r0.3 = $r0.5, $r0.3
	c0	and $r0.5 = $r0.6, 31
;;
	c0	or $r0.3 = $r0.3, -2147483648
	c0	sub $r0.2 = $r0.7, $r0.2
;;
	c0	shl $r0.5 = $r0.3, $r0.5
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB34_11
;;
## BB#10:                               ## %if.then.22
	c0	mov $r0.3 = float_exception_flags
;;
	c0	ldb $r0.5 = 0[$r0.3]
;;
;;
	c0	or $r0.5 = $r0.5, 32
;;
	c0	stb 0[$r0.3] = $r0.5
;;
LBB34_11:                               ## %if.end.26
	c0	mov $r0.3 = 0
	c0	cmpeq $b0.0 = $r0.4, 0
;;
	c0	sub $r0.3 = $r0.3, $r0.2
;;
	c0	slct $r0.3 = $b0.0, $r0.2, $r0.3
;;
LBB34_12:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_to_float64
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_to_float64
float32_to_float64::
## BB#0:                                ## %entry
	c0	mov $r0.4 = 23
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.4 = $r0.3, $r0.4
;;
	c0	zxtb $r0.6 = $r0.4
;;
	c0	cmpeq $b0.0 = $r0.6, 0
	c0	and $r0.4 = $r0.3, 8388607
	c0	shru $r0.5 = $r0.3, $r0.2
;;
;;
	c0	brf $b0.0, LBB35_1
;;
## BB#8:                                ## %if.then.9
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB35_9
;;
## BB#10:                               ## %if.end.13
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.6 = 16
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.3 = $r0.3, $r0.6
;;
	c0	mfb $r0.6 = $b0.0
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.3, 16777215
	c0	shl $r0.6 = $r0.6, $r0.7
;;
;;
	c0	br $b0.0, LBB35_12
;;
## BB#11:                               ## %if.then.4.i.i
	c0	or $r0.6 = $r0.6, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	zxtb $r0.6 = $r0.6
;;
LBB35_12:                               ## %normalizeFloat32Subnormal.exit
	c0	mov $r0.7 = 24
	c0	mov $r0.8 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.3 = $r0.3, $r0.7
;;
	c0	add $r0.3 = $r0.8, $r0.3
;;
	c0	ldb $r0.3 = 0[$r0.3]
;;
;;
	c0	add $r0.3 = $r0.3, $r0.6
;;
	c0	shl $r0.3 = $r0.3, $r0.7
;;
	c0	add $r0.3 = $r0.3, -134217728
;;
	c0	shr $r0.3 = $r0.3, $r0.7
	c0	mov $r0.6 = 0
;;
	c0	shl $r0.4 = $r0.4, $r0.3
	c0	sub $r0.6 = $r0.6, $r0.3
	c0	goto LBB35_13
;;
LBB35_1:                                ## %entry
	c0	cmpne $b0.0 = $r0.6, 255
;;
;;
	c0	br $b0.0, LBB35_13
;;
## BB#2:                                ## %if.then
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB35_7
;;
## BB#3:                                ## %if.then.3
	c0	and $r0.4 = $r0.3, 2143289344
;;
	c0	cmpne $b0.0 = $r0.4, 2139095040
;;
;;
	c0	br $b0.0, LBB35_6
;;
## BB#4:                                ## %if.then.3
	c0	and $r0.4 = $r0.3, 4194303
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB35_6
;;
## BB#5:                                ## %if.then.i
	c0	mov $r0.4 = float_exception_flags
;;
	c0	ldb $r0.6 = 0[$r0.4]
;;
;;
	c0	or $r0.6 = $r0.6, 1
;;
	c0	stb 0[$r0.4] = $r0.6
;;
LBB35_6:                                ## %float32ToCommonNaN.exit
	c0	mov $r0.4 = 3
	c0	shl $r0.2 = $r0.5, $r0.2
	c0	mov $r0.5 = 29
;;
	c0	shru $r0.6 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.3, $r0.5
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.3 = $r0.2, 2146959360
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB35_13:                               ## %if.end.14
	c0	shl $r0.2 = $r0.5, $r0.2
	c0	mov $r0.3 = 3
	c0	mov $r0.5 = 20
	c0	mov $r0.7 = 29
;;
	c0	or $r0.2 = $r0.2, 939524096
	c0	shl $r0.5 = $r0.6, $r0.5
	c0	shru $r0.3 = $r0.4, $r0.3
;;
	c0	shl $r0.4 = $r0.4, $r0.7
	c0	add $r0.2 = $r0.2, $r0.3
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.3 = $r0.2, $r0.5
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB35_9:                                ## %if.then.11
.return ret($r0.3:u32,$r0.4:u32)
	c0	mov $r0.4 = 0
	c0	shl $r0.3 = $r0.5, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB35_7:                                ## %if.end
	c0	shl $r0.2 = $r0.5, $r0.2
	c0	mov $r0.4 = 0
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.3 = $r0.2, 2146435072
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_round_to_int
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_round_to_int
float32_round_to_int::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 23
;;
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	zxtb $r0.2 = $r0.2
;;
	c0	cmpltu $b0.0 = $r0.2, 150
;;
;;
	c0	br $b0.0, LBB36_10
;;
## BB#1:                                ## %if.then
	c0	and $r0.4 = $r0.3, 8388607
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB36_9
;;
## BB#2:                                ## %if.then
	c0	cmpne $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB36_9
;;
## BB#3:                                ## %if.then.3
	c0	and $r0.4 = $r0.3, 2143289344
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	cmpne $b0.0 = $r0.4, 2139095040
;;
;;
	c0	br $b0.0, LBB36_4
;;
## BB#5:                                ## %if.then.3
	c0	and $r0.3 = $r0.3, 4194303
;;
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB36_6
;;
## BB#7:                                ## %if.then.8.i
	c0	mov $r0.4 = float_exception_flags
	c0	mov $r0.3 = $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.4]
;;
;;
	c0	or $r0.2 = $r0.2, 1
	c0	goto LBB36_8
;;
LBB36_10:                               ## %if.end.5
	c0	cmpgtu $b0.0 = $r0.2, 126
;;
;;
	c0	br $b0.0, LBB36_21
;;
## BB#11:                               ## %if.then.7
	c0	and $r0.4 = $r0.3, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB36_9
;;
## BB#12:                               ## %if.end.10
	c0	mov $r0.7 = float_exception_flags
	c0	mov $r0.5 = float_rounding_mode
;;
	c0	mov $r0.4 = 31
	c0	ldb $r0.8 = 0[$r0.7]
;;
	c0	ldb $r0.6 = 0[$r0.5]
	c0	shru $r0.5 = $r0.3, $r0.4
;;
	c0	or $r0.8 = $r0.8, 32
;;
	c0	cmpeq $b0.0 = $r0.6, 2
	c0	stb 0[$r0.7] = $r0.8
;;
;;
	c0	br $b0.0, LBB36_19
;;
## BB#13:                               ## %if.end.10
	c0	cmpeq $b0.0 = $r0.6, 1
;;
;;
	c0	brf $b0.0, LBB36_14
;;
## BB#18:                               ## %sw.bb.22
	c0	cmpne $b0.0 = $r0.5, 0
	c0	mov $r0.2 = -1082130432
;;
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.0, $r0.2, 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_21:                               ## %if.end.30
	c0	mov $r0.5 = float_rounding_mode
	c0	mov $r0.7 = 150
	c0	mov $r0.6 = 1
;;
	c0	mov $r0.4 = $r0.3
	c0	sub $r0.2 = $r0.7, $r0.2
	c0	ldbu $r0.7 = 0[$r0.5]
;;
	c0	shl $r0.2 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.7, 3
;;
;;
	c0	br $b0.0, LBB36_26
;;
## BB#22:                               ## %if.end.30
	c0	cmpne $b0.0 = $r0.7, 0
	c0	add $r0.5 = $r0.2, -1
;;
;;
	c0	br $b0.0, LBB36_25
;;
## BB#23:                               ## %if.then.36
	c0	shru $r0.4 = $r0.2, $r0.6
;;
	c0	add $r0.4 = $r0.4, $r0.3
;;
	c0	and $r0.5 = $r0.4, $r0.5
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB36_26
;;
## BB#24:                               ## %if.then.39
	c0	andc $r0.4 = $r0.2, $r0.4
	c0	goto LBB36_26
;;
LBB36_4:
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_6:
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_25:                               ## %if.then.45
	c0	cmpeq $b0.0 = $r0.7, 2
	c0	mov $r0.4 = 31
	c0	mov $r0.6 = 0
;;
	c0	shru $r0.4 = $r0.3, $r0.4
;;
	c0	mfb $r0.7 = $b0.0
;;
	c0	cmpeq $b0.0 = $r0.4, $r0.7
;;
;;
	c0	slct $r0.4 = $b0.0, $r0.6, $r0.5
;;
	c0	add $r0.4 = $r0.4, $r0.3
;;
LBB36_26:                               ## %if.end.56
	c0	mov $r0.5 = 0
;;
	c0	sub $r0.2 = $r0.5, $r0.2
;;
	c0	and $r0.2 = $r0.4, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.3
;;
;;
	c0	br $b0.0, LBB36_9
;;
## BB#27:                               ## %if.then.61
	c0	mov $r0.4 = float_exception_flags
;;
	c0	ldb $r0.5 = 0[$r0.4]
	c0	mov $r0.3 = $r0.2
;;
;;
	c0	or $r0.2 = $r0.5, 32
;;
LBB36_8:                                ## %if.else.i
	c0	stb 0[$r0.4] = $r0.2
;;
LBB36_9:                                ## %if.else.i
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_19:                               ## %sw.bb.25
	c0	cmpne $b0.0 = $r0.5, 0
	c0	mov $r0.2 = -2147483648
;;
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.0, $r0.2, 1065353216
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_14:                               ## %if.end.10
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB36_20
;;
## BB#15:                               ## %sw.bb
	c0	and $r0.3 = $r0.3, 8388607
;;
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB36_20
;;
## BB#16:                               ## %sw.bb
	c0	cmpne $b0.0 = $r0.2, 126
;;
;;
	c0	br $b0.0, LBB36_20
;;
## BB#17:                               ## %if.then.19
	c0	shl $r0.2 = $r0.5, $r0.4
;;
.return ret($r0.3:u32)
	c0	or $r0.3 = $r0.2, 1065353216
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB36_20:                               ## %sw.epilog
.return ret($r0.3:u32)
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_add
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_add
float32_add::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.6 = $r0.4, $r0.2
	c0	shru $r0.5 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.5, $r0.6
;;
;;
	c0	br $b0.0, LBB37_2
;;
## BB#1:                                ## %if.then
.call addFloat32Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = addFloat32Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB37_2:                                ## %if.else
.call subFloat32Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = subFloat32Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @addFloat32Sigs
addFloat32Sigs::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 23
	c0	mov $r0.10 = 6
;;
	c0	shru $r0.6 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	zxtb $r0.8 = $r0.6
	c0	zxtb $r0.2 = $r0.2
;;
	c0	sub $r0.9 = $r0.2, $r0.8
	c0	shl $r0.6 = $r0.3, $r0.10
	c0	shl $r0.11 = $r0.4, $r0.10
;;
	c0	cmplt $b0.0 = $r0.9, 1
	c0	and $r0.7 = $r0.6, 536870848
;;
	c0	and $r0.6 = $r0.11, 536870848
;;
;;
	c0	br $b0.0, LBB38_22
;;
## BB#1:                                ## %if.then
	c0	cmpne $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB38_17
;;
## BB#2:                                ## %if.then.6
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB38_65
;;
## BB#3:                                ## %if.then.7
	c0	and $r0.2 = $r0.4, 4194303
	c0	and $r0.5 = $r0.3, 4194303
;;
	c0	and $r0.6 = $r0.3, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.2 = $b0.3, $r0.2, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB38_5
;;
## BB#4:                                ## %if.then.i.179
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB38_5:                                ## %if.end.i.181
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	or $r0.5 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB38_8
;;
## BB#6:                                ## %if.then.8.i.183
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB38_12
;;
	c0	goto LBB38_7
;;
LBB38_22:                               ## %if.else.13
	c0	cmpgt $b0.0 = $r0.9, -1
;;
;;
	c0	brf $b0.0, LBB38_23
;;
## BB#44:                               ## %if.else.30
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB38_45
;;
## BB#60:                               ## %if.then.40
	c0	add $r0.2 = $r0.6, $r0.7
	c0	mov $r0.3 = 31
;;
	c0	shl $r0.3 = $r0.5, $r0.3
	c0	shru $r0.2 = $r0.2, $r0.10
;;
	c0	or $r0.3 = $r0.2, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_17:                               ## %if.end.9
	c0	cmpeq $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB38_19
;;
## BB#18:                               ## %if.end.12.thread
	c0	or $r0.6 = $r0.6, 536870912
	c0	goto LBB38_20
;;
LBB38_23:                               ## %if.then.15
	c0	cmpne $b0.0 = $r0.8, 255
;;
;;
	c0	br $b0.0, LBB38_39
;;
## BB#24:                               ## %if.then.17
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB38_38
;;
## BB#25:                               ## %if.then.19
	c0	and $r0.2 = $r0.4, 4194303
	c0	and $r0.5 = $r0.3, 4194303
;;
	c0	and $r0.6 = $r0.3, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.2 = $b0.3, $r0.2, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB38_27
;;
## BB#26:                               ## %if.then.i.123
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB38_27:                               ## %if.end.i.125
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	or $r0.5 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB38_31
;;
## BB#28:                               ## %if.then.8.i.127
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB38_29
;;
	c0	goto LBB38_7
;;
LBB38_45:                               ## %if.else.30
	c0	cmpne $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB38_61
;;
## BB#46:                               ## %if.then.32
	c0	or $r0.2 = $r0.6, $r0.7
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB38_65
;;
## BB#47:                               ## %if.then.35
	c0	and $r0.2 = $r0.4, 4194303
	c0	and $r0.5 = $r0.3, 4194303
;;
	c0	and $r0.6 = $r0.3, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.2 = $b0.3, $r0.2, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB38_49
;;
## BB#48:                               ## %if.then.i
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB38_49:                               ## %if.end.i
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	or $r0.5 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB38_53
;;
## BB#50:                               ## %if.then.8.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB38_51
;;
LBB38_7:                                ## %if.end.11.i.185
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.3, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.5, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_19:                               ## %if.end.12
	c0	add $r0.9 = $r0.9, -1
;;
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB38_63
;;
LBB38_20:                               ## %if.else.i.148
	c0	cmpgt $b0.0 = $r0.9, 31
;;
;;
	c0	br $b0.0, LBB38_62
;;
## BB#21:                               ## %if.then.2.i.155
	c0	mov $r0.3 = 0
;;
	c0	sub $r0.3 = $r0.3, $r0.9
	c0	shru $r0.4 = $r0.6, $r0.9
;;
	c0	and $r0.3 = $r0.3, 31
;;
	c0	shl $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.6 = $r0.3, $r0.4
	c0	goto LBB38_63
;;
LBB38_62:                               ## %if.else.4.i.158
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	mfb $r0.6 = $b0.0
;;
LBB38_63:                               ## %if.end.46
	c0	or $r0.3 = $r0.7, 536870912
	c0	mov $r0.4 = 1
;;
	c0	add $r0.3 = $r0.3, $r0.6
;;
	c0	shl $r0.4 = $r0.3, $r0.4
	c0	mov $r0.7 = -1
;;
	c0	cmpgt $r0.6 = $r0.4, -1
	c0	cmplt $b0.0 = $r0.4, 0
;;
	c0	mtb $b0.1 = $r0.6
;;
	c0	slct $r0.6 = $b0.0, $r0.3, $r0.4
;;
	c0	slct $r0.3 = $b0.1, $r0.7, 0
;;
	c0	add $r0.2 = $r0.3, $r0.2
;;
LBB38_64:                               ## %roundAndPack
	c0	mov $r0.4 = $r0.2
	c0	mov $r0.3 = $r0.5
	c0	mov $r0.5 = $r0.6
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
LBB38_65:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_8:                                ## %if.else.i.186
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	br $b0.0, LBB38_9
;;
## BB#10:                               ## %if.then.15.i.190
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB38_12
;;
## BB#11:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_12:                               ## %returnLargerSignificand.i.194
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.3
;;
;;
	c0	brf $b0.0, LBB38_14
;;
## BB#13:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_39:                               ## %if.end.23
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.7, 536870912
;;
;;
	c0	mfb $r0.3 = $b0.0
	c0	slct $r0.7 = $b0.0, $r0.7, $r0.2
;;
	c0	add $r0.2 = $r0.9, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB38_40
;;
## BB#41:                               ## %if.else.i.98
	c0	cmplt $b0.0 = $r0.2, -31
;;
;;
	c0	br $b0.0, LBB38_43
;;
## BB#42:                               ## %if.then.2.i
	c0	and $r0.3 = $r0.2, 31
	c0	mov $r0.4 = 0
;;
	c0	shl $r0.3 = $r0.7, $r0.3
	c0	sub $r0.4 = $r0.4, $r0.2
	c0	mov $r0.2 = $r0.8
;;
	c0	cmpne $b0.0 = $r0.3, 0
	c0	shru $r0.3 = $r0.7, $r0.4
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.7 = $r0.4, $r0.3
	c0	goto LBB38_63
;;
LBB38_61:                               ## %if.end.42
	c0	or $r0.3 = $r0.7, 1073741824
;;
	c0	add $r0.6 = $r0.3, $r0.6
	c0	goto LBB38_64
;;
LBB38_14:                               ## %if.end.25.i.196
	c0	cmpltu $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB38_16
;;
## BB#15:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_9:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_38:                               ## %if.end.21
	c0	mov $r0.2 = 31
;;
	c0	shl $r0.2 = $r0.5, $r0.2
;;
	c0	or $r0.3 = $r0.2, 2139095040
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_40:
	c0	mov $r0.2 = $r0.8
	c0	goto LBB38_63
;;
LBB38_16:                               ## %if.end.31.i.199
	c0	minu $r0.3 = $r0.2, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_43:                               ## %if.else.4.i
	c0	cmpne $b0.0 = $r0.7, 0
	c0	mov $r0.2 = $r0.8
;;
;;
	c0	mfb $r0.7 = $b0.0
	c0	goto LBB38_63
;;
LBB38_31:                               ## %if.else.i.130
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	br $b0.0, LBB38_32
;;
## BB#33:                               ## %if.then.15.i.134
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB38_29
;;
## BB#34:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_29:                               ## %returnLargerSignificand.i.138
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.3
;;
;;
	c0	brf $b0.0, LBB38_35
;;
## BB#30:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_53:                               ## %if.else.i
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	br $b0.0, LBB38_54
;;
## BB#55:                               ## %if.then.15.i
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB38_51
;;
## BB#56:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_51:                               ## %returnLargerSignificand.i
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.3
;;
;;
	c0	brf $b0.0, LBB38_57
;;
## BB#52:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_35:                               ## %if.end.25.i.140
	c0	cmpltu $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB38_37
;;
## BB#36:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_32:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_57:                               ## %if.end.25.i
	c0	cmpltu $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB38_59
;;
## BB#58:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_54:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_37:                               ## %if.end.31.i.143
	c0	minu $r0.3 = $r0.2, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB38_59:                               ## %if.end.31.i
	c0	minu $r0.3 = $r0.2, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @subFloat32Sigs
subFloat32Sigs::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.6 = 23
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.3 = 7
;;
	c0	shru $r0.7 = $r0.4, $r0.6
	c0	shru $r0.6 = $r0.2, $r0.6
;;
	c0	zxtb $r0.7 = $r0.7
	c0	zxtb $r0.8 = $r0.6
;;
	c0	sub $r0.9 = $r0.8, $r0.7
	c0	shl $r0.6 = $r0.2, $r0.3
	c0	shl $r0.10 = $r0.4, $r0.3
;;
	c0	cmpgt $b0.0 = $r0.9, 0
	c0	and $r0.3 = $r0.6, 1073741696
;;
	c0	and $r0.6 = $r0.10, 1073741696
;;
;;
	c0	brf $b0.0, LBB39_1
;;
## BB#42:                               ## %aExpBigger
	c0	cmpne $b0.0 = $r0.8, 255
;;
;;
	c0	br $b0.0, LBB39_56
;;
## BB#43:                               ## %if.then.51
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB39_44
;;
## BB#45:                               ## %if.then.53
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB39_47
;;
## BB#46:                               ## %if.then.i
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB39_47:                               ## %if.end.i
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB39_52
;;
## BB#48:                               ## %if.then.8.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB39_49
;;
	c0	goto LBB39_9
;;
LBB39_1:                                ## %if.end
	c0	cmplt $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB39_22
;;
## BB#2:                                ## %if.end.7
	c0	cmpeq $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB39_3
;;
## BB#18:                               ## %if.then.15
	c0	mov $r0.8 = 1
;;
	c0	mov $r0.7 = $r0.8
	c0	goto LBB39_19
;;
LBB39_56:                               ## %if.end.56
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB39_58
;;
## BB#57:                               ## %if.end.62.thread
	c0	or $r0.6 = $r0.6, 1073741824
	c0	goto LBB39_59
;;
LBB39_22:                               ## %bExpBigger
	c0	cmpne $b0.0 = $r0.7, 255
;;
;;
	c0	br $b0.0, LBB39_36
;;
## BB#23:                               ## %if.then.29
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB39_35
;;
## BB#24:                               ## %if.then.31
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB39_26
;;
## BB#25:                               ## %if.then.i.147
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB39_26:                               ## %if.end.i.149
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB39_31
;;
## BB#27:                               ## %if.then.8.i.151
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB39_28
;;
	c0	goto LBB39_9
;;
LBB39_44:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_3:                                ## %if.end.7
	c0	cmpne $b0.0 = $r0.8, 255
;;
;;
	c0	br $b0.0, LBB39_19
;;
## BB#4:                                ## %if.then.9
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB39_17
;;
## BB#5:                                ## %if.then.10
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB39_7
;;
## BB#6:                                ## %if.then.i.190
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB39_7:                                ## %if.end.i.192
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB39_10
;;
## BB#8:                                ## %if.then.8.i.194
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB39_13
;;
LBB39_9:                                ## %if.end.11.i.196
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.2, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_19:                               ## %if.end.16
	c0	cmpltu $b0.0 = $r0.6, $r0.3
;;
;;
	c0	br $b0.0, LBB39_63
;;
## BB#20:                               ## %if.end.19
	c0	cmpltu $b0.0 = $r0.3, $r0.6
;;
;;
	c0	br $b0.0, LBB39_41
;;
## BB#21:                               ## %if.end.22
	c0	mov $r0.2 = float_rounding_mode
;;
	c0	ldbu $r0.2 = 0[$r0.2]
	c0	mov $r0.3 = 31
;;
;;
	c0	cmpeq $b0.0 = $r0.2, 1
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	shl $r0.3 = $r0.2, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_58:                               ## %if.end.62
	c0	add $r0.9 = $r0.9, -1
;;
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB39_62
;;
LBB39_59:                               ## %if.else.i
	c0	cmpgt $b0.0 = $r0.9, 31
;;
;;
	c0	br $b0.0, LBB39_61
;;
## BB#60:                               ## %if.then.2.i
	c0	mov $r0.2 = 0
;;
	c0	sub $r0.2 = $r0.2, $r0.9
	c0	shru $r0.4 = $r0.6, $r0.9
;;
	c0	and $r0.2 = $r0.2, 31
;;
	c0	shl $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.6 = $r0.2, $r0.4
	c0	goto LBB39_62
;;
LBB39_61:                               ## %if.else.4.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	mfb $r0.6 = $b0.0
;;
LBB39_62:                               ## %shift32RightJamming.exit
	c0	or $r0.3 = $r0.3, 1073741824
;;
LBB39_63:                               ## %aBigger
	c0	sub $r0.2 = $r0.3, $r0.6
	c0	mov $r0.7 = $r0.8
	c0	goto LBB39_64
;;
LBB39_52:                               ## %if.else.i.110
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#53:                               ## %if.then.15.i
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB39_49
;;
## BB#54:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_49:                               ## %returnLargerSignificand.i
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#50:                               ## %if.end.25.i
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB39_55
;;
## BB#51:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_36:                               ## %if.end.37
	c0	cmpeq $b0.0 = $r0.8, 0
	c0	or $r0.2 = $r0.3, 1073741824
;;
;;
	c0	mfb $r0.4 = $b0.0
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.2
;;
	c0	add $r0.2 = $r0.9, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB39_40
;;
## BB#37:                               ## %if.else.i.115
	c0	cmplt $b0.0 = $r0.2, -31
;;
;;
	c0	br $b0.0, LBB39_39
;;
## BB#38:                               ## %if.then.2.i.122
	c0	and $r0.4 = $r0.2, 31
	c0	mov $r0.8 = 0
;;
	c0	shl $r0.4 = $r0.3, $r0.4
	c0	sub $r0.2 = $r0.8, $r0.2
;;
	c0	cmpne $b0.0 = $r0.4, 0
	c0	shru $r0.2 = $r0.3, $r0.2
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.3, $r0.2
	c0	goto LBB39_40
;;
LBB39_35:                               ## %if.end.33
	c0	mov $r0.2 = 31
;;
	c0	shl $r0.2 = $r0.5, $r0.2
;;
	c0	add $r0.3 = $r0.2, -8388608
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_55:                               ## %if.end.31.i
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_17:                               ## %if.end.12
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = -4194304
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_39:                               ## %if.else.4.i.125
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
LBB39_40:                               ## %shift32RightJamming.exit127
	c0	or $r0.6 = $r0.6, 1073741824
;;
LBB39_41:                               ## %bBigger
	c0	zxtb $r0.4 = $r0.5
	c0	sub $r0.2 = $r0.6, $r0.3
;;
	c0	xor $r0.5 = $r0.4, 1
;;
LBB39_64:                               ## %normalizeRoundAndPack
	c0	mov $r0.3 = 16
	c0	cmpltu $b0.0 = $r0.2, 65536
	c0	mov $r0.6 = 4
;;
	c0	add $r0.4 = $r0.7, -1
	c0	shl $r0.3 = $r0.2, $r0.3
;;
	c0	mfb $r0.7 = $b0.0
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.2
;;
	c0	cmpgtu $b0.0 = $r0.3, 16777215
	c0	shl $r0.6 = $r0.7, $r0.6
;;
;;
	c0	br $b0.0, LBB39_66
;;
## BB#65:                               ## %if.then.4.i.i
	c0	or $r0.6 = $r0.6, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	zxtb $r0.6 = $r0.6
;;
LBB39_66:                               ## %normalizeRoundAndPackFloat32.exit
	c0	mov $r0.7 = 24
	c0	mov $r0.8 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.3 = $r0.3, $r0.7
;;
	c0	add $r0.3 = $r0.8, $r0.3
;;
	c0	ldb $r0.3 = 0[$r0.3]
;;
;;
	c0	add $r0.3 = $r0.3, $r0.6
;;
	c0	shl $r0.3 = $r0.3, $r0.7
;;
	c0	add $r0.6 = $r0.3, -16777216
	c0	sxtb $r0.3 = $r0.5
;;
	c0	shr $r0.5 = $r0.6, $r0.7
;;
	c0	sub $r0.4 = $r0.4, $r0.5
	c0	shl $r0.5 = $r0.2, $r0.5
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
LBB39_67:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_31:                               ## %if.else.i.154
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#32:                               ## %if.then.15.i.158
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB39_28
;;
## BB#33:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_28:                               ## %returnLargerSignificand.i.162
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#29:                               ## %if.end.25.i.164
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB39_34
;;
## BB#30:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_10:                               ## %if.else.i.197
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#11:                               ## %if.then.15.i.201
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB39_13
;;
## BB#12:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_13:                               ## %returnLargerSignificand.i.205
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB39_67
;;
## BB#14:                               ## %if.end.25.i.207
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB39_16
;;
## BB#15:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_34:                               ## %if.end.31.i.167
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB39_16:                               ## %if.end.31.i.210
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float32_sub
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_sub
float32_sub::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.6 = $r0.4, $r0.2
	c0	shru $r0.5 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.5, $r0.6
;;
;;
	c0	br $b0.0, LBB40_2
;;
## BB#1:                                ## %if.then
.call subFloat32Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = subFloat32Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB40_2:                                ## %if.else
.call addFloat32Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = addFloat32Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float32_mul
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_mul
float32_mul::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.5 = 23
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.7 = 31
;;
	c0	shru $r0.3 = $r0.2, $r0.5
	c0	xor $r0.8 = $r0.4, $r0.2
	c0	shru $r0.10 = $r0.4, $r0.5
;;
	c0	zxtb $r0.9 = $r0.3
;;
	c0	cmpne $b0.0 = $r0.9, 255
	c0	and $r0.6 = $r0.2, 8388607
;;
	c0	and $r0.5 = $r0.4, 8388607
	c0	shru $r0.3 = $r0.8, $r0.7
	c0	zxtb $r0.8 = $r0.10
;;
;;
	c0	br $b0.0, LBB41_19
;;
## BB#1:                                ## %if.then
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB41_4
;;
## BB#2:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB41_16
;;
## BB#3:                                ## %lor.lhs.false
	c0	cmpne $b0.0 = $r0.8, 255
;;
;;
	c0	br $b0.0, LBB41_16
;;
LBB41_4:                                ## %if.then.12
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.3 = $b0.0
	c0	mfb $r0.5 = $b0.1
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB41_6
;;
## BB#5:                                ## %if.then.i.147
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB41_6:                                ## %if.end.i.149
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB41_9
;;
## BB#7:                                ## %if.then.8.i.151
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB41_12
;;
	c0	goto LBB41_8
;;
LBB41_19:                               ## %if.end.19
	c0	cmpne $b0.0 = $r0.8, 255
;;
;;
	c0	br $b0.0, LBB41_34
;;
## BB#20:                               ## %if.then.22
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB41_32
;;
## BB#21:                               ## %if.then.24
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB41_23
;;
## BB#22:                               ## %if.then.i
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB41_23:                               ## %if.end.i
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB41_28
;;
## BB#24:                               ## %if.then.8.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB41_25
;;
LBB41_8:                                ## %if.end.11.i.153
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.2, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_34:                               ## %if.end.33
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB41_40
;;
## BB#35:                               ## %if.then.36
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB41_36
;;
## BB#37:                               ## %if.end.41
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.9 = 16
	c0	mov $r0.10 = 4
;;
	c0	shl $r0.2 = $r0.2, $r0.9
;;
	c0	mfb $r0.9 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.9 = $r0.9, $r0.10
;;
;;
	c0	br $b0.0, LBB41_39
;;
## BB#38:                               ## %if.then.4.i.i.102
	c0	or $r0.9 = $r0.9, 8
	c0	mov $r0.10 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.10
	c0	zxtb $r0.9 = $r0.9
;;
LBB41_39:                               ## %normalizeFloat32Subnormal.exit116
	c0	mov $r0.10 = 24
	c0	mov $r0.11 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.10
;;
	c0	add $r0.2 = $r0.11, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.9
;;
	c0	shl $r0.2 = $r0.2, $r0.10
;;
	c0	add $r0.2 = $r0.2, -134217728
;;
	c0	shr $r0.2 = $r0.2, $r0.10
	c0	mov $r0.9 = 1
;;
	c0	shl $r0.6 = $r0.6, $r0.2
	c0	sub $r0.9 = $r0.9, $r0.2
;;
LBB41_40:                               ## %if.end.42
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB41_46
;;
## BB#41:                               ## %if.then.45
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB41_42
;;
## BB#43:                               ## %if.end.50
	c0	cmpltu $b0.0 = $r0.5, 65536
	c0	mov $r0.2 = 16
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.2 = $r0.4, $r0.2
;;
	c0	mfb $r0.4 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.5
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.4 = $r0.4, $r0.7
;;
;;
	c0	br $b0.0, LBB41_45
;;
## BB#44:                               ## %if.then.4.i.i
	c0	or $r0.4 = $r0.4, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.7
	c0	zxtb $r0.4 = $r0.4
;;
LBB41_45:                               ## %normalizeFloat32Subnormal.exit
	c0	mov $r0.7 = 24
	c0	mov $r0.8 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.8, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.4
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.2, -134217728
;;
	c0	shr $r0.2 = $r0.2, $r0.7
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.5 = $r0.5, $r0.2
	c0	sub $r0.8 = $r0.4, $r0.2
;;
LBB41_46:                               ## %if.end.51
	c0	mov $r0.2 = 8
	c0	mov $r0.4 = 9
	c0	mov $r0.7 = 7
	c0	mov $r0.10 = 16
;;
	c0	shru $r0.11 = $r0.5, $r0.2
	c0	shru $r0.4 = $r0.6, $r0.4
	c0	shl $r0.2 = $r0.5, $r0.2
	c0	shl $r0.5 = $r0.6, $r0.7
;;
	c0	and $r0.4 = $r0.4, 49151
	c0	and $r0.6 = $r0.11, 32767
;;
	c0	zxth $r0.5 = $r0.5
	c0	zxth $r0.2 = $r0.2
	c0	or $r0.6 = $r0.6, 32768
;;
	c0	or $r0.4 = $r0.4, 16384
	c0	mpylu $r0.7 = $r0.2, $r0.5
	c0	mpyhs $r0.11 = $r0.2, $r0.5
;;
	c0	mpyhs $r0.12 = $r0.2, $r0.4
	c0	mpylu $r0.2 = $r0.2, $r0.4
	c0	mov $r0.13 = 1
	c0	mov $r0.14 = 30
;;
	c0	mpylu $r0.15 = $r0.6, $r0.5
	c0	mpyhs $r0.5 = $r0.6, $r0.5
	c0	add $r0.7 = $r0.7, $r0.11
	c0	add $r0.8 = $r0.8, $r0.9
;;
	c0	add $r0.2 = $r0.2, $r0.12
;;
	c0	add $r0.5 = $r0.15, $r0.5
	c0	mpyhs $r0.9 = $r0.6, $r0.4
	c0	mpylu $r0.4 = $r0.6, $r0.4
;;
	c0	add $r0.2 = $r0.5, $r0.2
;;
	c0	cmpltu $r0.5 = $r0.2, $r0.5
	c0	shl $r0.6 = $r0.2, $r0.10
	c0	shru $r0.2 = $r0.2, $r0.10
;;
	c0	add $r0.7 = $r0.6, $r0.7
	c0	shl $r0.5 = $r0.5, $r0.10
	c0	add $r0.4 = $r0.4, $r0.9
;;
	c0	cmpne $b0.0 = $r0.7, 0
	c0	or $r0.2 = $r0.5, $r0.2
	c0	cmpltu $r0.5 = $r0.7, $r0.6
;;
	c0	add $r0.2 = $r0.2, $r0.4
;;
	c0	mfb $r0.4 = $b0.0
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	or $r0.5 = $r0.2, $r0.4
	c0	shru $r0.2 = $r0.2, $r0.14
;;
	c0	and $r0.2 = $r0.2, 1
	c0	shl $r0.6 = $r0.5, $r0.13
;;
	c0	or $r0.2 = $r0.2, -128
	c0	cmpgt $b0.0 = $r0.6, -1
;;
	c0	add $r0.4 = $r0.8, $r0.2
;;
	c0	slct $r0.5 = $b0.0, $r0.6, $r0.5
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
	c0	goto LBB41_47
;;
LBB41_9:                                ## %if.else.i.154
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB41_47
;;
## BB#10:                               ## %if.then.15.i.158
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB41_12
;;
## BB#11:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_12:                               ## %returnLargerSignificand.i.162
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB41_47
;;
## BB#13:                               ## %if.end.25.i.164
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB41_15
;;
## BB#14:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_16:                               ## %if.end
	c0	or $r0.2 = $r0.8, $r0.5
	c0	goto LBB41_17
;;
LBB41_32:                               ## %if.end.26
	c0	or $r0.2 = $r0.9, $r0.6
;;
LBB41_17:                               ## %if.end
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB41_18
;;
## BB#33:                               ## %if.end.17
	c0	shl $r0.2 = $r0.3, $r0.7
;;
	c0	or $r0.3 = $r0.2, 2139095040
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_18:                               ## %if.then.16
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = -4194304
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_28:                               ## %if.else.i
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB41_47
;;
## BB#29:                               ## %if.then.15.i
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB41_25
;;
## BB#30:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_25:                               ## %returnLargerSignificand.i
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	brf $b0.0, LBB41_26
;;
LBB41_47:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_15:                               ## %if.end.31.i.167
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_36:                               ## %if.then.39
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_26:                               ## %if.end.25.i
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB41_31
;;
## BB#27:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_42:                               ## %if.then.48
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB41_31:                               ## %if.end.31.i
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @roundAndPackFloat32
roundAndPackFloat32::
## BB#0:                                ## %entry
	c0	mov $r0.2 = float_rounding_mode
;;
	c0	ldbu $r0.2 = 0[$r0.2]
;;
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB42_1
;;
## BB#2:                                ## %if.then
	c0	cmpeq $b0.1 = $r0.2, 3
;;
;;
	c0	brf $b0.1, LBB42_4
;;
## BB#3:
	c0	mov $r0.2 = 0
	c0	goto LBB42_8
;;
LBB42_1:
	c0	mov $r0.2 = 64
	c0	goto LBB42_8
;;
LBB42_4:                                ## %if.else
	c0	zxtb $r0.6 = $r0.3
;;
	c0	cmpeq $b0.1 = $r0.6, 0
;;
;;
	c0	br $b0.1, LBB42_6
;;
## BB#5:                                ## %if.then.8
	c0	cmpeq $b0.1 = $r0.2, 2
	c0	goto LBB42_7
;;
LBB42_6:                                ## %if.else.13
	c0	cmpeq $b0.1 = $r0.2, 1
;;
LBB42_7:                                ## %if.end.21
	c0	mov $r0.2 = 0
;;
	c0	slct $r0.2 = $b0.1, $r0.2, 127
;;
LBB42_8:                                ## %if.end.21
	c0	zxth $r0.6 = $r0.4
	c0	and $r0.7 = $r0.5, 127
;;
	c0	cmpltu $b0.1 = $r0.6, 253
;;
;;
	c0	br $b0.1, LBB42_9
;;
## BB#10:                               ## %if.then.27
	c0	cmpgt $b0.1 = $r0.4, 253
;;
;;
	c0	br $b0.1, LBB42_14
;;
## BB#11:                               ## %lor.lhs.false
	c0	cmpne $b0.1 = $r0.4, 253
;;
;;
	c0	br $b0.1, LBB42_15
;;
## BB#12:                               ## %land.lhs.true
	c0	zxtb $r0.4 = $r0.2
;;
	c0	add $r0.4 = $r0.4, $r0.5
;;
	c0	cmpgt $b0.1 = $r0.4, -1
;;
;;
	c0	brf $b0.1, LBB42_14
;;
## BB#13:
	c0	mov $r0.6 = 253
	c0	goto LBB42_25
;;
LBB42_9:
	c0	mov $r0.6 = $r0.4
;;
LBB42_25:                               ## %if.end.65
	c0	zxtb $r0.4 = $r0.7
;;
	c0	cmpeq $b0.1 = $r0.4, 0
;;
;;
	c0	br $b0.1, LBB42_27
;;
## BB#26:                               ## %if.then.67
	c0	mov $r0.7 = float_exception_flags
;;
	c0	ldb $r0.8 = 0[$r0.7]
;;
;;
	c0	or $r0.8 = $r0.8, 32
;;
	c0	stb 0[$r0.7] = $r0.8
;;
LBB42_27:                               ## %if.end.70
	c0	cmpeq $b0.1 = $r0.4, 64
	c0	zxtb $r0.2 = $r0.2
	c0	mfb $r0.4 = $b0.0
	c0	mov $r0.7 = 7
;;
;;
	c0	mfb $r0.8 = $b0.1
	c0	add $r0.2 = $r0.5, $r0.2
	c0	mov $r0.5 = 23
	c0	mov $r0.9 = 31
;;
	c0	and $r0.4 = $r0.4, $r0.8
	c0	shru $r0.2 = $r0.2, $r0.7
	c0	shl $r0.3 = $r0.3, $r0.9
	c0	mov $r0.7 = 0
;;
	c0	orc $r0.4 = $r0.4, -2
	c0	shl $r0.5 = $r0.6, $r0.5
;;
	c0	and $r0.2 = $r0.2, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.2, $r0.3
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.7, $r0.5
;;
.return ret($r0.3:u32)
	c0	add $r0.3 = $r0.2, $r0.3
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB42_14:                               ## %if.then.35
	c0	zxtb $r0.2 = $r0.2
	c0	mov $r0.4 = float_exception_flags
	c0	mov $r0.5 = 31
;;
	c0	ldb $r0.6 = 0[$r0.4]
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	shl $r0.2 = $r0.3, $r0.5
;;
	c0	or $r0.2 = $r0.2, 2139095040
;;
	c0	or $r0.3 = $r0.6, 40
	c0	mfb $r0.5 = $b0.0
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.4] = $r0.3
	c0	sub $r0.3 = $r0.2, $r0.5
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB42_15:                               ## %if.end.39
	c0	cmpgt $b0.1 = $r0.4, -1
;;
;;
	c0	brf $b0.1, LBB42_17
;;
## BB#16:
	c0	mov $r0.6 = $r0.4
	c0	goto LBB42_25
;;
LBB42_17:                               ## %if.then.42
	c0	mov $r0.6 = 0
	c0	cmplt $b0.2 = $r0.4, -1
;;
	c0	mtb $b0.1 = $r0.6
;;
	c0	br $b0.2, LBB42_20
;;
## BB#18:                               ## %if.then.42
	c0	mov $r0.7 = float_detect_tininess
;;
	c0	ldb $r0.7 = 0[$r0.7]
;;
;;
	c0	zxtb $r0.7 = $r0.7
;;
	c0	cmpeq $b0.2 = $r0.7, 1
;;
;;
	c0	br $b0.2, LBB42_20
;;
## BB#19:                               ## %lor.rhs
	c0	zxtb $r0.7 = $r0.2
;;
	c0	add $r0.7 = $r0.7, $r0.5
;;
	c0	cmplt $b0.1 = $r0.7, 0
;;
LBB42_20:                               ## %if.else.i
	c0	cmplt $b0.2 = $r0.4, -31
;;
;;
	c0	br $b0.2, LBB42_22
;;
## BB#21:                               ## %if.then.2.i
	c0	and $r0.7 = $r0.4, 31
	c0	mov $r0.8 = 0
;;
	c0	shl $r0.7 = $r0.5, $r0.7
	c0	sub $r0.4 = $r0.8, $r0.4
;;
	c0	cmpne $b0.2 = $r0.7, 0
	c0	shru $r0.4 = $r0.5, $r0.4
;;
;;
	c0	mfb $r0.5 = $b0.2
;;
	c0	or $r0.5 = $r0.5, $r0.4
	c0	goto LBB42_23
;;
LBB42_22:                               ## %if.else.4.i
	c0	cmpne $b0.2 = $r0.5, 0
;;
;;
	c0	mfb $r0.5 = $b0.2
;;
LBB42_23:                               ## %shift32RightJamming.exit
	c0	and $r0.7 = $r0.5, 127
	c0	mfb $r0.4 = $b0.1
;;
	c0	cmpeq $b0.1 = $r0.7, 0
;;
;;
	c0	mfb $r0.8 = $b0.1
;;
	c0	or $r0.4 = $r0.4, $r0.8
;;
	c0	mtb $b0.1 = $r0.4
;;
;;
	c0	br $b0.1, LBB42_25
;;
## BB#24:                               ## %if.then.62
	c0	mov $r0.4 = float_exception_flags
;;
	c0	ldb $r0.8 = 0[$r0.4]
;;
;;
	c0	or $r0.8 = $r0.8, 16
;;
	c0	stb 0[$r0.4] = $r0.8
	c0	goto LBB42_25
;;
.endp

#.globl float32_div
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_div
float32_div::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.5 = 23
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.7 = 31
;;
	c0	shru $r0.3 = $r0.2, $r0.5
	c0	xor $r0.9 = $r0.4, $r0.2
	c0	shru $r0.10 = $r0.4, $r0.5
;;
	c0	zxtb $r0.8 = $r0.3
;;
	c0	cmpne $b0.0 = $r0.8, 255
	c0	and $r0.6 = $r0.2, 8388607
;;
	c0	and $r0.5 = $r0.4, 8388607
	c0	shru $r0.3 = $r0.9, $r0.7
	c0	zxtb $r0.10 = $r0.10
;;
;;
	c0	br $b0.0, LBB43_29
;;
## BB#1:                                ## %if.then
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB43_14
;;
## BB#2:                                ## %if.then.9
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.3 = $b0.0
	c0	mfb $r0.5 = $b0.1
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB43_4
;;
## BB#3:                                ## %if.then.i.216
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB43_4:                                ## %if.end.i.218
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB43_7
;;
## BB#5:                                ## %if.then.8.i.220
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB43_10
;;
	c0	goto LBB43_6
;;
LBB43_29:                               ## %if.end.20
	c0	cmpeq $b0.0 = $r0.10, 0
;;
;;
	c0	brf $b0.0, LBB43_30
;;
## BB#44:                               ## %if.then.32
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB43_45
;;
## BB#48:                               ## %if.end.41
	c0	cmpltu $b0.0 = $r0.5, 65536
	c0	mov $r0.9 = 16
	c0	mov $r0.10 = 4
;;
	c0	shl $r0.4 = $r0.4, $r0.9
;;
	c0	mfb $r0.9 = $b0.0
	c0	slct $r0.4 = $b0.0, $r0.4, $r0.5
;;
	c0	cmpgtu $b0.0 = $r0.4, 16777215
	c0	shl $r0.9 = $r0.9, $r0.10
;;
;;
	c0	br $b0.0, LBB43_50
;;
## BB#49:                               ## %if.then.4.i.i.125
	c0	or $r0.9 = $r0.9, 8
	c0	mov $r0.10 = 8
;;
	c0	shl $r0.4 = $r0.4, $r0.10
	c0	zxtb $r0.9 = $r0.9
;;
LBB43_50:                               ## %normalizeFloat32Subnormal.exit139
	c0	mov $r0.10 = 24
	c0	mov $r0.11 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.4 = $r0.4, $r0.10
;;
	c0	add $r0.4 = $r0.11, $r0.4
;;
	c0	ldb $r0.4 = 0[$r0.4]
;;
;;
	c0	add $r0.4 = $r0.4, $r0.9
;;
	c0	shl $r0.4 = $r0.4, $r0.10
;;
	c0	add $r0.4 = $r0.4, -134217728
;;
	c0	shr $r0.4 = $r0.4, $r0.10
	c0	mov $r0.9 = 1
;;
	c0	shl $r0.5 = $r0.5, $r0.4
	c0	sub $r0.10 = $r0.9, $r0.4
	c0	goto LBB43_51
;;
LBB43_30:                               ## %if.end.20
	c0	cmpne $b0.0 = $r0.10, 255
;;
;;
	c0	br $b0.0, LBB43_51
;;
## BB#31:                               ## %if.then.23
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB43_43
;;
## BB#32:                               ## %if.then.25
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB43_34
;;
## BB#33:                               ## %if.then.i
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB43_34:                               ## %if.end.i.148
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB43_39
;;
## BB#35:                               ## %if.then.8.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB43_36
;;
	c0	goto LBB43_6
;;
LBB43_51:                               ## %if.end.42
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB43_57
;;
## BB#52:                               ## %if.then.45
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB43_53
;;
## BB#54:                               ## %if.end.50
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.4 = 16
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.2 = $r0.2, $r0.4
;;
	c0	mfb $r0.4 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.4 = $r0.4, $r0.7
;;
;;
	c0	br $b0.0, LBB43_56
;;
## BB#55:                               ## %if.then.4.i.i
	c0	or $r0.4 = $r0.4, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.7
	c0	zxtb $r0.4 = $r0.4
;;
LBB43_56:                               ## %normalizeFloat32Subnormal.exit
	c0	mov $r0.7 = 24
	c0	mov $r0.8 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.8, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.4
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.2, -134217728
;;
	c0	shr $r0.2 = $r0.2, $r0.7
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.6 = $r0.6, $r0.2
	c0	sub $r0.8 = $r0.4, $r0.2
;;
LBB43_57:                               ## %if.end.51
	c0	mov $r0.2 = 7
	c0	mov $r0.4 = 8
	c0	mov $r0.7 = 1
	c0	mov $r0.11 = 125
;;
	c0	shl $r0.2 = $r0.6, $r0.2
	c0	shl $r0.9 = $r0.5, $r0.4
;;
	c0	or $r0.4 = $r0.2, 1073741824
	c0	or $r0.2 = $r0.9, -2147483648
;;
	c0	shl $r0.6 = $r0.4, $r0.7
;;
	c0	cmpleu $b0.0 = $r0.2, $r0.6
	c0	sub $r0.7 = $r0.8, $r0.10
	c0	cmpgtu $b0.1 = $r0.2, $r0.6
;;
;;
	c0	mfb $r0.6 = $b0.0
	c0	slct $r0.8 = $b0.1, $r0.11, 126
;;
	c0	shru $r0.6 = $r0.4, $r0.6
	c0	add $r0.4 = $r0.7, $r0.8
;;
	c0	cmpleu $b0.0 = $r0.2, $r0.6
;;
;;
	c0	br $b0.0, LBB43_58
;;
## BB#59:                               ## %if.end.i
	c0	mov $r0.7 = 16
;;
	c0	shru $r0.8 = $r0.2, $r0.7
;;
	c0	shl $r0.13 = $r0.8, $r0.7
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.6
;;
;;
	c0	br $b0.0, LBB43_60
;;
## BB#61:                               ## %cond.false.i
	c0	cmplt $r0.10 = $r0.8, $r0.0
	c0	mov $r0.11 = 0
;;
	c0	shru $r0.12 = $r0.6, $r0.10
	c0	mtb $b0.0 = $r0.11
	c0	shru $r0.14 = $r0.8, $r0.10
	c0	mtb $b0.1 = $r0.11
;;
;;
	c0	addcg $r0.11, $b0.0 = $r0.12, $r0.12, $b0.0
;;
	c0	divs $r0.12, $b0.0 = $r0.0, $r0.14, $b0.0
	c0	addcg $r0.15, $b0.1 = $r0.11, $r0.11, $b0.1
;;
	c0	addcg $r0.11, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.11, $r0.11, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.0 = $r0.11, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.2 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
	c0	mtb $b0.0 = $r0.10
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.14, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
	c0	addcg $r0.12, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.14, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
	c0	addcg $r0.12, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.14, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
	c0	addcg $r0.12, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.14, $b0.2
	c0	cmpgeu $r0.12 = $r0.6, $r0.8
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.14, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	cmpge $b0.2 = $r0.11, $r0.0
	c0	addcg $r0.10, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	orc $r0.10 = $r0.10, $r0.0
;;
	c0	mfb $r0.11 = $b0.2
;;
	c0	sh1add $r0.10 = $r0.10, $r0.11
;;
	c0	slct $r0.10 = $b0.0, $r0.12, $r0.10
;;
	c0	shl $r0.12 = $r0.10, $r0.7
	c0	goto LBB43_62
;;
LBB43_14:                               ## %if.end
	c0	cmpne $b0.0 = $r0.10, 255
;;
;;
	c0	br $b0.0, LBB43_28
;;
## BB#15:                               ## %if.then.13
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB43_27
;;
## BB#16:                               ## %if.then.15
	c0	and $r0.3 = $r0.4, 4194303
	c0	and $r0.5 = $r0.2, 4194303
;;
	c0	and $r0.6 = $r0.2, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.3, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.3 = $b0.0
;;
	c0	slct $r0.3 = $b0.3, $r0.3, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB43_18
;;
## BB#17:                               ## %if.then.i.175
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB43_18:                               ## %if.end.i.177
	c0	cmpeq $b0.0 = $r0.3, 0
	c0	or $r0.5 = $r0.2, 4194304
;;
	c0	or $r0.3 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB43_23
;;
## BB#19:                               ## %if.then.8.i.179
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB43_20
;;
LBB43_6:                                ## %if.end.11.i.222
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.2, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_58:
	c0	mov $r0.5 = -1
	c0	goto LBB43_72
;;
LBB43_7:                                ## %if.else.i.223
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#8:                                ## %if.then.15.i.227
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB43_10
;;
## BB#9:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_10:                               ## %returnLargerSignificand.i.231
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#11:                               ## %if.end.25.i.233
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB43_13
;;
## BB#12:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_45:                               ## %if.then.35
	c0	mov $r0.2 = float_exception_flags
	c0	or $r0.5 = $r0.8, $r0.6
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB43_46
;;
## BB#47:                               ## %if.end.39
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	or $r0.4 = $r0.4, 4
;;
	c0	or $r0.3 = $r0.3, 2139095040
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_28:                               ## %if.end.18
	c0	shl $r0.2 = $r0.3, $r0.7
;;
	c0	or $r0.3 = $r0.2, 2139095040
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_60:
	c0	mov $r0.12 = -65536
;;
LBB43_62:                               ## %cond.end.i
	c0	shru $r0.10 = $r0.12, $r0.7
	c0	and $r0.11 = $r0.9, 65280
	c0	mov $r0.9 = -1
;;
	c0	mpyhs $r0.14 = $r0.10, $r0.8
	c0	mpyhs $r0.15 = $r0.10, $r0.11
;;
	c0	mpylu $r0.16 = $r0.10, $r0.11
	c0	mpylu $r0.17 = $r0.10, $r0.8
;;
;;
	c0	add $r0.15 = $r0.16, $r0.15
	c0	mov $r0.10 = 0
	c0	add $r0.14 = $r0.17, $r0.14
;;
	c0	shl $r0.16 = $r0.15, $r0.7
	c0	shru $r0.15 = $r0.15, $r0.7
	c0	sub $r0.17 = $r0.6, $r0.14
;;
	c0	cmpne $r0.18 = $r0.16, 0
	c0	sub $r0.14 = $r0.10, $r0.16
	c0	sub $r0.15 = $r0.17, $r0.15
;;
	c0	mtb $b0.0 = $r0.18
;;
;;
	c0	slct $r0.16 = $b0.0, $r0.9, 0
;;
	c0	add $r0.15 = $r0.15, $r0.16
;;
	c0	cmpgt $b0.0 = $r0.15, -1
;;
;;
	c0	br $b0.0, LBB43_65
;;
## BB#63:                               ## %while.body.lr.ph.i
	c0	mov $r0.16 = 24
;;
	c0	shl $r0.5 = $r0.5, $r0.16
;;
LBB43_64:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.14 = $r0.14, $r0.5
	c0	add $r0.15 = $r0.15, $r0.8
	c0	add $r0.12 = $r0.12, -65536
;;
	c0	cmpltu $r0.16 = $r0.14, $r0.5
;;
	c0	add $r0.15 = $r0.15, $r0.16
;;
	c0	cmplt $b0.0 = $r0.15, 0
;;
;;
	c0	br $b0.0, LBB43_64
;;
LBB43_65:                               ## %while.end.i
	c0	shl $r0.5 = $r0.15, $r0.7
	c0	shru $r0.14 = $r0.14, $r0.7
;;
	c0	or $r0.5 = $r0.14, $r0.5
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.5
;;
;;
	c0	br $b0.0, LBB43_66
;;
## BB#67:                               ## %cond.false.10.i
	c0	cmplt $r0.13 = $r0.8, $r0.0
	c0	mov $r0.14 = 0
;;
	c0	shru $r0.15 = $r0.5, $r0.13
	c0	mtb $b0.0 = $r0.14
	c0	shru $r0.16 = $r0.8, $r0.13
	c0	mtb $b0.1 = $r0.14
;;
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
;;
	c0	divs $r0.15, $b0.0 = $r0.0, $r0.16, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.15, $b0.1 = $r0.15, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.15, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.0
	c0	mtb $b0.0 = $r0.13
;;
	c0	addcg $r0.13, $b0.2 = $r0.17, $r0.17, $b0.2
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.16, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.16, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.16, $b0.1
	c0	cmpgeu $r0.5 = $r0.5, $r0.8
	c0	addcg $r0.14, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	cmpge $b0.2 = $r0.13, $r0.0
	c0	addcg $r0.13, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	orc $r0.13 = $r0.13, $r0.0
;;
	c0	mfb $r0.14 = $b0.2
;;
	c0	sh1add $r0.13 = $r0.13, $r0.14
;;
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.13
	c0	goto LBB43_68
;;
LBB43_66:
	c0	mov $r0.5 = 65535
;;
LBB43_68:                               ## %estimateDiv64To32.exit
	c0	or $r0.5 = $r0.5, $r0.12
;;
	c0	and $r0.12 = $r0.5, 63
;;
	c0	cmpgtu $b0.0 = $r0.12, 2
;;
;;
	c0	br $b0.0, LBB43_72
;;
## BB#69:                               ## %if.then.63
	c0	shru $r0.12 = $r0.5, $r0.7
	c0	zxth $r0.13 = $r0.5
;;
	c0	mpyhs $r0.14 = $r0.12, $r0.11
	c0	mpylu $r0.15 = $r0.12, $r0.11
;;
	c0	mpylu $r0.16 = $r0.13, $r0.8
	c0	mpyhs $r0.17 = $r0.13, $r0.8
;;
	c0	add $r0.14 = $r0.15, $r0.14
	c0	mpylu $r0.15 = $r0.13, $r0.11
	c0	mpyhs $r0.11 = $r0.13, $r0.11
;;
	c0	add $r0.13 = $r0.16, $r0.17
	c0	mpylu $r0.16 = $r0.12, $r0.8
	c0	mpyhs $r0.8 = $r0.12, $r0.8
;;
	c0	add $r0.12 = $r0.14, $r0.13
;;
	c0	shl $r0.13 = $r0.12, $r0.7
	c0	add $r0.11 = $r0.15, $r0.11
;;
	c0	add $r0.11 = $r0.13, $r0.11
;;
	c0	cmpltu $r0.13 = $r0.11, $r0.13
;;
	c0	mtb $b0.0 = $r0.13
	c0	add $r0.8 = $r0.16, $r0.8
;;
	c0	sub $r0.8 = $r0.6, $r0.8
	c0	cmpltu $r0.6 = $r0.12, $r0.14
	c0	shru $r0.12 = $r0.12, $r0.7
;;
	c0	shl $r0.7 = $r0.6, $r0.7
	c0	cmpne $r0.13 = $r0.11, 0
	c0	sub $r0.6 = $r0.10, $r0.11
;;
	c0	or $r0.7 = $r0.7, $r0.12
	c0	mtb $b0.1 = $r0.13
;;
	c0	sub $r0.7 = $r0.8, $r0.7
	c0	mfb $r0.8 = $b0.0
;;
	c0	slct $r0.9 = $b0.1, $r0.9, 0
	c0	add $r0.7 = $r0.7, $r0.8
;;
	c0	add $r0.7 = $r0.7, $r0.9
;;
	c0	cmpgt $b0.0 = $r0.7, -1
;;
;;
	c0	br $b0.0, LBB43_71
;;
LBB43_70:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.6 = $r0.6, $r0.2
	c0	add $r0.5 = $r0.5, -1
;;
	c0	cmpltu $r0.8 = $r0.6, $r0.2
;;
	c0	add $r0.7 = $r0.8, $r0.7
;;
	c0	cmplt $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB43_70
;;
LBB43_71:                               ## %while.end
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.5 = $r0.2, $r0.5
;;
LBB43_72:                               ## %if.end.69
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
LBB43_73:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_43:                               ## %if.end.27
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_53:                               ## %if.then.48
	c0	shl $r0.3 = $r0.3, $r0.7
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_13:                               ## %if.end.31.i.236
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_27:                               ## %if.end.17
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = -4194304
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_46:                               ## %if.then.38
	c0	or $r0.4 = $r0.4, 1
	c0	mov $r0.3 = -4194304
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_39:                               ## %if.else.i
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#40:                               ## %if.then.15.i
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB43_36
;;
## BB#41:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_36:                               ## %returnLargerSignificand.i
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#37:                               ## %if.end.25.i
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB43_42
;;
## BB#38:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_23:                               ## %if.else.i.182
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#24:                               ## %if.then.15.i.186
	c0	and $r0.2 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.2, 2139095041
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB43_20
;;
## BB#25:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_20:                               ## %returnLargerSignificand.i.190
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.2 = $r0.3, $r0.4
	c0	shl $r0.4 = $r0.5, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.2
;;
;;
	c0	br $b0.0, LBB43_73
;;
## BB#21:                               ## %if.end.25.i.192
	c0	cmpltu $b0.0 = $r0.2, $r0.4
;;
;;
	c0	brf $b0.0, LBB43_26
;;
## BB#22:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_42:                               ## %if.end.31.i
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB43_26:                               ## %if.end.31.i.195
	c0	minu $r0.3 = $r0.5, $r0.3
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float32_rem
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_rem
float32_rem::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 23
;;
	c0	shru $r0.5 = $r0.3, $r0.2
;;
	c0	zxtb $r0.7 = $r0.5
	c0	shru $r0.2 = $r0.4, $r0.2
;;
	c0	cmpne $b0.0 = $r0.7, 255
	c0	and $r0.5 = $r0.3, 8388607
;;
	c0	and $r0.6 = $r0.4, 8388607
	c0	zxtb $r0.2 = $r0.2
;;
;;
	c0	br $b0.0, LBB44_18
;;
## BB#1:                                ## %if.then
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB44_4
;;
## BB#2:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_35
;;
## BB#3:                                ## %lor.lhs.false
	c0	cmpne $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB44_35
;;
LBB44_4:                                ## %if.then.8
	c0	and $r0.2 = $r0.4, 4194303
	c0	and $r0.5 = $r0.3, 4194303
;;
	c0	and $r0.6 = $r0.3, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.2 = $b0.0
	c0	mfb $r0.5 = $b0.1
;;
	c0	slct $r0.2 = $b0.3, $r0.2, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB44_6
;;
## BB#5:                                ## %if.then.i.273
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB44_6:                                ## %if.end.i.275
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	or $r0.5 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB44_9
;;
## BB#7:                                ## %if.then.8.i.277
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_13
;;
	c0	goto LBB44_8
;;
LBB44_18:                               ## %if.end.10
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB44_19
;;
## BB#34:                               ## %if.then.19
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB44_35
;;
## BB#36:                               ## %if.end.22
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.2 = 16
	c0	mov $r0.8 = 4
;;
	c0	shl $r0.2 = $r0.4, $r0.2
;;
	c0	mfb $r0.4 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.4 = $r0.4, $r0.8
;;
;;
	c0	br $b0.0, LBB44_38
;;
## BB#37:                               ## %if.then.4.i.i.232
	c0	or $r0.4 = $r0.4, 8
	c0	mov $r0.8 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.8
	c0	zxtb $r0.4 = $r0.4
;;
LBB44_38:                               ## %normalizeFloat32Subnormal.exit246
	c0	mov $r0.8 = 24
	c0	mov $r0.9 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.8
;;
	c0	add $r0.2 = $r0.9, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.4
;;
	c0	shl $r0.2 = $r0.2, $r0.8
;;
	c0	add $r0.2 = $r0.2, -134217728
;;
	c0	shr $r0.2 = $r0.2, $r0.8
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.6 = $r0.6, $r0.2
	c0	sub $r0.2 = $r0.4, $r0.2
	c0	goto LBB44_39
;;
LBB44_19:                               ## %if.end.10
	c0	cmpne $b0.0 = $r0.2, 255
;;
;;
	c0	br $b0.0, LBB44_39
;;
## BB#20:                               ## %if.then.12
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_83
;;
## BB#21:                               ## %if.then.14
	c0	and $r0.2 = $r0.4, 4194303
	c0	and $r0.5 = $r0.3, 4194303
;;
	c0	and $r0.6 = $r0.3, 2143289344
	c0	and $r0.7 = $r0.4, 2143289344
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	cmpeq $b0.2 = $r0.7, 2139095040
;;
	c0	cmpeq $b0.3 = $r0.6, 2139095040
;;
	c0	mfb $r0.5 = $b0.1
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.2 = $b0.3, $r0.2, 0
	c0	slct $r0.6 = $b0.2, $r0.5, 0
;;
	c0	or $r0.5 = $r0.6, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB44_23
;;
## BB#22:                               ## %if.then.i
	c0	mov $r0.5 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.5]
;;
;;
	c0	or $r0.7 = $r0.7, 1
;;
	c0	stb 0[$r0.5] = $r0.7
;;
LBB44_23:                               ## %if.end.i.249
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	or $r0.5 = $r0.4, 4194304
;;
;;
	c0	br $b0.0, LBB44_27
;;
## BB#24:                               ## %if.then.8.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_25
;;
LBB44_8:                                ## %if.end.11.i.279
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.3, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.5, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_39:                               ## %if.end.23
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB44_44
;;
## BB#40:                               ## %if.then.25
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB44_83
;;
## BB#41:                               ## %if.end.28
	c0	cmpltu $b0.0 = $r0.5, 65536
	c0	mov $r0.4 = 16
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.4 = $r0.3, $r0.4
;;
	c0	mfb $r0.8 = $b0.0
	c0	slct $r0.4 = $b0.0, $r0.4, $r0.5
;;
	c0	cmpgtu $b0.0 = $r0.4, 16777215
	c0	shl $r0.7 = $r0.8, $r0.7
;;
;;
	c0	br $b0.0, LBB44_43
;;
## BB#42:                               ## %if.then.4.i.i.211
	c0	or $r0.7 = $r0.7, 8
	c0	mov $r0.8 = 8
;;
	c0	shl $r0.4 = $r0.4, $r0.8
	c0	zxtb $r0.7 = $r0.7
;;
LBB44_43:                               ## %normalizeFloat32Subnormal.exit
	c0	mov $r0.8 = 24
	c0	mov $r0.9 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.4 = $r0.4, $r0.8
;;
	c0	add $r0.4 = $r0.9, $r0.4
;;
	c0	ldb $r0.4 = 0[$r0.4]
;;
;;
	c0	add $r0.4 = $r0.4, $r0.7
;;
	c0	shl $r0.4 = $r0.4, $r0.8
;;
	c0	add $r0.4 = $r0.4, -134217728
;;
	c0	shr $r0.4 = $r0.4, $r0.8
	c0	mov $r0.7 = 1
;;
	c0	shl $r0.5 = $r0.5, $r0.4
	c0	sub $r0.7 = $r0.7, $r0.4
;;
LBB44_44:                               ## %if.end.29
	c0	mov $r0.4 = 8
	c0	sub $r0.9 = $r0.7, $r0.2
;;
	c0	shl $r0.8 = $r0.6, $r0.4
	c0	shl $r0.5 = $r0.5, $r0.4
	c0	cmpgt $b0.0 = $r0.9, -1
;;
	c0	or $r0.7 = $r0.5, -2147483648
	c0	or $r0.5 = $r0.8, -2147483648
;;
	c0	brf $b0.0, LBB44_45
;;
## BB#48:                               ## %if.end.37
	c0	cmpgeu $b0.0 = $r0.7, $r0.5
	c0	cmplt $b0.1 = $r0.9, 33
	c0	add $r0.9 = $r0.9, -32
;;
;;
	c0	slct $r0.10 = $b0.0, $r0.5, 0
;;
	c0	sub $r0.7 = $r0.7, $r0.10
	c0	br $b0.1, LBB44_49
;;
## BB#50:                               ## %while.body.lr.ph
	c0	mov $r0.10 = 16
	c0	mov $r0.17 = 2
;;
	c0	shru $r0.11 = $r0.5, $r0.10
	c0	mov $r0.12 = 0
	c0	mov $r0.18 = 24
;;
	c0	mov $r0.13 = 65535
	c0	and $r0.14 = $r0.8, 65280
;;
	c0	mov $r0.15 = -65536
	c0	mov $r0.16 = -1
	c0	mov $r0.21 = $r0.9
;;
	c0	shru $r0.9 = $r0.5, $r0.17
	c0	shl $r0.17 = $r0.6, $r0.18
	c0	cmplt $r0.18 = $r0.11, $r0.0
	c0	shl $r0.19 = $r0.11, $r0.10
;;
	c0	sub $r0.20 = $r0.12, $r0.9
	c0	mtb $b0.0 = $r0.18
	c0	shru $r0.22 = $r0.11, $r0.18
;;
LBB44_51:                               ## %while.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB44_55 Depth 2
	c0	cmpleu $b0.1 = $r0.5, $r0.7
	c0	mov $r0.9 = $r0.16
;;
;;
	c0	br $b0.1, LBB44_59
;;
## BB#52:                               ## %if.end.i.155
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	cmpleu $b0.1 = $r0.19, $r0.7
	c0	mov $r0.9 = $r0.15
;;
;;
	c0	br $b0.1, LBB44_54
;;
## BB#53:                               ## %cond.false.i.158
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	shru $r0.9 = $r0.7, $r0.18
	c0	mtb $b0.1 = $r0.12
	c0	mtb $b0.2 = $r0.12
	c0	cmpgeu $r0.23 = $r0.7, $r0.11
;;
;;
	c0	addcg $r0.24, $b0.1 = $r0.9, $r0.9, $b0.1
;;
	c0	divs $r0.9, $b0.1 = $r0.0, $r0.22, $b0.1
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.22, $b0.1
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	cmpge $b0.1 = $r0.9, $r0.0
	c0	addcg $r0.9, $b0.2 = $r0.24, $r0.24, $b0.2
;;
	c0	orc $r0.9 = $r0.9, $r0.0
;;
	c0	mfb $r0.24 = $b0.1
;;
	c0	sh1add $r0.9 = $r0.9, $r0.24
;;
	c0	slct $r0.9 = $b0.0, $r0.23, $r0.9
;;
	c0	shl $r0.9 = $r0.9, $r0.10
;;
LBB44_54:                               ## %cond.end.i.173
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	shru $r0.23 = $r0.9, $r0.10
;;
	c0	mpylu $r0.24 = $r0.23, $r0.14
	c0	mpyhs $r0.25 = $r0.23, $r0.14
;;
	c0	mpylu $r0.26 = $r0.23, $r0.11
	c0	mpyhs $r0.23 = $r0.23, $r0.11
;;
	c0	add $r0.24 = $r0.24, $r0.25
;;
	c0	add $r0.23 = $r0.26, $r0.23
	c0	shl $r0.25 = $r0.24, $r0.10
	c0	shru $r0.24 = $r0.24, $r0.10
;;
	c0	sub $r0.23 = $r0.7, $r0.23
	c0	cmpne $r0.26 = $r0.25, 0
	c0	sub $r0.7 = $r0.12, $r0.25
;;
	c0	sub $r0.23 = $r0.23, $r0.24
	c0	mtb $b0.1 = $r0.26
;;
;;
	c0	slct $r0.24 = $b0.1, $r0.16, 0
;;
	c0	add $r0.23 = $r0.23, $r0.24
;;
	c0	cmpgt $b0.1 = $r0.23, -1
;;
;;
	c0	br $b0.1, LBB44_56
;;
LBB44_55:                               ## %while.body.i.186
                                        ##   Parent Loop BB44_51 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.7 = $r0.7, $r0.17
	c0	add $r0.23 = $r0.23, $r0.11
	c0	add $r0.9 = $r0.9, -65536
;;
	c0	cmpltu $r0.24 = $r0.7, $r0.17
;;
	c0	add $r0.23 = $r0.23, $r0.24
;;
	c0	cmplt $b0.1 = $r0.23, 0
;;
;;
	c0	br $b0.1, LBB44_55
;;
LBB44_56:                               ## %while.end.i.194
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	shl $r0.23 = $r0.23, $r0.10
	c0	shru $r0.24 = $r0.7, $r0.10
	c0	mov $r0.7 = $r0.13
;;
	c0	or $r0.23 = $r0.24, $r0.23
;;
	c0	cmpleu $b0.1 = $r0.19, $r0.23
;;
;;
	c0	br $b0.1, LBB44_58
;;
## BB#57:                               ## %cond.false.10.i.196
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	shru $r0.7 = $r0.23, $r0.18
	c0	mtb $b0.1 = $r0.12
	c0	mtb $b0.2 = $r0.12
	c0	cmpgeu $r0.23 = $r0.23, $r0.11
;;
;;
	c0	addcg $r0.24, $b0.1 = $r0.7, $r0.7, $b0.1
;;
	c0	divs $r0.7, $b0.1 = $r0.0, $r0.22, $b0.1
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	addcg $r0.25, $b0.2 = $r0.24, $r0.24, $b0.2
	c0	divs $r0.7, $b0.1 = $r0.7, $r0.22, $b0.1
;;
	c0	divs $r0.7, $b0.2 = $r0.7, $r0.22, $b0.2
	c0	addcg $r0.24, $b0.1 = $r0.25, $r0.25, $b0.1
;;
	c0	cmpge $b0.1 = $r0.7, $r0.0
	c0	addcg $r0.7, $b0.2 = $r0.24, $r0.24, $b0.2
;;
	c0	orc $r0.7 = $r0.7, $r0.0
;;
	c0	mfb $r0.24 = $b0.1
;;
	c0	sh1add $r0.7 = $r0.7, $r0.24
;;
	c0	slct $r0.7 = $b0.0, $r0.23, $r0.7
;;
LBB44_58:                               ## %cond.end.12.i.199
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	or $r0.9 = $r0.7, $r0.9
;;
LBB44_59:                               ## %estimateDiv64To32.exit201
                                        ##   in Loop: Header=BB44_51 Depth=1
	c0	cmpgtu $b0.1 = $r0.9, 2
	c0	add $r0.7 = $r0.9, -2
	c0	cmpgt $b0.2 = $r0.21, 30
	c0	add $r0.9 = $r0.21, -30
;;
;;
	c0	slct $r0.23 = $b0.1, $r0.7, 0
	c0	mov $r0.21 = $r0.9
;;
	c0	mpyhs $r0.7 = $r0.23, $r0.20
	c0	mpylu $r0.24 = $r0.23, $r0.20
;;
;;
	c0	add $r0.7 = $r0.24, $r0.7
	c0	br $b0.2, LBB44_51
;;
	c0	goto LBB44_60
;;
LBB44_35:                               ## %if.end
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = -4194304
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_9:                                ## %if.else.i.280
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	br $b0.0, LBB44_10
;;
## BB#11:                               ## %if.then.15.i.284
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB44_13
;;
## BB#12:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_13:                               ## %returnLargerSignificand.i.288
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.3
;;
;;
	c0	brf $b0.0, LBB44_15
;;
## BB#14:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_15:                               ## %if.end.25.i.290
	c0	cmpltu $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB44_17
;;
## BB#16:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_45:                               ## %if.then.33
	c0	cmplt $b0.0 = $r0.9, -1
;;
;;
	c0	br $b0.0, LBB44_83
;;
## BB#46:                               ## %while.end.thread
	c0	mov $r0.6 = 1
	c0	mov $r0.23 = 0
;;
	c0	shru $r0.7 = $r0.7, $r0.6
	c0	goto LBB44_47
;;
LBB44_49:
	c0	mfb $r0.23 = $b0.0
;;
LBB44_60:                               ## %while.end
	c0	cmplt $b0.0 = $r0.9, -31
;;
;;
	c0	br $b0.0, LBB44_47
;;
## BB#61:                               ## %if.then.55
	c0	cmpleu $b0.0 = $r0.5, $r0.7
;;
;;
	c0	br $b0.0, LBB44_62
;;
## BB#63:                               ## %if.end.i
	c0	mov $r0.13 = 16
;;
	c0	shru $r0.10 = $r0.5, $r0.13
;;
	c0	shl $r0.12 = $r0.10, $r0.13
;;
	c0	cmpleu $b0.0 = $r0.12, $r0.7
;;
;;
	c0	br $b0.0, LBB44_64
;;
## BB#65:                               ## %cond.false.i
	c0	cmplt $r0.11 = $r0.10, $r0.0
	c0	mov $r0.14 = 0
;;
	c0	shru $r0.15 = $r0.7, $r0.11
	c0	mtb $b0.0 = $r0.14
	c0	shru $r0.16 = $r0.10, $r0.11
	c0	mtb $b0.1 = $r0.14
;;
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
;;
	c0	divs $r0.15, $b0.0 = $r0.0, $r0.16, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.15, $b0.1 = $r0.15, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.15, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.2 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	mtb $b0.0 = $r0.11
;;
	c0	addcg $r0.11, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
	c0	cmpgeu $r0.15 = $r0.7, $r0.10
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	cmpge $b0.2 = $r0.14, $r0.0
	c0	addcg $r0.11, $b0.1 = $r0.16, $r0.16, $b0.1
;;
	c0	orc $r0.11 = $r0.11, $r0.0
;;
	c0	mfb $r0.14 = $b0.2
;;
	c0	sh1add $r0.11 = $r0.11, $r0.14
;;
	c0	slct $r0.11 = $b0.0, $r0.15, $r0.11
;;
	c0	shl $r0.11 = $r0.11, $r0.13
	c0	goto LBB44_66
;;
LBB44_47:                               ## %if.else
	c0	mov $r0.8 = 2
;;
	c0	shru $r0.6 = $r0.5, $r0.8
	c0	shru $r0.5 = $r0.7, $r0.8
	c0	goto LBB44_74
;;
LBB44_10:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_17:                               ## %if.end.31.i.293
	c0	minu $r0.3 = $r0.2, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_62:
	c0	mov $r0.6 = -1
	c0	goto LBB44_73
;;
LBB44_27:                               ## %if.else.i
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	br $b0.0, LBB44_28
;;
## BB#29:                               ## %if.then.15.i
	c0	and $r0.3 = $r0.4, 2147483647
;;
	c0	cmpltu $b0.0 = $r0.3, 2139095041
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.3 = $r0.6, $r0.3
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB44_25
;;
## BB#30:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_25:                               ## %returnLargerSignificand.i
	c0	mov $r0.4 = 1
;;
	c0	shl $r0.3 = $r0.5, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
;;
	c0	cmpltu $b0.0 = $r0.4, $r0.3
;;
;;
	c0	brf $b0.0, LBB44_31
;;
## BB#26:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_64:
	c0	mov $r0.11 = -65536
;;
LBB44_66:                               ## %cond.end.i
	c0	shru $r0.14 = $r0.11, $r0.13
	c0	and $r0.8 = $r0.8, 65280
	c0	mov $r0.15 = -1
;;
	c0	mpyhs $r0.16 = $r0.14, $r0.10
	c0	mpyhs $r0.17 = $r0.14, $r0.8
;;
	c0	mpylu $r0.8 = $r0.14, $r0.8
	c0	mpylu $r0.14 = $r0.14, $r0.10
;;
;;
	c0	add $r0.8 = $r0.8, $r0.17
	c0	mov $r0.17 = 0
	c0	add $r0.14 = $r0.14, $r0.16
;;
	c0	shl $r0.16 = $r0.8, $r0.13
	c0	shru $r0.18 = $r0.8, $r0.13
	c0	sub $r0.14 = $r0.7, $r0.14
;;
	c0	cmpne $r0.19 = $r0.16, 0
	c0	sub $r0.8 = $r0.17, $r0.16
	c0	sub $r0.14 = $r0.14, $r0.18
;;
	c0	mtb $b0.0 = $r0.19
;;
;;
	c0	slct $r0.15 = $b0.0, $r0.15, 0
;;
	c0	add $r0.14 = $r0.14, $r0.15
;;
	c0	cmpgt $b0.0 = $r0.14, -1
;;
;;
	c0	br $b0.0, LBB44_69
;;
## BB#67:                               ## %while.body.lr.ph.i
	c0	mov $r0.15 = 24
;;
	c0	shl $r0.6 = $r0.6, $r0.15
;;
LBB44_68:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.8 = $r0.8, $r0.6
	c0	add $r0.14 = $r0.14, $r0.10
	c0	add $r0.11 = $r0.11, -65536
;;
	c0	cmpltu $r0.15 = $r0.8, $r0.6
;;
	c0	add $r0.14 = $r0.14, $r0.15
;;
	c0	cmplt $b0.0 = $r0.14, 0
;;
;;
	c0	br $b0.0, LBB44_68
;;
LBB44_69:                               ## %while.end.i
	c0	shl $r0.6 = $r0.14, $r0.13
	c0	shru $r0.8 = $r0.8, $r0.13
;;
	c0	or $r0.6 = $r0.8, $r0.6
;;
	c0	cmpleu $b0.0 = $r0.12, $r0.6
;;
;;
	c0	br $b0.0, LBB44_70
;;
## BB#71:                               ## %cond.false.10.i
	c0	cmplt $r0.8 = $r0.10, $r0.0
	c0	mov $r0.12 = 0
;;
	c0	shru $r0.13 = $r0.6, $r0.8
	c0	mtb $b0.0 = $r0.12
	c0	shru $r0.14 = $r0.10, $r0.8
	c0	mtb $b0.1 = $r0.12
;;
;;
	c0	addcg $r0.12, $b0.0 = $r0.13, $r0.13, $b0.0
;;
	c0	divs $r0.13, $b0.0 = $r0.0, $r0.14, $b0.0
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
;;
	c0	addcg $r0.12, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.13, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.14, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.14, $b0.0
	c0	mtb $b0.0 = $r0.8
;;
	c0	addcg $r0.8, $b0.2 = $r0.15, $r0.15, $b0.2
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.14, $b0.1
;;
	c0	addcg $r0.13, $b0.1 = $r0.8, $r0.8, $b0.1
	c0	divs $r0.8, $b0.2 = $r0.12, $r0.14, $b0.2
;;
	c0	divs $r0.8, $b0.1 = $r0.8, $r0.14, $b0.1
	c0	addcg $r0.12, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	addcg $r0.13, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.8, $b0.2 = $r0.8, $r0.14, $b0.2
;;
	c0	divs $r0.8, $b0.1 = $r0.8, $r0.14, $b0.1
	c0	cmpgeu $r0.6 = $r0.6, $r0.10
	c0	addcg $r0.10, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	cmpge $b0.2 = $r0.8, $r0.0
	c0	addcg $r0.8, $b0.1 = $r0.10, $r0.10, $b0.1
;;
	c0	orc $r0.8 = $r0.8, $r0.0
;;
	c0	mfb $r0.10 = $b0.2
;;
	c0	sh1add $r0.8 = $r0.8, $r0.10
;;
	c0	slct $r0.6 = $b0.0, $r0.6, $r0.8
	c0	goto LBB44_72
;;
LBB44_31:                               ## %if.end.25.i
	c0	cmpltu $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB44_33
;;
## BB#32:
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_70:
	c0	mov $r0.6 = 65535
;;
LBB44_72:                               ## %cond.end.12.i
	c0	or $r0.6 = $r0.6, $r0.11
;;
LBB44_73:                               ## %estimateDiv64To32.exit
	c0	cmpgtu $b0.0 = $r0.6, 2
	c0	add $r0.8 = $r0.6, -2
	c0	mov $r0.6 = 0
	c0	mov $r0.10 = 2
;;
	c0	sub $r0.11 = $r0.6, $r0.9
	c0	shru $r0.6 = $r0.5, $r0.10
	c0	mov $r0.5 = 1
	c0	add $r0.9 = $r0.9, 31
;;
	c0	slct $r0.8 = $b0.0, $r0.8, 0
	c0	shru $r0.5 = $r0.7, $r0.5
;;
	c0	shl $r0.5 = $r0.5, $r0.9
	c0	shru $r0.23 = $r0.8, $r0.11
;;
	c0	mpyhs $r0.7 = $r0.23, $r0.6
	c0	mpylu $r0.8 = $r0.23, $r0.6
;;
;;
	c0	add $r0.7 = $r0.8, $r0.7
;;
	c0	sub $r0.5 = $r0.5, $r0.7
;;
LBB44_74:                               ## %do.body.preheader
	c0	mov $r0.7 = 31
;;
	c0	shru $r0.3 = $r0.3, $r0.7
;;
LBB44_75:                               ## %do.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	mov $r0.8 = $r0.5
;;
	c0	sub $r0.5 = $r0.8, $r0.6
	c0	add $r0.23 = $r0.23, 1
;;
	c0	cmpgt $b0.0 = $r0.5, -1
;;
;;
	c0	br $b0.0, LBB44_75
;;
## BB#76:                               ## %do.end
	c0	add $r0.6 = $r0.5, $r0.8
;;
	c0	cmplt $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_79
;;
## BB#77:                               ## %lor.lhs.false.81
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_80
;;
## BB#78:                               ## %lor.lhs.false.81
	c0	and $r0.6 = $r0.23, 1
;;
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB44_80
;;
LBB44_79:                               ## %if.then.86
	c0	mov $r0.5 = $r0.8
;;
LBB44_80:                               ## %if.end.87
	c0	shru $r0.6 = $r0.5, $r0.7
	c0	mov $r0.7 = 0
	c0	mov $r0.8 = 16
;;
	c0	cmpeq $b0.0 = $r0.6, 0
	c0	sub $r0.7 = $r0.7, $r0.5
;;
;;
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.7
;;
	c0	cmpltu $b0.0 = $r0.5, 65536
	c0	mov $r0.9 = 4
	c0	xor $r0.3 = $r0.6, $r0.3
;;
	c0	shl $r0.6 = $r0.5, $r0.8
;;
	c0	mfb $r0.8 = $b0.0
	c0	slct $r0.7 = $b0.0, $r0.6, $r0.5
;;
	c0	cmpgtu $b0.0 = $r0.7, 16777215
	c0	shl $r0.6 = $r0.8, $r0.9
;;
;;
	c0	br $b0.0, LBB44_82
;;
## BB#81:                               ## %if.then.4.i.i
	c0	or $r0.6 = $r0.6, 8
	c0	shl $r0.7 = $r0.7, $r0.4
;;
	c0	zxtb $r0.6 = $r0.6
;;
LBB44_82:                               ## %normalizeRoundAndPackFloat32.exit
	c0	mov $r0.4 = 24
	c0	mov $r0.8 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.7 = $r0.7, $r0.4
;;
	c0	add $r0.7 = $r0.8, $r0.7
;;
	c0	ldb $r0.7 = 0[$r0.7]
;;
;;
	c0	add $r0.6 = $r0.7, $r0.6
;;
	c0	shl $r0.6 = $r0.6, $r0.4
;;
	c0	add $r0.6 = $r0.6, -16777216
;;
	c0	shr $r0.6 = $r0.6, $r0.4
;;
	c0	sub $r0.4 = $r0.2, $r0.6
	c0	shl $r0.5 = $r0.5, $r0.6
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
LBB44_83:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_28:
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB44_33:                               ## %if.end.31.i
	c0	minu $r0.3 = $r0.2, $r0.5
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float32_sqrt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_sqrt
float32_sqrt::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.4 = 23
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.4 = $r0.3, $r0.4
;;
	c0	zxtb $r0.7 = $r0.4
;;
	c0	cmpne $b0.0 = $r0.7, 255
	c0	and $r0.4 = $r0.3, 8388607
	c0	shru $r0.5 = $r0.3, $r0.2
;;
;;
	c0	br $b0.0, LBB45_8
;;
## BB#1:                                ## %if.then
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB45_6
;;
## BB#2:                                ## %if.then.3
	c0	and $r0.4 = $r0.3, 2143289344
	c0	or $r0.2 = $r0.3, 4194304
;;
	c0	cmpne $b0.0 = $r0.4, 2139095040
;;
;;
	c0	br $b0.0, LBB45_5
;;
## BB#3:                                ## %if.then.3
	c0	and $r0.4 = $r0.3, 4194303
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB45_5
;;
## BB#4:                                ## %if.then.8.i
	c0	mov $r0.4 = float_exception_flags
	c0	mov $r0.3 = $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.4]
;;
;;
	c0	or $r0.2 = $r0.2, 1
;;
	c0	stb 0[$r0.4] = $r0.2
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB45_8:                                ## %if.end.8
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB45_10
;;
## BB#9:                                ## %if.then.10
	c0	or $r0.2 = $r0.7, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB45_7
;;
	c0	goto LBB45_42
;;
LBB45_6:                                ## %if.end
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB45_42
;;
LBB45_7:                                ## %if.end.7
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = -4194304
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.2] = $r0.4
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB45_10:                               ## %if.end.14
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB45_16
;;
## BB#11:                               ## %if.then.16
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB45_12
;;
## BB#13:                               ## %if.end.19
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.5 = 16
	c0	mov $r0.6 = 4
;;
	c0	shl $r0.3 = $r0.3, $r0.5
;;
	c0	mfb $r0.5 = $b0.0
	c0	slct $r0.3 = $b0.0, $r0.3, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.3, 16777215
	c0	shl $r0.5 = $r0.5, $r0.6
;;
;;
	c0	br $b0.0, LBB45_15
;;
## BB#14:                               ## %if.then.4.i.i
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.6 = 8
;;
	c0	shl $r0.3 = $r0.3, $r0.6
	c0	zxtb $r0.5 = $r0.5
;;
LBB45_15:                               ## %normalizeFloat32Subnormal.exit
	c0	mov $r0.6 = 24
	c0	mov $r0.7 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.3 = $r0.3, $r0.6
;;
	c0	add $r0.3 = $r0.7, $r0.3
;;
	c0	ldb $r0.3 = 0[$r0.3]
;;
;;
	c0	add $r0.3 = $r0.3, $r0.5
;;
	c0	shl $r0.3 = $r0.3, $r0.6
;;
	c0	add $r0.3 = $r0.3, -134217728
;;
	c0	shr $r0.3 = $r0.3, $r0.6
	c0	mov $r0.5 = 1
;;
	c0	shl $r0.4 = $r0.4, $r0.3
	c0	sub $r0.7 = $r0.5, $r0.3
;;
LBB45_16:                               ## %if.end.20
	c0	mov $r0.8 = 8
	c0	and $r0.6 = $r0.7, 1
	c0	mov $r0.9 = 19
	c0	mov $r0.5 = 17
;;
	c0	add $r0.7 = $r0.7, -127
	c0	mov $r0.3 = 1
	c0	shru $r0.9 = $r0.4, $r0.9
	c0	shl $r0.8 = $r0.4, $r0.8
;;
	c0	cmpeq $b0.0 = $r0.6, 0
	c0	shr $r0.4 = $r0.7, $r0.3
	c0	or $r0.7 = $r0.8, -2147483648
;;
	c0	and $r0.8 = $r0.9, 15
	c0	shru $r0.9 = $r0.7, $r0.5
;;
	c0	brf $b0.0, LBB45_17
;;
## BB#20:                               ## %if.else.i
	c0	mov $r0.10 = estimateSqrt32.sqrtEvenAdjustments
	c0	or $r0.9 = $r0.9, 32768
;;
	c0	mov $r0.11 = 0
	c0	sh1add $r0.8 = $r0.8, $r0.10
;;
	c0	mtb $b0.0 = $r0.11
	c0	mtb $b0.1 = $r0.11
	c0	ldhu $r0.8 = 0[$r0.8]
;;
;;
	c0	sub $r0.8 = $r0.9, $r0.8
;;
	c0	cmplt $r0.9 = $r0.8, $r0.0
;;
	c0	shru $r0.10 = $r0.7, $r0.9
	c0	shru $r0.11 = $r0.8, $r0.9
;;
	c0	addcg $r0.12, $b0.0 = $r0.10, $r0.10, $b0.0
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.0, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.10, $r0.10, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.12, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.2 = $r0.10, $r0.11, $b0.0
	c0	mtb $b0.0 = $r0.9
;;
	c0	divs $r0.9, $b0.1 = $r0.10, $r0.11, $b0.1
	c0	addcg $r0.10, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.10, $r0.10, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.10, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.10, $r0.10, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
	c0	cmpgeu $r0.10 = $r0.7, $r0.8
;;
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.12, $r0.12, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
	c0	mov $r0.12 = 15
;;
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
	c0	addcg $r0.14, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	addcg $r0.13, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	addcg $r0.13, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
	c0	mov $r0.14 = -32768
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
	c0	addcg $r0.13, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.9, $b0.2 = $r0.9, $r0.11, $b0.2
;;
	c0	divs $r0.9, $b0.1 = $r0.9, $r0.11, $b0.1
	c0	addcg $r0.11, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	cmpge $b0.2 = $r0.9, $r0.0
	c0	addcg $r0.9, $b0.1 = $r0.11, $r0.11, $b0.1
;;
	c0	orc $r0.9 = $r0.9, $r0.0
;;
	c0	mfb $r0.11 = $b0.2
;;
	c0	sh1add $r0.9 = $r0.9, $r0.11
;;
	c0	slct $r0.9 = $b0.0, $r0.10, $r0.9
	c0	mov $r0.13 = $r0.7
;;
	c0	add $r0.8 = $r0.8, $r0.9
;;
	c0	cmpgtu $b0.0 = $r0.8, 131071
	c0	shl $r0.8 = $r0.8, $r0.12
;;
;;
	c0	slct $r0.8 = $b0.0, $r0.14, $r0.8
;;
	c0	cmpgtu $b0.0 = $r0.8, $r0.7
;;
;;
	c0	br $b0.0, LBB45_18
;;
## BB#21:                               ## %if.then.19.i
	c0	shr $r0.9 = $r0.7, $r0.3
	c0	goto LBB45_33
;;
LBB45_5:                                ## %if.else.i.89
	c0	and $r0.3 = $r0.3, 2147483647
;;
	c0	cmpgtu $b0.0 = $r0.3, 2139095040
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.2, 4194304
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB45_17:                               ## %if.then.i
	c0	mov $r0.10 = estimateSqrt32.sqrtOddAdjustments
	c0	add $r0.9 = $r0.9, 16384
;;
	c0	mov $r0.11 = 0
	c0	sh1add $r0.8 = $r0.8, $r0.10
;;
	c0	mtb $b0.0 = $r0.11
	c0	mtb $b0.1 = $r0.11
	c0	ldhu $r0.8 = 0[$r0.8]
;;
;;
	c0	sub $r0.8 = $r0.9, $r0.8
;;
	c0	cmplt $r0.9 = $r0.8, $r0.0
;;
	c0	shru $r0.10 = $r0.7, $r0.9
	c0	shru $r0.11 = $r0.8, $r0.9
;;
	c0	addcg $r0.12, $b0.0 = $r0.10, $r0.10, $b0.0
;;
	c0	addcg $r0.10, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.0, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.10, $r0.10, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.12, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	addcg $r0.12, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	addcg $r0.13, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
	c0	mov $r0.12 = 15
	c0	mov $r0.14 = 14
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
;;
	c0	divs $r0.10, $b0.1 = $r0.10, $r0.11, $b0.1
	c0	addcg $r0.16, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	shru $r0.13 = $r0.7, $r0.3
	c0	cmpgeu $r0.15 = $r0.7, $r0.8
;;
	c0	addcg $r0.17, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.10, $b0.0 = $r0.10, $r0.11, $b0.0
	c0	shl $r0.8 = $r0.8, $r0.12
	c0	mtb $b0.2 = $r0.9
;;
	c0	divs $r0.9, $b0.1 = $r0.10, $r0.11, $b0.1
;;
	c0	cmpge $b0.3 = $r0.9, $r0.0
	c0	addcg $r0.9, $b0.0 = $r0.17, $r0.17, $b0.0
;;
	c0	addcg $r0.10, $b0.0 = $r0.9, $r0.9, $b0.1
;;
	c0	orc $r0.9 = $r0.10, $r0.0
	c0	mfb $r0.10 = $b0.3
;;
	c0	sh1add $r0.9 = $r0.9, $r0.10
;;
	c0	slct $r0.9 = $b0.2, $r0.15, $r0.9
;;
	c0	shl $r0.9 = $r0.9, $r0.14
;;
	c0	add $r0.8 = $r0.8, $r0.9
;;
LBB45_18:                               ## %if.end.21.i
	c0	cmpleu $b0.0 = $r0.8, $r0.13
;;
;;
	c0	br $b0.0, LBB45_19
;;
## BB#22:                               ## %if.end.i
	c0	mov $r0.12 = 16
;;
	c0	shru $r0.9 = $r0.8, $r0.12
;;
	c0	shl $r0.11 = $r0.9, $r0.12
;;
	c0	cmpleu $b0.0 = $r0.11, $r0.13
;;
;;
	c0	br $b0.0, LBB45_23
;;
## BB#24:                               ## %cond.false.i
	c0	cmplt $r0.10 = $r0.9, $r0.0
	c0	mov $r0.14 = 0
;;
	c0	shru $r0.15 = $r0.13, $r0.10
	c0	mtb $b0.0 = $r0.14
	c0	shru $r0.16 = $r0.9, $r0.10
	c0	mtb $b0.1 = $r0.14
;;
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
;;
	c0	divs $r0.15, $b0.0 = $r0.0, $r0.16, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.15, $b0.1 = $r0.15, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.15, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.2 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	mtb $b0.0 = $r0.10
;;
	c0	addcg $r0.10, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	addcg $r0.10, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
	c0	cmpgeu $r0.15 = $r0.13, $r0.9
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.10, $r0.10, $b0.2
;;
	c0	cmpge $b0.2 = $r0.14, $r0.0
	c0	addcg $r0.10, $b0.1 = $r0.16, $r0.16, $b0.1
;;
	c0	orc $r0.10 = $r0.10, $r0.0
;;
	c0	mfb $r0.14 = $b0.2
;;
	c0	sh1add $r0.10 = $r0.10, $r0.14
;;
	c0	slct $r0.10 = $b0.0, $r0.15, $r0.10
;;
	c0	shl $r0.10 = $r0.10, $r0.12
	c0	goto LBB45_25
;;
LBB45_19:
	c0	mov $r0.9 = 2147483647
	c0	goto LBB45_32
;;
LBB45_23:
	c0	mov $r0.10 = -65536
;;
LBB45_25:                               ## %cond.end.i
	c0	shru $r0.14 = $r0.10, $r0.12
	c0	zxth $r0.15 = $r0.8
	c0	mov $r0.16 = -1
;;
	c0	mpyhs $r0.17 = $r0.14, $r0.9
	c0	mpyhs $r0.18 = $r0.14, $r0.15
;;
	c0	mpylu $r0.15 = $r0.14, $r0.15
	c0	mpylu $r0.14 = $r0.14, $r0.9
;;
;;
	c0	add $r0.15 = $r0.15, $r0.18
	c0	mov $r0.18 = 0
	c0	add $r0.14 = $r0.14, $r0.17
;;
	c0	shl $r0.17 = $r0.15, $r0.12
	c0	shru $r0.15 = $r0.15, $r0.12
	c0	sub $r0.14 = $r0.13, $r0.14
;;
	c0	cmpne $r0.19 = $r0.17, 0
	c0	sub $r0.13 = $r0.18, $r0.17
	c0	sub $r0.14 = $r0.14, $r0.15
;;
	c0	mtb $b0.0 = $r0.19
;;
;;
	c0	slct $r0.15 = $b0.0, $r0.16, 0
;;
	c0	add $r0.14 = $r0.14, $r0.15
;;
	c0	cmpgt $b0.0 = $r0.14, -1
;;
;;
	c0	br $b0.0, LBB45_28
;;
## BB#26:                               ## %while.body.lr.ph.i
	c0	shl $r0.15 = $r0.8, $r0.12
;;
LBB45_27:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.13 = $r0.13, $r0.15
	c0	add $r0.14 = $r0.14, $r0.9
	c0	add $r0.10 = $r0.10, -65536
;;
	c0	cmpltu $r0.16 = $r0.13, $r0.15
;;
	c0	add $r0.14 = $r0.14, $r0.16
;;
	c0	cmplt $b0.0 = $r0.14, 0
;;
;;
	c0	br $b0.0, LBB45_27
;;
LBB45_28:                               ## %while.end.i
	c0	shl $r0.14 = $r0.14, $r0.12
	c0	shru $r0.12 = $r0.13, $r0.12
;;
	c0	or $r0.12 = $r0.12, $r0.14
;;
	c0	cmpleu $b0.0 = $r0.11, $r0.12
;;
;;
	c0	br $b0.0, LBB45_29
;;
## BB#30:                               ## %cond.false.10.i
	c0	cmplt $r0.11 = $r0.9, $r0.0
	c0	mov $r0.13 = 0
;;
	c0	shru $r0.14 = $r0.12, $r0.11
	c0	mtb $b0.0 = $r0.13
	c0	shru $r0.15 = $r0.9, $r0.11
	c0	mtb $b0.1 = $r0.13
;;
;;
	c0	addcg $r0.13, $b0.0 = $r0.14, $r0.14, $b0.0
;;
	c0	divs $r0.14, $b0.0 = $r0.0, $r0.15, $b0.0
	c0	addcg $r0.16, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	addcg $r0.13, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.14, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.15, $b0.0
	c0	mtb $b0.0 = $r0.11
;;
	c0	addcg $r0.11, $b0.2 = $r0.16, $r0.16, $b0.2
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.11, $r0.11, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.13, $r0.15, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.15, $b0.1
	c0	addcg $r0.13, $b0.2 = $r0.14, $r0.14, $b0.2
;;
	c0	addcg $r0.14, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.15, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.15, $b0.1
	c0	cmpgeu $r0.9 = $r0.12, $r0.9
	c0	addcg $r0.12, $b0.2 = $r0.14, $r0.14, $b0.2
;;
	c0	cmpge $b0.2 = $r0.11, $r0.0
	c0	addcg $r0.11, $b0.1 = $r0.12, $r0.12, $b0.1
;;
	c0	orc $r0.11 = $r0.11, $r0.0
;;
	c0	mfb $r0.12 = $b0.2
;;
	c0	sh1add $r0.11 = $r0.11, $r0.12
;;
	c0	slct $r0.9 = $b0.0, $r0.9, $r0.11
	c0	goto LBB45_31
;;
LBB45_29:
	c0	mov $r0.9 = 65535
;;
LBB45_31:                               ## %cond.end.12.i
	c0	or $r0.9 = $r0.9, $r0.10
;;
	c0	shru $r0.9 = $r0.9, $r0.3
;;
LBB45_32:                               ## %estimateDiv64To32.exit
	c0	shru $r0.8 = $r0.8, $r0.3
;;
	c0	add $r0.9 = $r0.9, $r0.8
;;
LBB45_33:                               ## %estimateSqrt32.exit
	c0	add $r0.8 = $r0.9, 2
	c0	add $r0.4 = $r0.4, 126
;;
	c0	and $r0.10 = $r0.8, 126
;;
	c0	cmpgtu $b0.0 = $r0.10, 5
;;
;;
	c0	br $b0.0, LBB45_40
;;
## BB#34:                               ## %if.then.25
	c0	cmpgtu $b0.0 = $r0.9, -3
;;
;;
	c0	brf $b0.0, LBB45_36
;;
## BB#35:
	c0	mov $r0.5 = 2147483647
	c0	goto LBB45_41
;;
LBB45_36:                               ## %if.else
	c0	mov $r0.10 = 16
	c0	zxth $r0.11 = $r0.8
	c0	shru $r0.6 = $r0.7, $r0.6
	c0	mov $r0.7 = 15
;;
	c0	shru $r0.12 = $r0.8, $r0.10
	c0	mpyhs $r0.13 = $r0.11, $r0.11
	c0	mpylu $r0.14 = $r0.11, $r0.11
	c0	mov $r0.15 = -1
;;
	c0	mpylu $r0.16 = $r0.12, $r0.11
	c0	mpyhs $r0.11 = $r0.12, $r0.11
;;
	c0	mpylu $r0.17 = $r0.12, $r0.12
	c0	mpyhs $r0.12 = $r0.12, $r0.12
;;
	c0	add $r0.11 = $r0.16, $r0.11
	c0	add $r0.13 = $r0.14, $r0.13
;;
	c0	shl $r0.5 = $r0.11, $r0.5
	c0	shl $r0.14 = $r0.11, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.14, $r0.11
	c0	add $r0.13 = $r0.5, $r0.13
;;
	c0	cmpltu $r0.5 = $r0.13, $r0.5
	c0	cmpne $r0.14 = $r0.13, 0
;;
	c0	mtb $b0.1 = $r0.5
	c0	mtb $b0.2 = $r0.14
	c0	mov $r0.5 = 0
	c0	add $r0.12 = $r0.17, $r0.12
;;
	c0	shru $r0.7 = $r0.11, $r0.7
	c0	sub $r0.6 = $r0.6, $r0.12
;;
	c0	zxth $r0.7 = $r0.7
	c0	sub $r0.5 = $r0.5, $r0.13
	c0	mfb $r0.11 = $b0.0
;;
	c0	shl $r0.10 = $r0.11, $r0.10
	c0	mfb $r0.11 = $b0.1
	c0	slct $r0.12 = $b0.2, $r0.15, 0
;;
	c0	or $r0.7 = $r0.10, $r0.7
	c0	add $r0.6 = $r0.6, $r0.11
;;
	c0	add $r0.6 = $r0.6, $r0.12
;;
	c0	sub $r0.6 = $r0.6, $r0.7
;;
	c0	cmpgt $b0.0 = $r0.6, -1
;;
;;
	c0	br $b0.0, LBB45_39
;;
## BB#37:                               ## %while.body.preheader
	c0	mov $r0.7 = 3
;;
	c0	sh1add $r0.7 = $r0.9, $r0.7
;;
LBB45_38:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.8 = $r0.8, -1
	c0	add $r0.5 = $r0.7, $r0.5
;;
	c0	cmpltu $r0.9 = $r0.5, $r0.7
	c0	shru $r0.10 = $r0.8, $r0.2
	c0	add $r0.7 = $r0.7, -2
;;
	c0	add $r0.6 = $r0.10, $r0.6
;;
	c0	add $r0.6 = $r0.6, $r0.9
;;
	c0	cmplt $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB45_38
;;
LBB45_39:                               ## %while.end
	c0	or $r0.2 = $r0.5, $r0.6
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.8 = $r0.2, $r0.8
;;
LBB45_40:                               ## %if.end.36
	c0	and $r0.2 = $r0.8, 1
	c0	shru $r0.3 = $r0.8, $r0.3
;;
	c0	or $r0.5 = $r0.2, $r0.3
;;
LBB45_41:                               ## %roundAndPack
	c0	mov $r0.3 = 0
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
LBB45_42:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB45_12:
	c0	mov $r0.3 = 0
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float32_eq
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_eq
float32_eq::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB46_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB46_4
;;
LBB46_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB46_9
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB46_9
;;
LBB46_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2143289344
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB46_6
;;
## BB#5:                                ## %if.then
	c0	and $r0.2 = $r0.3, 4194303
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB46_8
;;
LBB46_6:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 2143289344
	c0	mov $r0.3 = 0
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB46_12
;;
## BB#7:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 4194303
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB46_12
;;
LBB46_8:                                ## %if.then.13
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB46_9:                                ## %if.end.14
	c0	cmpeq $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB46_11
;;
## BB#10:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB46_11:                               ## %lor.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
LBB46_12:                               ## %return
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_le
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_le
float32_le::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB47_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB47_4
;;
LBB47_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB47_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB47_5
;;
LBB47_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB47_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB47_6
;;
## BB#9:                                ## %if.end.18
	c0	cmpltu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 1
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB47_6:                                ## %if.then.12
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB47_8
;;
## BB#7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB47_8:                                ## %lor.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_lt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_lt
float32_lt::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB48_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB48_4
;;
LBB48_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB48_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB48_5
;;
LBB48_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB48_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB48_6
;;
## BB#9:                                ## %if.end.18
	c0	cmpltu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB48_6:                                ## %if.then.12
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB48_7
;;
## BB#8:                                ## %land.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB48_7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_eq_signaling
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_eq_signaling
float32_eq_signaling::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB49_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB49_4
;;
LBB49_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB49_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB49_5
;;
LBB49_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB49_5:                                ## %if.end
	c0	cmpeq $b0.0 = $r0.3, $r0.4
;;
;;
	c0	brf $b0.0, LBB49_7
;;
## BB#6:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB49_7:                                ## %lor.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_le_quiet
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_le_quiet
float32_le_quiet::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB50_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB50_4
;;
LBB50_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB50_9
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB50_9
;;
LBB50_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2143289344
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB50_6
;;
## BB#5:                                ## %if.then
	c0	and $r0.2 = $r0.3, 4194303
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB50_8
;;
LBB50_6:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 2143289344
	c0	mov $r0.3 = 0
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB50_14
;;
## BB#7:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 4194303
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB50_14
;;
LBB50_8:                                ## %if.then.13
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB50_9:                                ## %if.end.14
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB50_10
;;
## BB#13:                               ## %if.end.27
	c0	cmpltu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 1
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
;;
LBB50_14:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB50_10:                               ## %if.then.21
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB50_12
;;
## BB#11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB50_12:                               ## %lor.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_lt_quiet
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_lt_quiet
float32_lt_quiet::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB51_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB51_4
;;
LBB51_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB51_9
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB51_9
;;
LBB51_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2143289344
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB51_6
;;
## BB#5:                                ## %if.then
	c0	and $r0.2 = $r0.3, 4194303
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB51_8
;;
LBB51_6:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 2143289344
	c0	mov $r0.3 = 0
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB51_14
;;
## BB#7:                                ## %lor.lhs.false.9
	c0	and $r0.2 = $r0.4, 4194303
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB51_14
;;
LBB51_8:                                ## %if.then.13
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB51_9:                                ## %if.end.14
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB51_10
;;
## BB#13:                               ## %if.end.27
	c0	cmpltu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
;;
LBB51_14:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB51_10:                               ## %if.then.21
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB51_11
;;
## BB#12:                               ## %land.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB51_11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_to_int32
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_to_int32
float64_to_int32::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 20
	c0	mov $r0.5 = 31
;;
	c0	shru $r0.7 = $r0.3, $r0.2
;;
	c0	and $r0.8 = $r0.7, 2047
;;
	c0	add $r0.6 = $r0.8, -1043
;;
	c0	cmplt $b0.0 = $r0.6, 0
	c0	and $r0.9 = $r0.3, 1048575
	c0	shru $r0.2 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB52_7
;;
## BB#1:                                ## %if.then
	c0	cmpltu $b0.0 = $r0.8, 1055
;;
;;
	c0	br $b0.0, LBB52_3
;;
## BB#2:                                ## %if.then.5
	c0	or $r0.3 = $r0.9, $r0.4
	c0	cmpne $b0.0 = $r0.8, 2047
;;
	c0	cmpeq $b0.1 = $r0.3, 0
;;
;;
	c0	slct $r0.3 = $b0.1, $r0.2, 0
;;
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.3
	c0	goto LBB52_19
;;
LBB52_7:                                ## %if.else
	c0	cmpne $b0.0 = $r0.4, 0
	c0	cmpgtu $b0.1 = $r0.8, 1021
;;
;;
	c0	mfb $r0.4 = $b0.0
	c0	br $b0.1, LBB52_9
;;
## BB#8:                                ## %if.then.16
	c0	or $r0.6 = $r0.8, $r0.9
	c0	mov $r0.3 = 0
;;
	c0	or $r0.4 = $r0.6, $r0.4
	c0	goto LBB52_10
;;
LBB52_3:                                ## %if.end.8
	c0	cmpeq $b0.0 = $r0.6, 0
	c0	or $r0.3 = $r0.9, 1048576
;;
;;
	c0	br $b0.0, LBB52_5
;;
## BB#4:                                ## %cond.false.i
	c0	mov $r0.8 = 1043
	c0	shl $r0.3 = $r0.3, $r0.6
;;
	c0	sub $r0.7 = $r0.8, $r0.7
;;
	c0	and $r0.7 = $r0.7, 31
;;
	c0	shru $r0.7 = $r0.4, $r0.7
;;
	c0	or $r0.3 = $r0.7, $r0.3
;;
LBB52_5:                                ## %shortShift64Left.exit
	c0	cmpgtu $b0.0 = $r0.3, -2147483648
;;
;;
	c0	br $b0.0, LBB52_19
;;
## BB#6:
	c0	shl $r0.4 = $r0.4, $r0.6
	c0	goto LBB52_10
;;
LBB52_9:                                ## %if.else.19
	c0	add $r0.3 = $r0.7, 13
	c0	mov $r0.6 = 1043
;;
	c0	or $r0.7 = $r0.9, 1048576
	c0	and $r0.3 = $r0.3, 31
	c0	sub $r0.6 = $r0.6, $r0.8
;;
	c0	shl $r0.8 = $r0.7, $r0.3
	c0	shru $r0.3 = $r0.7, $r0.6
;;
	c0	or $r0.4 = $r0.8, $r0.4
;;
LBB52_10:                               ## %if.end.24
	c0	mov $r0.6 = float_rounding_mode
;;
	c0	ldbu $r0.6 = 0[$r0.6]
;;
;;
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB52_11
;;
## BB#14:                               ## %if.else.42
	c0	cmpne $b0.0 = $r0.4, 0
	c0	cmpeq $b0.1 = $r0.2, 0
;;
;;
	c0	mfb $r0.4 = $b0.0
	c0	br $b0.1, LBB52_16
;;
## BB#15:                               ## %if.then.46
	c0	cmpeq $b0.1 = $r0.6, 1
	c0	mfb $r0.6 = $b0.0
	c0	mov $r0.7 = 0
;;
;;
	c0	mfb $r0.8 = $b0.1
;;
	c0	and $r0.6 = $r0.6, $r0.8
;;
	c0	and $r0.6 = $r0.6, 1
;;
	c0	add $r0.3 = $r0.3, $r0.6
;;
	c0	sub $r0.3 = $r0.7, $r0.3
	c0	goto LBB52_17
;;
LBB52_11:                               ## %if.then.28
	c0	cmpgt $b0.0 = $r0.4, -1
;;
;;
	c0	br $b0.0, LBB52_13
;;
## BB#12:                               ## %if.then.31
	c0	and $r0.6 = $r0.4, 2147483647
	c0	add $r0.3 = $r0.3, 1
;;
	c0	and $r0.7 = $r0.3, -2
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.7, $r0.3
;;
LBB52_13:                               ## %if.end.38
	c0	mov $r0.6 = 0
	c0	cmpne $b0.0 = $r0.2, 0
;;
	c0	sub $r0.6 = $r0.6, $r0.3
;;
	c0	slct $r0.3 = $b0.0, $r0.6, $r0.3
	c0	goto LBB52_17
;;
LBB52_16:                               ## %if.else.52
	c0	cmpeq $b0.1 = $r0.6, 2
	c0	mfb $r0.6 = $b0.0
;;
;;
	c0	mfb $r0.7 = $b0.1
;;
	c0	and $r0.6 = $r0.6, $r0.7
;;
	c0	and $r0.6 = $r0.6, 1
;;
	c0	add $r0.3 = $r0.6, $r0.3
;;
LBB52_17:                               ## %if.end.59
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB52_20
;;
## BB#18:                               ## %if.end.59
	c0	shru $r0.5 = $r0.3, $r0.5
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	br $b0.0, LBB52_20
;;
LBB52_19:                               ## %invalid
	c0	mov $r0.4 = float_exception_flags
	c0	cmpne $b0.0 = $r0.2, 0
;;
	c0	ldb $r0.2 = 0[$r0.4]
	c0	mov $r0.3 = -2147483648
;;
	c0	slct $r0.3 = $b0.0, $r0.3, 2147483647
;;
	c0	or $r0.2 = $r0.2, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.4] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB52_20:                               ## %if.end.70
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB52_22
;;
## BB#21:                               ## %if.then.72
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 32
;;
	c0	stb 0[$r0.2] = $r0.4
;;
LBB52_22:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_to_int32_round_to_zero
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_to_int32_round_to_zero
float64_to_int32_round_to_zero::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 20
	c0	mov $r0.5 = 31
;;
	c0	shru $r0.7 = $r0.3, $r0.2
;;
	c0	and $r0.6 = $r0.7, 2047
;;
	c0	add $r0.9 = $r0.6, -1043
;;
	c0	cmplt $b0.0 = $r0.9, 0
	c0	and $r0.8 = $r0.3, 1048575
	c0	shru $r0.2 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB53_5
;;
## BB#1:                                ## %if.then
	c0	cmpltu $b0.0 = $r0.6, 1055
;;
;;
	c0	br $b0.0, LBB53_3
;;
## BB#2:                                ## %if.then.5
	c0	or $r0.3 = $r0.8, $r0.4
	c0	cmpne $b0.0 = $r0.6, 2047
;;
	c0	cmpeq $b0.1 = $r0.3, 0
;;
;;
	c0	slct $r0.3 = $b0.1, $r0.2, 0
;;
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.3
	c0	goto LBB53_10
;;
LBB53_5:                                ## %if.else
	c0	cmpgtu $b0.0 = $r0.6, 1022
;;
;;
	c0	br $b0.0, LBB53_7
;;
## BB#6:                                ## %if.then.11
	c0	or $r0.2 = $r0.8, $r0.4
	c0	mov $r0.3 = 0
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB53_12
;;
	c0	goto LBB53_13
;;
LBB53_3:                                ## %if.end.8
	c0	cmpeq $b0.0 = $r0.9, 0
	c0	shl $r0.6 = $r0.4, $r0.9
	c0	or $r0.3 = $r0.8, 1048576
;;
;;
	c0	br $b0.0, LBB53_8
;;
## BB#4:                                ## %cond.false.i
	c0	mov $r0.8 = 1043
	c0	shl $r0.3 = $r0.3, $r0.9
;;
	c0	sub $r0.7 = $r0.8, $r0.7
;;
	c0	and $r0.7 = $r0.7, 31
;;
	c0	shru $r0.4 = $r0.4, $r0.7
;;
	c0	or $r0.3 = $r0.4, $r0.3
	c0	goto LBB53_8
;;
LBB53_7:                                ## %if.end.19
	c0	add $r0.3 = $r0.7, 13
	c0	mov $r0.7 = 1043
;;
	c0	or $r0.8 = $r0.8, 1048576
	c0	and $r0.3 = $r0.3, 31
	c0	sub $r0.6 = $r0.7, $r0.6
;;
	c0	shl $r0.7 = $r0.8, $r0.3
	c0	shru $r0.3 = $r0.8, $r0.6
;;
	c0	or $r0.6 = $r0.7, $r0.4
;;
LBB53_8:                                ## %if.end.23
	c0	mov $r0.4 = 0
	c0	cmpne $b0.0 = $r0.2, 0
	c0	cmpeq $b0.1 = $r0.3, 0
;;
	c0	sub $r0.4 = $r0.4, $r0.3
;;
	c0	slct $r0.3 = $b0.0, $r0.4, $r0.3
	c0	br $b0.1, LBB53_11
;;
## BB#9:                                ## %if.end.23
	c0	shru $r0.4 = $r0.3, $r0.5
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.4
;;
;;
	c0	br $b0.0, LBB53_11
;;
LBB53_10:                               ## %invalid
	c0	mov $r0.4 = float_exception_flags
	c0	cmpne $b0.0 = $r0.2, 0
;;
	c0	ldb $r0.2 = 0[$r0.4]
	c0	mov $r0.3 = -2147483648
;;
	c0	slct $r0.3 = $b0.0, $r0.3, 2147483647
;;
	c0	or $r0.2 = $r0.2, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.4] = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB53_11:                               ## %if.end.37
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB53_13
;;
LBB53_12:                               ## %if.then.39
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 32
;;
	c0	stb 0[$r0.2] = $r0.4
;;
LBB53_13:                               ## %cleanup
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_to_float32
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_to_float32
float64_to_float32::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.6 = 20
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.5 = 31
;;
	c0	shru $r0.3 = $r0.2, $r0.6
;;
	c0	and $r0.7 = $r0.3, 2047
;;
	c0	cmpne $b0.0 = $r0.7, 2047
	c0	and $r0.8 = $r0.2, 1048575
;;
	c0	shru $r0.3 = $r0.2, $r0.5
;;
	c0	br $b0.0, LBB54_8
;;
## BB#1:                                ## %if.then
	c0	or $r0.7 = $r0.8, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB54_7
;;
## BB#2:                                ## %if.then.4
	c0	and $r0.7 = $r0.2, 2146959360
;;
	c0	xor $r0.7 = $r0.7, 2146435072
;;
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB54_6
;;
## BB#3:                                ## %land.rhs.i.i
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB54_5
;;
## BB#4:                                ## %land.rhs.i.i
	c0	and $r0.7 = $r0.2, 524287
;;
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB54_6
;;
LBB54_5:                                ## %if.then.i
	c0	mov $r0.7 = float_exception_flags
;;
	c0	ldb $r0.8 = 0[$r0.7]
;;
;;
	c0	or $r0.8 = $r0.8, 1
;;
	c0	stb 0[$r0.7] = $r0.8
;;
LBB54_6:                                ## %float64ToCommonNaN.exit
	c0	mov $r0.7 = 12
	c0	shru $r0.4 = $r0.4, $r0.6
	c0	mov $r0.6 = 9
	c0	shl $r0.3 = $r0.3, $r0.5
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	shru $r0.2 = $r0.2, $r0.6
;;
	c0	or $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.3 = $r0.2, 2143289344
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB54_8:                                ## %if.end.8
	c0	and $r0.2 = $r0.4, 4194303
	c0	mov $r0.5 = 22
	c0	mov $r0.6 = 10
;;
	c0	cmpeq $b0.0 = $r0.7, 0
	c0	cmpne $b0.1 = $r0.2, 0
	c0	shru $r0.2 = $r0.4, $r0.5
	c0	shl $r0.5 = $r0.8, $r0.6
;;
	c0	add $r0.4 = $r0.7, -897
;;
	c0	mfb $r0.6 = $b0.1
	c0	or $r0.2 = $r0.5, $r0.2
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	or $r0.5 = $r0.2, 1073741824
;;
	c0	slct $r0.5 = $b0.0, $r0.2, $r0.5
;;
.call roundAndPackFloat32, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32), ret($r0.3:u32)
	c0	call $l0.0 = roundAndPackFloat32
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB54_7:                                ## %if.end
	c0	shl $r0.2 = $r0.3, $r0.5
;;
	c0	or $r0.3 = $r0.2, 2139095040
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float64_round_to_int
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_round_to_int
float64_round_to_int::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
;;
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	and $r0.2 = $r0.2, 2047
;;
	c0	cmpltu $b0.0 = $r0.2, 1043
;;
;;
	c0	br $b0.0, LBB55_15
;;
## BB#1:                                ## %if.then
	c0	cmpltu $b0.0 = $r0.2, 1075
;;
;;
	c0	br $b0.0, LBB55_5
;;
## BB#2:                                ## %if.then.2
	c0	cmpne $b0.0 = $r0.2, 2047
;;
;;
	c0	br $b0.0, LBB55_36
;;
## BB#3:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB55_36
;;
## BB#4:                                ## %if.then.6
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.6 = $r0.4
;;
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB55_15:                               ## %if.else.62
	c0	cmpgtu $b0.0 = $r0.2, 1022
;;
;;
	c0	br $b0.0, LBB55_26
;;
## BB#16:                               ## %if.then.65
	c0	add $r0.5 = $r0.3, $r0.3
;;
	c0	or $r0.5 = $r0.5, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB55_36
;;
## BB#17:                               ## %if.end.73
	c0	mov $r0.8 = float_exception_flags
	c0	mov $r0.5 = float_rounding_mode
;;
	c0	ldb $r0.9 = 0[$r0.8]
;;
	c0	ldb $r0.7 = 0[$r0.5]
	c0	mov $r0.6 = 31
;;
	c0	shru $r0.5 = $r0.3, $r0.6
	c0	or $r0.9 = $r0.9, 32
;;
	c0	cmpeq $b0.0 = $r0.7, 2
	c0	stb 0[$r0.8] = $r0.9
;;
;;
	c0	br $b0.0, LBB55_24
;;
## BB#18:                               ## %if.end.73
	c0	cmpeq $b0.0 = $r0.7, 1
;;
;;
	c0	brf $b0.0, LBB55_19
;;
## BB#23:                               ## %sw.bb.89
	c0	cmpeq $b0.0 = $r0.5, 0
	c0	mov $r0.4 = 0
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.4, -1074790400
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB55_5:                                ## %if.end.8
	c0	mov $r0.7 = float_rounding_mode
	c0	mov $r0.8 = 1074
;;
	c0	mov $r0.10 = 2
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	sub $r0.8 = $r0.8, $r0.2
;;
	c0	ldbu $r0.9 = 0[$r0.7]
	c0	shl $r0.2 = $r0.10, $r0.8
;;
;;
	c0	cmpeq $b0.0 = $r0.9, 3
;;
;;
	c0	br $b0.0, LBB55_14
;;
## BB#6:                                ## %if.end.8
	c0	cmpne $b0.0 = $r0.9, 0
	c0	add $r0.7 = $r0.2, -1
;;
;;
	c0	br $b0.0, LBB55_12
;;
## BB#7:                                ## %if.then.13
	c0	cmpgtu $b0.0 = $r0.8, 30
;;
;;
	c0	br $b0.0, LBB55_10
;;
## BB#8:                                ## %if.then.15
	c0	mov $r0.5 = 1
;;
	c0	shru $r0.5 = $r0.2, $r0.5
;;
	c0	add $r0.6 = $r0.5, $r0.4
;;
	c0	and $r0.7 = $r0.6, $r0.7
	c0	cmpltu $r0.5 = $r0.6, $r0.5
;;
	c0	cmpne $b0.0 = $r0.7, 0
	c0	add $r0.5 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB55_14
;;
## BB#9:                                ## %if.then.21
	c0	andc $r0.6 = $r0.2, $r0.6
	c0	goto LBB55_14
;;
LBB55_26:                               ## %if.end.103
	c0	mov $r0.6 = float_rounding_mode
	c0	mov $r0.8 = 1043
;;
	c0	mov $r0.7 = 1
	c0	mov $r0.5 = $r0.3
	c0	sub $r0.2 = $r0.8, $r0.2
	c0	ldbu $r0.8 = 0[$r0.6]
;;
	c0	shl $r0.2 = $r0.7, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.8, 3
;;
;;
	c0	br $b0.0, LBB55_32
;;
## BB#27:                               ## %if.end.103
	c0	cmpne $b0.0 = $r0.8, 0
	c0	add $r0.6 = $r0.2, -1
;;
;;
	c0	br $b0.0, LBB55_30
;;
## BB#28:                               ## %if.then.113
	c0	shru $r0.5 = $r0.2, $r0.7
;;
	c0	add $r0.5 = $r0.5, $r0.3
;;
	c0	and $r0.6 = $r0.5, $r0.6
;;
	c0	or $r0.6 = $r0.6, $r0.4
;;
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB55_32
;;
## BB#29:                               ## %if.then.122
	c0	andc $r0.5 = $r0.2, $r0.5
	c0	goto LBB55_32
;;
LBB55_12:                               ## %if.then.44
	c0	cmpeq $b0.0 = $r0.9, 2
	c0	mov $r0.8 = 31
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.5 = $r0.3
;;
	c0	shru $r0.8 = $r0.3, $r0.8
;;
	c0	mfb $r0.9 = $b0.0
;;
	c0	cmpeq $b0.0 = $r0.8, $r0.9
;;
;;
	c0	br $b0.0, LBB55_14
;;
## BB#13:                               ## %if.then.51
	c0	add $r0.6 = $r0.7, $r0.4
;;
	c0	cmpltu $r0.5 = $r0.6, $r0.7
;;
	c0	add $r0.5 = $r0.5, $r0.3
	c0	goto LBB55_14
;;
LBB55_30:                               ## %if.then.131
	c0	cmpeq $b0.0 = $r0.8, 2
	c0	mov $r0.7 = 31
	c0	mov $r0.5 = $r0.3
;;
	c0	shru $r0.7 = $r0.3, $r0.7
;;
	c0	mfb $r0.8 = $b0.0
;;
	c0	cmpeq $b0.0 = $r0.7, $r0.8
;;
;;
	c0	br $b0.0, LBB55_32
;;
## BB#31:                               ## %if.then.139
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	mfb $r0.5 = $b0.0
;;
	c0	or $r0.5 = $r0.5, $r0.3
;;
	c0	add $r0.5 = $r0.6, $r0.5
;;
LBB55_32:                               ## %if.end.149
	c0	mov $r0.6 = 0
;;
	c0	sub $r0.2 = $r0.6, $r0.2
;;
	c0	and $r0.5 = $r0.5, $r0.2
	c0	goto LBB55_33
;;
LBB55_24:                               ## %sw.bb.94
	c0	cmpeq $b0.0 = $r0.5, 0
	c0	mov $r0.2 = 1072693248
	c0	mov $r0.4 = 0
;;
;;
	c0	slct $r0.3 = $b0.0, $r0.2, -2147483648
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB55_19:                               ## %if.end.73
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB55_25
;;
## BB#20:                               ## %sw.bb
	c0	cmpne $b0.0 = $r0.2, 1022
;;
;;
	c0	br $b0.0, LBB55_25
;;
## BB#21:                               ## %land.lhs.true.81
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB55_25
;;
## BB#22:                               ## %if.then.86
	c0	shl $r0.2 = $r0.5, $r0.6
	c0	mov $r0.4 = 0
;;
	c0	or $r0.3 = $r0.2, 1072693248
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB55_25:                               ## %sw.epilog
	c0	mov $r0.4 = 0
	c0	shl $r0.3 = $r0.5, $r0.6
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB55_10:                               ## %if.else
	c0	cmpgt $b0.0 = $r0.4, -1
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.5 = $r0.3
;;
;;
	c0	br $b0.0, LBB55_14
;;
## BB#11:                               ## %if.then.28
	c0	and $r0.5 = $r0.4, 2147483647
	c0	add $r0.7 = $r0.3, 1
	c0	mov $r0.6 = $r0.4
;;
	c0	and $r0.8 = $r0.7, -2
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	slct $r0.5 = $b0.0, $r0.8, $r0.7
;;
LBB55_14:                               ## %if.end.58
	c0	mov $r0.7 = 0
;;
	c0	sub $r0.2 = $r0.7, $r0.2
;;
	c0	and $r0.6 = $r0.6, $r0.2
;;
LBB55_33:                               ## %if.end.153
	c0	cmpne $b0.0 = $r0.6, $r0.4
;;
;;
	c0	br $b0.0, LBB55_35
;;
## BB#34:                               ## %if.end.153
	c0	cmpeq $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB55_36
;;
LBB55_35:                               ## %if.then.162
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.7 = 0[$r0.2]
	c0	mov $r0.3 = $r0.5
	c0	mov $r0.4 = $r0.6
;;
;;
	c0	or $r0.5 = $r0.7, 32
;;
	c0	stb 0[$r0.2] = $r0.5
;;
LBB55_36:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @propagateFloat64NaN
propagateFloat64NaN::
## BB#0:                                ## %entry
	c0	mov $r0.2 = 0
	c0	add $r0.7 = $r0.3, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.7, -2097152
	c0	mov $r0.7 = $r0.2
;;
;;
	c0	br $b0.0, LBB56_4
;;
## BB#1:                                ## %land.rhs.i
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB56_3
;;
## BB#2:
	c0	mov $r0.7 = 1
	c0	goto LBB56_4
;;
LBB56_3:                                ## %lor.rhs.i
	c0	and $r0.7 = $r0.3, 1048575
;;
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	mfb $r0.7 = $b0.0
;;
LBB56_4:                                ## %float64_is_nan.exit
	c0	and $r0.8 = $r0.3, 2146959360
;;
	c0	xor $r0.8 = $r0.8, 2146435072
;;
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB56_8
;;
## BB#5:                                ## %land.rhs.i.146
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB56_7
;;
## BB#6:
	c0	mov $r0.2 = 1
	c0	goto LBB56_8
;;
LBB56_7:                                ## %lor.rhs.i.150
	c0	and $r0.2 = $r0.3, 524287
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
LBB56_8:                                ## %float64_is_signaling_nan.exit151
	c0	add $r0.9 = $r0.5, $r0.5
	c0	mov $r0.8 = 0
;;
	c0	cmpltu $b0.0 = $r0.9, -2097152
	c0	mov $r0.9 = $r0.8
;;
;;
	c0	br $b0.0, LBB56_12
;;
## BB#9:                                ## %land.rhs.i.136
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB56_11
;;
## BB#10:
	c0	mov $r0.9 = 1
	c0	goto LBB56_12
;;
LBB56_11:                               ## %lor.rhs.i.140
	c0	and $r0.9 = $r0.5, 1048575
;;
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	mfb $r0.9 = $b0.0
;;
LBB56_12:                               ## %float64_is_nan.exit141
	c0	and $r0.10 = $r0.5, 2146959360
;;
	c0	xor $r0.10 = $r0.10, 2146435072
;;
	c0	cmpne $b0.0 = $r0.10, 0
;;
;;
	c0	br $b0.0, LBB56_16
;;
## BB#13:                               ## %land.rhs.i.127
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	brf $b0.0, LBB56_15
;;
## BB#14:
	c0	mov $r0.8 = 1
	c0	goto LBB56_16
;;
LBB56_15:                               ## %lor.rhs.i.129
	c0	and $r0.8 = $r0.5, 524287
;;
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	mfb $r0.8 = $b0.0
;;
LBB56_16:                               ## %float64_is_signaling_nan.exit
	c0	or $r0.10 = $r0.8, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.10, 0
;;
;;
	c0	br $b0.0, LBB56_18
;;
## BB#17:                               ## %if.then
	c0	mov $r0.10 = float_exception_flags
;;
	c0	ldb $r0.11 = 0[$r0.10]
;;
;;
	c0	or $r0.11 = $r0.11, 1
;;
	c0	stb 0[$r0.10] = $r0.11
;;
LBB56_18:                               ## %if.end
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.5, 524288
;;
	c0	or $r0.3 = $r0.3, 524288
;;
;;
	c0	br $b0.0, LBB56_21
;;
## BB#19:                               ## %if.then.9
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB56_24
;;
## BB#20:                               ## %if.end.12
	c0	cmpeq $b0.0 = $r0.9, 0
	c0	goto LBB56_30
;;
LBB56_21:                               ## %if.else
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB56_31
;;
## BB#22:                               ## %if.then.16
	c0	xor $r0.5 = $r0.9, 1
;;
	c0	or $r0.5 = $r0.8, $r0.5
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB56_23
;;
LBB56_24:                               ## %returnLargerSignificand
	c0	mov $r0.7 = 1
;;
	c0	shl $r0.5 = $r0.2, $r0.7
	c0	shl $r0.7 = $r0.3, $r0.7
;;
	c0	cmpltu $b0.0 = $r0.7, $r0.5
;;
;;
	c0	br $b0.0, LBB56_31
;;
## BB#25:                               ## %lor.rhs.i.118
	c0	cmpgeu $b0.0 = $r0.4, $r0.6
;;
;;
	c0	br $b0.0, LBB56_27
;;
## BB#26:                               ## %lor.rhs.i.118
	c0	cmpeq $b0.0 = $r0.7, $r0.5
;;
;;
	c0	br $b0.0, LBB56_31
;;
LBB56_27:                               ## %if.end.30
	c0	cmpltu $b0.0 = $r0.5, $r0.7
;;
;;
	c0	br $b0.0, LBB56_23
;;
## BB#28:                               ## %if.end.30
	c0	cmpeq $b0.0 = $r0.7, $r0.5
	c0	cmpltu $b0.1 = $r0.6, $r0.4
;;
;;
	c0	mfb $r0.5 = $b0.0
	c0	mfb $r0.7 = $b0.1
;;
	c0	and $r0.5 = $r0.7, $r0.5
;;
	c0	mtb $b0.0 = $r0.5
;;
;;
	c0	br $b0.0, LBB56_23
;;
## BB#29:                               ## %if.end.40
	c0	cmpltu $b0.0 = $r0.3, $r0.2
;;
LBB56_30:                               ## %cleanup
	c0	slct $r0.2 = $b0.0, $r0.3, $r0.2
	c0	slct $r0.6 = $b0.0, $r0.4, $r0.6
	c0	goto LBB56_31
;;
LBB56_23:
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.6 = $r0.4
;;
LBB56_31:                               ## %cleanup
.return ret($r0.3:u32,$r0.4:u32)
	c0	mov $r0.3 = $r0.2
	c0	mov $r0.4 = $r0.6
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_add
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_add
float64_add::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.8 = $r0.5, $r0.2
	c0	shru $r0.7 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.7, $r0.8
;;
;;
	c0	br $b0.0, LBB57_2
;;
## BB#1:                                ## %if.then
.call addFloat64Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = addFloat64Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB57_2:                                ## %if.else
.call subFloat64Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = subFloat64Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @addFloat64Sigs
addFloat64Sigs::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
	c0	and $r0.9 = $r0.5, 1048575
;;
	c0	shru $r0.8 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	and $r0.11 = $r0.8, 2047
	c0	and $r0.2 = $r0.2, 2047
;;
	c0	sub $r0.12 = $r0.2, $r0.11
;;
	c0	cmplt $b0.0 = $r0.12, 1
	c0	and $r0.10 = $r0.3, 1048575
;;
;;
	c0	br $b0.0, LBB58_16
;;
## BB#1:                                ## %if.then
	c0	cmpne $b0.0 = $r0.2, 2047
;;
;;
	c0	br $b0.0, LBB58_4
;;
## BB#2:                                ## %if.then.7
	c0	or $r0.2 = $r0.10, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB58_42
;;
## BB#3:                                ## %if.then.8
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_16:                               ## %if.else.15
	c0	cmpgt $b0.0 = $r0.12, -1
;;
;;
	c0	brf $b0.0, LBB58_17
;;
## BB#31:                               ## %if.else.33
	c0	cmpne $b0.0 = $r0.2, 2047
;;
;;
	c0	br $b0.0, LBB58_34
;;
## BB#32:                               ## %if.then.35
	c0	or $r0.2 = $r0.6, $r0.4
;;
	c0	or $r0.2 = $r0.2, $r0.10
;;
	c0	or $r0.2 = $r0.2, $r0.9
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB58_42
;;
## BB#33:                               ## %if.then.40
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_4:                                ## %if.end.10
	c0	cmpeq $b0.0 = $r0.11, 0
;;
;;
	c0	br $b0.0, LBB58_6
;;
## BB#5:                                ## %if.end.14.thread
	c0	mov $r0.3 = 0
	c0	or $r0.9 = $r0.9, 1048576
	c0	mov $r0.5 = $r0.12
;;
	c0	goto LBB58_8
;;
LBB58_17:                               ## %if.then.17
	c0	cmpne $b0.0 = $r0.11, 2047
;;
;;
	c0	br $b0.0, LBB58_21
;;
## BB#18:                               ## %if.then.19
	c0	or $r0.2 = $r0.9, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB58_20
;;
## BB#19:                               ## %if.then.22
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_34:                               ## %if.end.43
	c0	add $r0.4 = $r0.6, $r0.4
	c0	cmpne $b0.0 = $r0.2, 0
	c0	add $r0.3 = $r0.9, $r0.10
;;
	c0	cmpltu $r0.5 = $r0.4, $r0.6
;;
	c0	add $r0.3 = $r0.3, $r0.5
	c0	brf $b0.0, LBB58_35
;;
## BB#39:                               ## %if.end.47
	c0	or $r0.5 = $r0.3, 2097152
	c0	mov $r0.8 = 0
	c0	goto LBB58_40
;;
LBB58_6:                                ## %if.end.14
	c0	add $r0.5 = $r0.12, -1
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB58_36
;;
## BB#7:
	c0	mov $r0.3 = 1
;;
LBB58_8:                                ## %if.else.i.131
	c0	sub $r0.3 = $r0.3, $r0.12
	c0	cmpgt $b0.0 = $r0.5, 31
;;
	c0	and $r0.8 = $r0.3, 31
;;
	c0	br $b0.0, LBB58_10
;;
## BB#9:                                ## %if.then.4.i.137
	c0	shru $r0.11 = $r0.6, $r0.5
	c0	shl $r0.12 = $r0.9, $r0.8
	c0	shl $r0.8 = $r0.6, $r0.8
	c0	shru $r0.3 = $r0.9, $r0.5
;;
	c0	mov $r0.6 = 0
	c0	or $r0.9 = $r0.12, $r0.11
	c0	goto LBB58_15
;;
LBB58_10:                               ## %if.else.9.i.139
	c0	cmpeq $b0.0 = $r0.5, 32
	c0	mov $r0.3 = 0
;;
;;
	c0	brf $b0.0, LBB58_12
;;
## BB#11:
	c0	mov $r0.8 = $r0.6
	c0	mov $r0.6 = $r0.3
	c0	goto LBB58_15
;;
LBB58_21:                               ## %if.end.26
	c0	cmpeq $b0.0 = $r0.2, 0
	c0	or $r0.2 = $r0.10, 1048576
	c0	mov $r0.8 = 0
;;
;;
	c0	mfb $r0.3 = $b0.0
	c0	slct $r0.10 = $b0.0, $r0.10, $r0.2
;;
	c0	add $r0.12 = $r0.12, $r0.3
;;
	c0	cmpeq $b0.0 = $r0.12, 0
;;
;;
	c0	br $b0.0, LBB58_22
;;
## BB#23:                               ## %if.else.i
	c0	cmplt $b0.0 = $r0.12, -31
	c0	sub $r0.2 = $r0.8, $r0.12
	c0	and $r0.5 = $r0.12, 31
;;
;;
	c0	br $b0.0, LBB58_25
;;
## BB#24:                               ## %if.then.4.i
	c0	shru $r0.8 = $r0.4, $r0.2
	c0	shl $r0.12 = $r0.10, $r0.5
	c0	shl $r0.5 = $r0.4, $r0.5
	c0	shru $r0.3 = $r0.10, $r0.2
;;
	c0	mov $r0.4 = 0
	c0	or $r0.10 = $r0.12, $r0.8
	c0	goto LBB58_30
;;
LBB58_12:                               ## %if.else.13.i.141
	c0	cmpgt $b0.0 = $r0.5, 63
;;
;;
	c0	br $b0.0, LBB58_14
;;
## BB#13:                               ## %if.then.17.i.145
	c0	and $r0.5 = $r0.5, 31
	c0	shl $r0.8 = $r0.9, $r0.8
;;
	c0	shru $r0.9 = $r0.9, $r0.5
	c0	goto LBB58_15
;;
LBB58_35:                               ## %if.then.45
	c0	mov $r0.2 = 31
;;
	c0	shl $r0.2 = $r0.7, $r0.2
;;
	c0	or $r0.3 = $r0.3, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_36:
	c0	mov $r0.8 = 0
	c0	goto LBB58_37
;;
LBB58_14:                               ## %if.else.22.i.150
	c0	cmpne $b0.0 = $r0.9, 0
	c0	cmpeq $b0.1 = $r0.5, 64
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.5 = $b0.0
;;
	c0	slct $r0.8 = $b0.1, $r0.9, $r0.5
	c0	mov $r0.9 = $r0.3
;;
LBB58_15:                               ## %if.end.28.i.158
	c0	cmpne $b0.0 = $r0.6, 0
	c0	mov $r0.5 = $r0.9
	c0	mov $r0.9 = $r0.3
;;
	c0	mov $r0.6 = $r0.5
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.8 = $r0.3, $r0.8
;;
LBB58_37:                               ## %if.end.50
	c0	add $r0.4 = $r0.6, $r0.4
	c0	or $r0.3 = $r0.10, 1048576
;;
	c0	cmpltu $r0.5 = $r0.4, $r0.6
	c0	add $r0.3 = $r0.9, $r0.3
;;
	c0	add $r0.5 = $r0.3, $r0.5
;;
	c0	cmpltu $b0.0 = $r0.5, 2097152
;;
;;
	c0	brf $b0.0, LBB58_40
;;
## BB#38:
	c0	add $r0.2 = $r0.2, -1
	c0	goto LBB58_41
;;
LBB58_40:                               ## %shiftRight1
	c0	cmpne $b0.0 = $r0.8, 0
	c0	mov $r0.3 = 31
	c0	mov $r0.6 = 1
;;
	c0	shl $r0.8 = $r0.4, $r0.3
	c0	shl $r0.3 = $r0.5, $r0.3
	c0	shru $r0.4 = $r0.4, $r0.6
	c0	shru $r0.5 = $r0.5, $r0.6
;;
	c0	mfb $r0.6 = $b0.0
	c0	or $r0.4 = $r0.4, $r0.3
;;
	c0	or $r0.8 = $r0.6, $r0.8
;;
LBB58_41:                               ## %roundAndPack
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.2
	c0	mov $r0.3 = $r0.7
	c0	mov $r0.7 = $r0.8
;;
.call roundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = roundAndPackFloat64
;;
LBB58_42:                               ## %cleanup
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_20:                               ## %if.end.24
	c0	mov $r0.2 = 31
	c0	mov $r0.4 = 0
;;
	c0	shl $r0.2 = $r0.7, $r0.2
;;
	c0	or $r0.3 = $r0.2, 2146435072
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB58_22:
	c0	mov $r0.2 = $r0.11
	c0	goto LBB58_37
;;
LBB58_25:                               ## %if.else.9.i
	c0	cmpeq $b0.0 = $r0.2, 32
	c0	mov $r0.3 = 0
;;
;;
	c0	brf $b0.0, LBB58_27
;;
## BB#26:
	c0	mov $r0.5 = $r0.4
	c0	mov $r0.4 = $r0.3
	c0	goto LBB58_30
;;
LBB58_27:                               ## %if.else.13.i
	c0	cmplt $b0.0 = $r0.12, -63
;;
;;
	c0	br $b0.0, LBB58_29
;;
## BB#28:                               ## %if.then.17.i
	c0	and $r0.2 = $r0.2, 31
	c0	shl $r0.5 = $r0.10, $r0.5
;;
	c0	shru $r0.10 = $r0.10, $r0.2
	c0	goto LBB58_30
;;
LBB58_29:                               ## %if.else.22.i
	c0	cmpne $b0.0 = $r0.10, 0
	c0	cmpeq $b0.1 = $r0.2, 64
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	slct $r0.5 = $b0.1, $r0.10, $r0.2
	c0	mov $r0.10 = $r0.3
;;
LBB58_30:                               ## %if.end.28.i
	c0	cmpne $b0.0 = $r0.4, 0
	c0	mov $r0.4 = $r0.10
	c0	mov $r0.2 = $r0.11
	c0	mov $r0.10 = $r0.3
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	or $r0.8 = $r0.3, $r0.5
	c0	goto LBB58_37
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @subFloat64Sigs
subFloat64Sigs::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
	c0	mov $r0.8 = 10
;;
	c0	shru $r0.9 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
	c0	shl $r0.10 = $r0.3, $r0.8
	c0	shl $r0.14 = $r0.5, $r0.8
;;
	c0	and $r0.12 = $r0.9, 2047
	c0	and $r0.11 = $r0.2, 2047
;;
	c0	mov $r0.2 = 22
	c0	sub $r0.13 = $r0.11, $r0.12
;;
	c0	cmpgt $b0.0 = $r0.13, 0
	c0	shru $r0.9 = $r0.6, $r0.2
	c0	shru $r0.15 = $r0.4, $r0.2
;;
	c0	and $r0.2 = $r0.14, 1073740800
	c0	and $r0.14 = $r0.10, 1073740800
;;
	c0	shl $r0.10 = $r0.6, $r0.8
	c0	shl $r0.8 = $r0.4, $r0.8
	c0	or $r0.2 = $r0.2, $r0.9
	c0	or $r0.9 = $r0.14, $r0.15
;;
	c0	brf $b0.0, LBB59_1
;;
## BB#28:                               ## %aExpBigger
	c0	cmpne $b0.0 = $r0.11, 2047
;;
;;
	c0	br $b0.0, LBB59_30
;;
## BB#29:                               ## %if.then.60
	c0	or $r0.2 = $r0.9, $r0.8
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB59_5
;;
	c0	goto LBB59_44
;;
LBB59_1:                                ## %if.end
	c0	cmplt $b0.0 = $r0.13, 0
;;
;;
	c0	br $b0.0, LBB59_13
;;
## BB#2:                                ## %if.end.8
	c0	cmpeq $b0.0 = $r0.11, 0
;;
;;
	c0	brf $b0.0, LBB59_3
;;
## BB#7:                                ## %if.then.18
	c0	mov $r0.11 = 1
;;
	c0	mov $r0.12 = $r0.11
	c0	goto LBB59_8
;;
LBB59_30:                               ## %if.end.66
	c0	cmpeq $b0.0 = $r0.12, 0
;;
;;
	c0	br $b0.0, LBB59_32
;;
## BB#31:                               ## %if.end.72.thread
	c0	mov $r0.4 = 0
	c0	or $r0.2 = $r0.2, 1073741824
	c0	mov $r0.3 = $r0.13
;;
	c0	goto LBB59_34
;;
LBB59_13:                               ## %bExpBigger
	c0	cmpne $b0.0 = $r0.12, 2047
;;
;;
	c0	br $b0.0, LBB59_16
;;
## BB#14:                               ## %if.then.38
	c0	or $r0.2 = $r0.2, $r0.10
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB59_5
;;
## BB#15:                               ## %if.end.43
	c0	mov $r0.3 = 31
	c0	mov $r0.2 = 0
;;
	c0	shl $r0.3 = $r0.7, $r0.3
	c0	mov $r0.4 = $r0.2
;;
	c0	add $r0.3 = $r0.3, -1048576
	c0	goto LBB59_45
;;
LBB59_3:                                ## %if.end.8
	c0	cmpne $b0.0 = $r0.11, 2047
;;
;;
	c0	br $b0.0, LBB59_8
;;
## BB#4:                                ## %if.then.10
	c0	or $r0.7 = $r0.10, $r0.8
;;
	c0	or $r0.7 = $r0.7, $r0.9
;;
	c0	or $r0.2 = $r0.7, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB59_6
;;
LBB59_5:                                ## %if.then.13
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	goto LBB59_44
;;
LBB59_8:                                ## %if.end.19
	c0	cmpltu $b0.0 = $r0.2, $r0.9
;;
;;
	c0	br $b0.0, LBB59_42
;;
## BB#9:                                ## %if.end.22
	c0	cmpltu $b0.0 = $r0.9, $r0.2
;;
;;
	c0	br $b0.0, LBB59_27
;;
## BB#10:                               ## %if.end.25
	c0	cmpltu $b0.0 = $r0.10, $r0.8
;;
;;
	c0	br $b0.0, LBB59_42
;;
## BB#11:                               ## %if.end.28
	c0	cmpltu $b0.0 = $r0.8, $r0.10
;;
;;
	c0	br $b0.0, LBB59_27
;;
## BB#12:                               ## %if.end.31
	c0	mov $r0.2 = float_rounding_mode
;;
	c0	ldbu $r0.3 = 0[$r0.2]
	c0	mov $r0.5 = 31
	c0	mov $r0.2 = 0
;;
	c0	mov $r0.4 = $r0.2
;;
	c0	cmpeq $b0.0 = $r0.3, 1
;;
;;
	c0	mfb $r0.3 = $b0.0
;;
	c0	shl $r0.3 = $r0.3, $r0.5
	c0	goto LBB59_45
;;
LBB59_32:                               ## %if.end.72
	c0	add $r0.3 = $r0.13, -1
;;
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	br $b0.0, LBB59_41
;;
## BB#33:
	c0	mov $r0.4 = 1
;;
LBB59_34:                               ## %if.else.i
	c0	sub $r0.4 = $r0.4, $r0.13
	c0	cmpgt $b0.0 = $r0.3, 31
;;
	c0	and $r0.4 = $r0.4, 31
;;
	c0	br $b0.0, LBB59_36
;;
## BB#35:                               ## %if.then.4.i
	c0	shl $r0.5 = $r0.10, $r0.4
	c0	shl $r0.4 = $r0.2, $r0.4
	c0	shru $r0.6 = $r0.10, $r0.3
	c0	shru $r0.2 = $r0.2, $r0.3
;;
	c0	cmpne $b0.0 = $r0.5, 0
	c0	or $r0.3 = $r0.4, $r0.6
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.10 = $r0.3, $r0.4
	c0	goto LBB59_41
;;
LBB59_36:                               ## %if.else.12.i
	c0	cmpne $b0.0 = $r0.3, 32
;;
;;
	c0	br $b0.0, LBB59_38
;;
## BB#37:                               ## %if.then.15.i
	c0	cmpne $b0.0 = $r0.10, 0
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.10 = $r0.2, $r0.4
	c0	mov $r0.2 = $r0.3
	c0	goto LBB59_41
;;
LBB59_16:                               ## %if.end.47
	c0	cmpeq $b0.0 = $r0.11, 0
	c0	or $r0.3 = $r0.9, 1073741824
;;
;;
	c0	mfb $r0.4 = $b0.0
	c0	slct $r0.3 = $b0.0, $r0.9, $r0.3
;;
	c0	add $r0.6 = $r0.13, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB59_17
;;
## BB#18:                               ## %if.else.i.154
	c0	mov $r0.9 = 0
	c0	cmplt $b0.0 = $r0.6, -31
	c0	and $r0.5 = $r0.6, 31
;;
	c0	sub $r0.4 = $r0.9, $r0.6
;;
	c0	br $b0.0, LBB59_20
;;
## BB#19:                               ## %if.then.4.i.163
	c0	shl $r0.6 = $r0.8, $r0.5
	c0	shl $r0.5 = $r0.3, $r0.5
	c0	shru $r0.8 = $r0.8, $r0.4
	c0	shru $r0.9 = $r0.3, $r0.4
;;
	c0	cmpne $b0.0 = $r0.6, 0
	c0	or $r0.3 = $r0.5, $r0.8
	c0	goto LBB59_22
;;
LBB59_38:                               ## %if.else.19.i
	c0	cmpgt $b0.0 = $r0.3, 63
;;
;;
	c0	br $b0.0, LBB59_40
;;
## BB#39:                               ## %if.then.22.i
	c0	shl $r0.4 = $r0.2, $r0.4
	c0	and $r0.3 = $r0.3, 31
	c0	mov $r0.5 = 0
;;
	c0	shru $r0.3 = $r0.2, $r0.3
	c0	or $r0.4 = $r0.4, $r0.10
	c0	mov $r0.2 = $r0.5
;;
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.10 = $r0.4, $r0.3
	c0	goto LBB59_41
;;
LBB59_40:                               ## %if.else.31.i
	c0	or $r0.3 = $r0.2, $r0.10
	c0	mov $r0.2 = 0
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.10 = $b0.0
;;
LBB59_41:                               ## %shift64RightJamming.exit
	c0	or $r0.9 = $r0.9, 1073741824
;;
LBB59_42:                               ## %aBigger
	c0	cmpltu $r0.3 = $r0.8, $r0.10
	c0	mov $r0.4 = -1
	c0	sub $r0.2 = $r0.9, $r0.2
	c0	sub $r0.6 = $r0.8, $r0.10
;;
	c0	mov $r0.12 = $r0.11
	c0	mtb $b0.0 = $r0.3
	c0	goto LBB59_43
;;
LBB59_17:
	c0	mov $r0.9 = $r0.3
	c0	goto LBB59_26
;;
LBB59_6:                                ## %if.end.15
	c0	mov $r0.5 = float_exception_flags
	c0	mov $r0.2 = 0
;;
	c0	ldb $r0.6 = 0[$r0.5]
	c0	mov $r0.3 = -524288
	c0	mov $r0.4 = $r0.2
;;
;;
	c0	or $r0.6 = $r0.6, 1
;;
	c0	stb 0[$r0.5] = $r0.6
	c0	goto LBB59_45
;;
LBB59_20:                               ## %if.else.12.i.165
	c0	cmpne $b0.0 = $r0.4, 32
;;
;;
	c0	br $b0.0, LBB59_23
;;
## BB#21:                               ## %if.then.15.i.169
	c0	cmpne $b0.0 = $r0.8, 0
;;
LBB59_22:                               ## %shift64RightJamming.exit186
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.8 = $r0.3, $r0.4
;;
LBB59_26:                               ## %shift64RightJamming.exit186
	c0	or $r0.2 = $r0.2, 1073741824
;;
LBB59_27:                               ## %bBigger
	c0	cmpltu $r0.3 = $r0.10, $r0.8
	c0	mov $r0.4 = -1
	c0	zxtb $r0.5 = $r0.7
	c0	sub $r0.2 = $r0.2, $r0.9
;;
	c0	sub $r0.6 = $r0.10, $r0.8
	c0	mtb $b0.0 = $r0.3
	c0	xor $r0.7 = $r0.5, 1
;;
LBB59_43:                               ## %normalizeRoundAndPack
	c0	slct $r0.3 = $b0.0, $r0.4, 0
;;
	c0	add $r0.5 = $r0.2, $r0.3
	c0	add $r0.4 = $r0.12, -11
	c0	sxtb $r0.3 = $r0.7
;;
.call normalizeRoundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = normalizeRoundAndPackFloat64
;;
LBB59_44:                               ## %cleanup
	c0	mov $r0.2 = 0
;;
LBB59_45:                               ## %cleanup
	c0	or $r0.4 = $r0.4, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB59_23:                               ## %if.else.19.i.171
	c0	cmplt $b0.0 = $r0.6, -63
;;
;;
	c0	br $b0.0, LBB59_25
;;
## BB#24:                               ## %if.then.22.i.179
	c0	shl $r0.5 = $r0.3, $r0.5
	c0	and $r0.4 = $r0.4, 31
;;
	c0	or $r0.5 = $r0.5, $r0.8
	c0	shru $r0.3 = $r0.3, $r0.4
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	or $r0.8 = $r0.4, $r0.3
	c0	goto LBB59_26
;;
LBB59_25:                               ## %if.else.31.i.183
	c0	or $r0.3 = $r0.3, $r0.8
;;
	c0	cmpne $b0.0 = $r0.3, 0
;;
;;
	c0	mfb $r0.8 = $b0.0
	c0	goto LBB59_26
;;
.endp

#.globl float64_sub
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_sub
float64_sub::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.8 = $r0.5, $r0.2
	c0	shru $r0.7 = $r0.3, $r0.2
;;
	c0	cmpne $b0.0 = $r0.7, $r0.8
;;
;;
	c0	br $b0.0, LBB60_2
;;
## BB#1:                                ## %if.then
.call subFloat64Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = subFloat64Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
LBB60_2:                                ## %if.else
.call addFloat64Sigs, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = addFloat64Sigs
;;
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float64_mul
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_mul
float64_mul::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.10 = 20
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.8 = 31
;;
	c0	shru $r0.3 = $r0.2, $r0.10
	c0	xor $r0.7 = $r0.5, $r0.2
	c0	shru $r0.13 = $r0.5, $r0.10
;;
	c0	and $r0.9 = $r0.3, 2047
;;
	c0	cmpne $b0.0 = $r0.9, 2047
	c0	and $r0.11 = $r0.2, 1048575
;;
	c0	and $r0.12 = $r0.5, 1048575
	c0	shru $r0.3 = $r0.7, $r0.8
;;
	c0	and $r0.7 = $r0.13, 2047
;;
	c0	br $b0.0, LBB61_7
;;
## BB#1:                                ## %if.then
	c0	or $r0.9 = $r0.11, $r0.4
;;
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB61_4
;;
## BB#2:                                ## %lor.lhs.false
	c0	cmpne $b0.0 = $r0.7, 2047
	c0	or $r0.9 = $r0.12, $r0.6
;;
;;
	c0	br $b0.0, LBB61_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	brf $b0.0, LBB61_4
;;
LBB61_5:                                ## %if.end
	c0	or $r0.2 = $r0.9, $r0.7
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB61_6
;;
	c0	goto LBB61_10
;;
LBB61_7:                                ## %if.end.24
	c0	cmpne $b0.0 = $r0.7, 2047
;;
;;
	c0	br $b0.0, LBB61_11
;;
## BB#8:                                ## %if.then.27
	c0	or $r0.7 = $r0.12, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB61_9
;;
LBB61_4:                                ## %if.then.15
	c0	mov $r0.3 = $r0.2
;;
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	goto LBB61_46
;;
LBB61_11:                               ## %if.end.40
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB61_27
;;
## BB#12:                               ## %if.then.43
	c0	or $r0.9 = $r0.11, $r0.4
;;
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	brf $b0.0, LBB61_13
;;
## BB#14:                               ## %if.end.49
	c0	cmpne $b0.0 = $r0.11, 0
;;
;;
	c0	brf $b0.0, LBB61_15
;;
## BB#21:                               ## %if.else.14.i.174
	c0	cmpltu $b0.0 = $r0.11, 65536
	c0	mov $r0.9 = 16
	c0	mov $r0.13 = 4
;;
	c0	shl $r0.2 = $r0.2, $r0.9
;;
	c0	mfb $r0.9 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.11
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.9 = $r0.9, $r0.13
;;
;;
	c0	br $b0.0, LBB61_23
;;
## BB#22:                               ## %if.then.4.i.54.i.179
	c0	or $r0.9 = $r0.9, 8
	c0	mov $r0.13 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.13
	c0	zxtb $r0.9 = $r0.9
;;
LBB61_23:                               ## %countLeadingZeros32.exit64.i.193
	c0	mov $r0.13 = 24
	c0	mov $r0.14 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.13
;;
	c0	add $r0.2 = $r0.14, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.9
;;
	c0	shl $r0.2 = $r0.2, $r0.13
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	shr $r0.2 = $r0.2, $r0.13
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB61_25
;;
## BB#24:                               ## %cond.false.i.i.199
	c0	mov $r0.9 = 0
	c0	shl $r0.11 = $r0.11, $r0.2
;;
	c0	sub $r0.9 = $r0.9, $r0.2
;;
	c0	and $r0.9 = $r0.9, 31
;;
	c0	shru $r0.9 = $r0.4, $r0.9
;;
	c0	or $r0.11 = $r0.9, $r0.11
;;
LBB61_25:                               ## %shortShift64Left.exit.i.202
	c0	mov $r0.9 = 1
	c0	shl $r0.4 = $r0.4, $r0.2
	c0	goto LBB61_26
;;
LBB61_9:                                ## %if.end.32
	c0	or $r0.2 = $r0.11, $r0.4
;;
	c0	or $r0.2 = $r0.2, $r0.9
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB61_10
;;
LBB61_6:                                ## %if.end.22
	c0	shl $r0.3 = $r0.3, $r0.8
	c0	mov $r0.2 = 0
;;
	c0	or $r0.3 = $r0.3, 2146435072
	c0	mov $r0.4 = $r0.2
	c0	goto LBB61_47
;;
LBB61_10:                               ## %invalid
	c0	mov $r0.5 = float_exception_flags
	c0	mov $r0.2 = 0
;;
	c0	ldb $r0.6 = 0[$r0.5]
	c0	mov $r0.3 = -524288
	c0	mov $r0.4 = $r0.2
;;
;;
	c0	or $r0.6 = $r0.6, 1
;;
	c0	stb 0[$r0.5] = $r0.6
	c0	goto LBB61_47
;;
LBB61_15:                               ## %if.then.i.140
	c0	mov $r0.2 = 16
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.9 = 4
;;
	c0	shl $r0.2 = $r0.4, $r0.2
;;
	c0	mfb $r0.11 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.9 = $r0.11, $r0.9
;;
;;
	c0	br $b0.0, LBB61_17
;;
## BB#16:                               ## %if.then.4.i.i.145
	c0	or $r0.9 = $r0.9, 8
	c0	mov $r0.11 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.11
	c0	zxtb $r0.9 = $r0.9
;;
LBB61_17:                               ## %countLeadingZeros32.exit.i.158
	c0	mov $r0.11 = 24
	c0	mov $r0.13 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.11
;;
	c0	add $r0.2 = $r0.13, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.9
;;
	c0	shl $r0.2 = $r0.2, $r0.11
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	cmpgt $b0.0 = $r0.2, -1
	c0	shr $r0.2 = $r0.2, $r0.11
	c0	mov $r0.9 = 0
;;
;;
	c0	brf $b0.0, LBB61_18
;;
## BB#19:                               ## %if.else.i.165
	c0	shl $r0.11 = $r0.4, $r0.2
	c0	mov $r0.4 = $r0.9
	c0	mov $r0.9 = -31
	c0	goto LBB61_26
;;
LBB61_18:                               ## %if.then.5.i.163
	c0	and $r0.11 = $r0.2, 31
	c0	sub $r0.9 = $r0.9, $r0.2
;;
	c0	shl $r0.13 = $r0.4, $r0.11
	c0	shru $r0.11 = $r0.4, $r0.9
;;
	c0	mov $r0.4 = $r0.13
	c0	mov $r0.9 = -31
;;
LBB61_26:                               ## %if.end.50
	c0	sub $r0.9 = $r0.9, $r0.2
;;
LBB61_27:                               ## %if.end.50
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB61_42
;;
## BB#28:                               ## %if.then.53
	c0	or $r0.2 = $r0.12, $r0.6
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB61_13
;;
## BB#29:                               ## %if.end.59
	c0	cmpne $b0.0 = $r0.12, 0
;;
;;
	c0	brf $b0.0, LBB61_30
;;
## BB#36:                               ## %if.else.14.i
	c0	cmpltu $b0.0 = $r0.12, 65536
	c0	mov $r0.2 = 16
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.2 = $r0.5, $r0.2
;;
	c0	mfb $r0.5 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.12
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.5 = $r0.5, $r0.7
;;
;;
	c0	br $b0.0, LBB61_38
;;
## BB#37:                               ## %if.then.4.i.54.i
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.7
	c0	zxtb $r0.5 = $r0.5
;;
LBB61_38:                               ## %countLeadingZeros32.exit64.i
	c0	mov $r0.7 = 24
	c0	mov $r0.13 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.13, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	shr $r0.2 = $r0.2, $r0.7
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB61_40
;;
## BB#39:                               ## %cond.false.i.i
	c0	mov $r0.5 = 0
	c0	shl $r0.7 = $r0.12, $r0.2
;;
	c0	sub $r0.5 = $r0.5, $r0.2
;;
	c0	and $r0.5 = $r0.5, 31
;;
	c0	shru $r0.5 = $r0.6, $r0.5
;;
	c0	or $r0.12 = $r0.5, $r0.7
;;
LBB61_40:                               ## %shortShift64Left.exit.i
	c0	mov $r0.5 = 1
	c0	shl $r0.6 = $r0.6, $r0.2
	c0	goto LBB61_41
;;
LBB61_13:                               ## %if.then.47
	c0	mov $r0.2 = 0
	c0	shl $r0.3 = $r0.3, $r0.8
;;
	c0	mov $r0.4 = $r0.2
	c0	goto LBB61_47
;;
LBB61_30:                               ## %if.then.i
	c0	mov $r0.2 = 16
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.5 = 4
;;
	c0	shl $r0.2 = $r0.6, $r0.2
;;
	c0	mfb $r0.7 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.5 = $r0.7, $r0.5
;;
;;
	c0	br $b0.0, LBB61_32
;;
## BB#31:                               ## %if.then.4.i.i
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.7
	c0	zxtb $r0.5 = $r0.5
;;
LBB61_32:                               ## %countLeadingZeros32.exit.i
	c0	mov $r0.7 = 24
	c0	mov $r0.12 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.12, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	cmpgt $b0.0 = $r0.2, -1
	c0	shr $r0.2 = $r0.2, $r0.7
	c0	mov $r0.5 = 0
;;
;;
	c0	brf $b0.0, LBB61_33
;;
## BB#34:                               ## %if.else.i
	c0	shl $r0.12 = $r0.6, $r0.2
	c0	mov $r0.6 = $r0.5
	c0	mov $r0.5 = -31
	c0	goto LBB61_41
;;
LBB61_33:                               ## %if.then.5.i
	c0	and $r0.7 = $r0.2, 31
	c0	sub $r0.5 = $r0.5, $r0.2
;;
	c0	shl $r0.7 = $r0.6, $r0.7
	c0	shru $r0.12 = $r0.6, $r0.5
;;
	c0	mov $r0.6 = $r0.7
	c0	mov $r0.5 = -31
;;
LBB61_41:                               ## %if.end.60
	c0	sub $r0.7 = $r0.5, $r0.2
;;
LBB61_42:                               ## %if.end.60
	c0	mov $r0.5 = 12
	c0	mov $r0.13 = 4
	c0	mov $r0.2 = 16
	c0	shru $r0.10 = $r0.6, $r0.10
;;
	c0	shl $r0.14 = $r0.12, $r0.5
	c0	shru $r0.15 = $r0.6, $r0.13
	c0	shru $r0.12 = $r0.12, $r0.13
	c0	shl $r0.5 = $r0.6, $r0.5
;;
	c0	zxth $r0.6 = $r0.14
	c0	zxth $r0.5 = $r0.5
	c0	shru $r0.13 = $r0.4, $r0.2
	c0	zxth $r0.12 = $r0.12
;;
	c0	zxth $r0.14 = $r0.4
	c0	or $r0.6 = $r0.10, $r0.6
	c0	zxth $r0.10 = $r0.15
	c0	zxth $r0.15 = $r0.11
;;
	c0	mpylu $r0.16 = $r0.12, $r0.14
	c0	mpyhs $r0.17 = $r0.12, $r0.14
	c0	or $r0.11 = $r0.11, 1048576
;;
	c0	shru $r0.18 = $r0.11, $r0.2
	c0	mpyhs $r0.19 = $r0.10, $r0.14
	c0	mpylu $r0.20 = $r0.10, $r0.14
;;
	c0	mpyhs $r0.21 = $r0.5, $r0.13
	c0	mpylu $r0.22 = $r0.5, $r0.13
;;
	c0	mpylu $r0.23 = $r0.6, $r0.13
	c0	mpyhs $r0.24 = $r0.6, $r0.13
;;
	c0	mpylu $r0.25 = $r0.6, $r0.14
	c0	mpyhs $r0.26 = $r0.6, $r0.14
;;
	c0	mpylu $r0.27 = $r0.12, $r0.15
	c0	mpyhs $r0.28 = $r0.12, $r0.15
;;
	c0	mpyhs $r0.29 = $r0.10, $r0.13
	c0	mpylu $r0.30 = $r0.10, $r0.13
;;
	c0	mpyhs $r0.31 = $r0.5, $r0.14
	c0	mpylu $r0.14 = $r0.5, $r0.14
;;
	c0	mpyhs $r0.32 = $r0.10, $r0.15
	c0	mpylu $r0.33 = $r0.10, $r0.15
;;
	c0	mpylu $r0.34 = $r0.12, $r0.13
	c0	mpyhs $r0.13 = $r0.12, $r0.13
;;
	c0	mpylu $r0.35 = $r0.5, $r0.15
	c0	mpyhs $r0.36 = $r0.5, $r0.15
;;
	c0	mpylu $r0.37 = $r0.5, $r0.18
	c0	mpyhs $r0.5 = $r0.5, $r0.18
;;
	c0	mpylu $r0.38 = $r0.10, $r0.18
	c0	mpyhs $r0.10 = $r0.10, $r0.18
;;
	c0	mpyhs $r0.39 = $r0.12, $r0.18
	c0	mpylu $r0.12 = $r0.12, $r0.18
;;
	c0	mpylu $r0.40 = $r0.6, $r0.15
	c0	mpyhs $r0.15 = $r0.6, $r0.15
;;
	c0	mpylu $r0.41 = $r0.6, $r0.18
	c0	mpyhs $r0.6 = $r0.6, $r0.18
	c0	add $r0.14 = $r0.14, $r0.31
	c0	add $r0.16 = $r0.16, $r0.17
;;
	c0	add $r0.17 = $r0.22, $r0.21
	c0	add $r0.18 = $r0.20, $r0.19
	c0	add $r0.19 = $r0.30, $r0.29
	c0	add $r0.20 = $r0.23, $r0.24
;;
	c0	add $r0.17 = $r0.18, $r0.17
	c0	add $r0.21 = $r0.25, $r0.26
;;
	c0	cmpltu $r0.18 = $r0.17, $r0.18
	c0	add $r0.16 = $r0.20, $r0.16
	c0	shl $r0.22 = $r0.17, $r0.2
	c0	shru $r0.17 = $r0.17, $r0.2
;;
	c0	shl $r0.23 = $r0.16, $r0.2
	c0	shl $r0.18 = $r0.18, $r0.2
	c0	add $r0.14 = $r0.22, $r0.14
;;
	c0	cmpltu $r0.22 = $r0.14, $r0.22
	c0	add $r0.21 = $r0.23, $r0.21
	c0	or $r0.17 = $r0.18, $r0.17
;;
	c0	add $r0.18 = $r0.21, $r0.19
;;
	c0	add $r0.17 = $r0.18, $r0.17
;;
	c0	add $r0.17 = $r0.17, $r0.22
;;
	c0	cmpltu $b0.0 = $r0.17, $r0.21
	c0	add $r0.13 = $r0.34, $r0.13
	c0	add $r0.18 = $r0.33, $r0.32
	c0	add $r0.5 = $r0.37, $r0.5
;;
	c0	add $r0.19 = $r0.27, $r0.28
	c0	add $r0.6 = $r0.41, $r0.6
	c0	add $r0.15 = $r0.40, $r0.15
	c0	add $r0.5 = $r0.18, $r0.5
;;
	c0	add $r0.19 = $r0.6, $r0.19
	c0	shru $r0.22 = $r0.16, $r0.2
	c0	cmpltu $r0.16 = $r0.16, $r0.20
;;
	c0	shl $r0.20 = $r0.19, $r0.2
	c0	cmpne $b0.1 = $r0.14, 0
	c0	shl $r0.14 = $r0.16, $r0.2
;;
	c0	add $r0.15 = $r0.20, $r0.15
	c0	cmpltu $r0.16 = $r0.21, $r0.23
	c0	or $r0.14 = $r0.14, $r0.22
;;
	c0	add $r0.13 = $r0.15, $r0.13
;;
	c0	add $r0.13 = $r0.13, $r0.14
;;
	c0	add $r0.13 = $r0.13, $r0.16
	c0	mfb $r0.14 = $b0.0
;;
	c0	add $r0.13 = $r0.13, $r0.14
;;
	c0	cmpltu $b0.0 = $r0.13, $r0.15
	c0	add $r0.9 = $r0.7, $r0.9
	c0	add $r0.7 = $r0.35, $r0.36
	c0	cmpltu $r0.14 = $r0.5, $r0.18
;;
	c0	add $r0.12 = $r0.12, $r0.39
	c0	shl $r0.16 = $r0.5, $r0.2
	c0	shru $r0.5 = $r0.5, $r0.2
	c0	shl $r0.14 = $r0.14, $r0.2
;;
	c0	add $r0.10 = $r0.38, $r0.10
	c0	add $r0.11 = $r0.12, $r0.11
	c0	add $r0.7 = $r0.16, $r0.7
	c0	or $r0.5 = $r0.14, $r0.5
;;
	c0	cmpltu $r0.6 = $r0.19, $r0.6
	c0	cmpltu $r0.12 = $r0.7, $r0.16
	c0	add $r0.5 = $r0.5, $r0.10
	c0	add $r0.7 = $r0.17, $r0.7
;;
	c0	shru $r0.10 = $r0.19, $r0.2
	c0	shl $r0.2 = $r0.6, $r0.2
	c0	add $r0.5 = $r0.5, $r0.12
	c0	cmpltu $r0.6 = $r0.7, $r0.17
;;
	c0	cmpltu $r0.12 = $r0.15, $r0.20
	c0	or $r0.2 = $r0.2, $r0.10
	c0	mfb $r0.10 = $b0.1
	c0	add $r0.5 = $r0.5, $r0.6
;;
	c0	add $r0.2 = $r0.11, $r0.2
;;
	c0	add $r0.2 = $r0.2, $r0.12
	c0	or $r0.7 = $r0.7, $r0.10
	c0	add $r0.10 = $r0.5, $r0.13
;;
	c0	add $r0.6 = $r0.10, $r0.4
	c0	cmpltu $r0.4 = $r0.10, $r0.5
	c0	mfb $r0.5 = $b0.0
;;
	c0	cmpltu $r0.10 = $r0.6, $r0.10
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.2, $r0.4
;;
	c0	add $r0.5 = $r0.2, $r0.10
;;
	c0	cmpltu $b0.0 = $r0.5, 2097152
;;
;;
	c0	br $b0.0, LBB61_43
;;
## BB#44:                               ## %if.then.67
	c0	cmpne $b0.0 = $r0.7, 0
	c0	mov $r0.2 = 1
	c0	shl $r0.7 = $r0.5, $r0.8
	c0	shl $r0.8 = $r0.6, $r0.8
;;
	c0	add $r0.4 = $r0.9, -1023
	c0	shru $r0.6 = $r0.6, $r0.2
	c0	shru $r0.5 = $r0.5, $r0.2
;;
	c0	mfb $r0.2 = $b0.0
	c0	or $r0.6 = $r0.7, $r0.6
;;
	c0	or $r0.7 = $r0.8, $r0.2
	c0	goto LBB61_45
;;
LBB61_43:
	c0	add $r0.4 = $r0.9, -1024
;;
LBB61_45:                               ## %if.end.68
.call roundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = roundAndPackFloat64
;;
LBB61_46:                               ## %cleanup
	c0	mov $r0.2 = 0
;;
LBB61_47:                               ## %cleanup
	c0	or $r0.4 = $r0.4, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @roundAndPackFloat64
roundAndPackFloat64::
## BB#0:                                ## %entry
	c0	mov $r0.2 = float_rounding_mode
;;
	c0	ldbu $r0.8 = 0[$r0.2]
;;
;;
	c0	cmpeq $b0.0 = $r0.8, 0
	c0	mov $r0.2 = 31
;;
;;
	c0	br $b0.0, LBB62_1
;;
## BB#2:                                ## %if.then
	c0	cmpeq $b0.0 = $r0.8, 3
;;
;;
	c0	brf $b0.0, LBB62_4
;;
## BB#3:
	c0	mov $r0.9 = 0
	c0	goto LBB62_8
;;
LBB62_1:
	c0	shru $r0.9 = $r0.7, $r0.2
	c0	goto LBB62_8
;;
LBB62_4:                                ## %if.else
	c0	zxtb $r0.9 = $r0.3
;;
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB62_6
;;
## BB#5:                                ## %if.then.11
	c0	cmpeq $b0.0 = $r0.8, 1
	c0	goto LBB62_7
;;
LBB62_6:                                ## %if.else.17
	c0	cmpeq $b0.0 = $r0.8, 2
;;
LBB62_7:                                ## %if.end.27
	c0	cmpne $b0.1 = $r0.7, 0
	c0	mfb $r0.9 = $b0.0
;;
;;
	c0	mfb $r0.10 = $b0.1
;;
	c0	and $r0.9 = $r0.10, $r0.9
;;
	c0	and $r0.9 = $r0.9, 1
;;
LBB62_8:                                ## %if.end.27
	c0	zxth $r0.10 = $r0.4
;;
	c0	cmpltu $b0.0 = $r0.10, 2045
;;
;;
	c0	br $b0.0, LBB62_40
;;
## BB#9:                                ## %if.then.32
	c0	cmpgt $b0.0 = $r0.4, 2045
;;
;;
	c0	br $b0.0, LBB62_14
;;
## BB#10:                               ## %lor.lhs.false
	c0	cmpne $b0.0 = $r0.4, 2045
;;
;;
	c0	br $b0.0, LBB62_21
;;
## BB#11:                               ## %land.lhs.true
	c0	cmpne $b0.0 = $r0.5, 2097151
	c0	mov $r0.4 = 2045
;;
;;
	c0	br $b0.0, LBB62_40
;;
## BB#12:                               ## %land.lhs.true
	c0	cmpne $b0.0 = $r0.6, -1
;;
;;
	c0	br $b0.0, LBB62_40
;;
## BB#13:                               ## %land.lhs.true
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB62_40
;;
LBB62_14:                               ## %if.then.42
	c0	mov $r0.4 = float_exception_flags
;;
	c0	ldb $r0.5 = 0[$r0.4]
	c0	cmpeq $b0.0 = $r0.8, 3
;;
;;
	c0	or $r0.5 = $r0.5, 40
;;
	c0	stb 0[$r0.4] = $r0.5
	c0	br $b0.0, LBB62_19
;;
## BB#15:                               ## %lor.lhs.false.46
	c0	zxtb $r0.4 = $r0.3
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB62_17
;;
## BB#16:                               ## %lor.lhs.false.46
	c0	cmpeq $b0.0 = $r0.8, 2
;;
;;
	c0	br $b0.0, LBB62_19
;;
LBB62_17:                               ## %lor.lhs.false.53
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB62_20
;;
## BB#18:                               ## %lor.lhs.false.53
	c0	cmpne $b0.0 = $r0.8, 1
;;
;;
	c0	br $b0.0, LBB62_20
;;
LBB62_19:                               ## %if.then.59
	c0	shl $r0.2 = $r0.3, $r0.2
	c0	mov $r0.6 = -1
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.3 = $r0.2, 2146435071
	c0	mov $r0.4 = $r0.6
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB62_21:                               ## %if.end.63
	c0	cmpgt $b0.0 = $r0.4, -1
;;
;;
	c0	br $b0.0, LBB62_40
;;
## BB#22:                               ## %if.then.66
	c0	mov $r0.10 = -1
	c0	cmpltu $b0.1 = $r0.5, 2097151
;;
	c0	mtb $b0.0 = $r0.10
;;
	c0	br $b0.1, LBB62_25
;;
## BB#23:                               ## %if.then.66
	c0	mov $r0.10 = float_detect_tininess
	c0	cmplt $b0.1 = $r0.4, -1
	c0	cmpeq $b0.2 = $r0.9, 0
;;
	c0	ldbu $r0.9 = 0[$r0.10]
;;
	c0	mfb $r0.10 = $b0.1
	c0	mfb $r0.11 = $b0.2
;;
	c0	cmpeq $b0.1 = $r0.9, 1
;;
;;
	c0	mfb $r0.9 = $b0.1
;;
	c0	or $r0.9 = $r0.10, $r0.9
;;
	c0	or $r0.9 = $r0.11, $r0.9
;;
	c0	mtb $b0.1 = $r0.9
;;
;;
	c0	br $b0.1, LBB62_25
;;
## BB#24:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.6, -1
	c0	cmpeq $b0.1 = $r0.5, 2097151
;;
;;
	c0	mfb $r0.9 = $b0.0
	c0	mfb $r0.10 = $b0.1
;;
	c0	and $r0.9 = $r0.10, $r0.9
;;
	c0	mtb $b0.0 = $r0.9
;;
LBB62_25:                               ## %if.else.i
	c0	mov $r0.10 = 0
	c0	cmplt $b0.1 = $r0.4, -31
	c0	and $r0.9 = $r0.4, 31
;;
	c0	sub $r0.11 = $r0.10, $r0.4
;;
	c0	br $b0.1, LBB62_27
;;
## BB#26:                               ## %if.then.4.i
	c0	shru $r0.4 = $r0.6, $r0.11
	c0	shl $r0.12 = $r0.5, $r0.9
	c0	shru $r0.10 = $r0.5, $r0.11
	c0	shl $r0.6 = $r0.6, $r0.9
;;
	c0	or $r0.11 = $r0.4, $r0.12
	c0	goto LBB62_32
;;
LBB62_20:                               ## %if.end.61
	c0	shl $r0.2 = $r0.3, $r0.2
	c0	mov $r0.6 = 0
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.3 = $r0.2, 2146435072
	c0	mov $r0.4 = $r0.6
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB62_27:                               ## %if.else.9.i
	c0	cmpeq $b0.1 = $r0.11, 32
;;
;;
	c0	brf $b0.1, LBB62_29
;;
## BB#28:
	c0	mov $r0.11 = $r0.5
	c0	goto LBB62_32
;;
LBB62_29:                               ## %if.else.13.i
	c0	cmplt $b0.1 = $r0.4, -63
	c0	or $r0.7 = $r0.7, $r0.6
;;
;;
	c0	br $b0.1, LBB62_31
;;
## BB#30:                               ## %if.then.17.i
	c0	and $r0.4 = $r0.11, 31
	c0	shl $r0.6 = $r0.5, $r0.9
;;
	c0	shru $r0.11 = $r0.5, $r0.4
	c0	goto LBB62_32
;;
LBB62_31:                               ## %if.else.22.i
	c0	cmpne $b0.1 = $r0.5, 0
	c0	cmpeq $b0.2 = $r0.11, 64
	c0	mov $r0.10 = 0
;;
	c0	mov $r0.11 = $r0.10
;;
	c0	mfb $r0.4 = $b0.1
;;
	c0	slct $r0.6 = $b0.2, $r0.5, $r0.4
;;
LBB62_32:                               ## %shift64ExtraRightJamming.exit
	c0	cmpne $b0.1 = $r0.7, 0
	c0	mfb $r0.4 = $b0.0
;;
;;
	c0	mfb $r0.5 = $b0.1
;;
	c0	or $r0.7 = $r0.5, $r0.6
;;
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	mfb $r0.9 = $b0.0
;;
	c0	and $r0.4 = $r0.4, $r0.9
;;
	c0	and $r0.4 = $r0.4, 1
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB62_34
;;
## BB#33:                               ## %if.then.83
	c0	mov $r0.4 = float_exception_flags
;;
	c0	ldb $r0.5 = 0[$r0.4]
;;
;;
	c0	or $r0.5 = $r0.5, 16
;;
	c0	stb 0[$r0.4] = $r0.5
;;
LBB62_34:                               ## %if.end.84
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB62_35
;;
## BB#36:                               ## %if.else.90
	c0	zxtb $r0.4 = $r0.3
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB62_38
;;
## BB#37:                               ## %if.then.92
	c0	cmpeq $b0.0 = $r0.8, 1
	c0	goto LBB62_39
;;
LBB62_35:                               ## %if.then.86
	c0	shru $r0.9 = $r0.6, $r0.2
	c0	mov $r0.5 = $r0.10
	c0	mov $r0.4 = 0
	c0	mov $r0.6 = $r0.11
;;
	c0	goto LBB62_40
;;
LBB62_38:                               ## %if.else.101
	c0	cmpeq $b0.0 = $r0.8, 2
;;
LBB62_39:                               ## %if.end.113
	c0	mov $r0.5 = $r0.10
	c0	mov $r0.4 = 0
	c0	mov $r0.6 = $r0.11
	c0	mfb $r0.10 = $b0.0
;;
	c0	and $r0.9 = $r0.10, $r0.9
;;
	c0	and $r0.9 = $r0.9, 1
;;
LBB62_40:                               ## %if.end.113
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB62_42
;;
## BB#41:                               ## %if.then.115
	c0	mov $r0.10 = float_exception_flags
;;
	c0	ldb $r0.11 = 0[$r0.10]
;;
;;
	c0	or $r0.11 = $r0.11, 32
;;
	c0	stb 0[$r0.10] = $r0.11
;;
LBB62_42:                               ## %if.end.118
	c0	cmpeq $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB62_44
;;
## BB#43:                               ## %if.then.120
	c0	and $r0.7 = $r0.7, 2147483647
	c0	cmpeq $b0.0 = $r0.6, -1
	c0	add $r0.6 = $r0.6, 1
;;
	c0	or $r0.7 = $r0.8, $r0.7
;;
	c0	mfb $r0.8 = $b0.0
	c0	cmpeq $b0.0 = $r0.7, 0
;;
	c0	add $r0.5 = $r0.8, $r0.5
;;
	c0	mfb $r0.7 = $b0.0
;;
	c0	andc $r0.6 = $r0.7, $r0.6
	c0	goto LBB62_45
;;
LBB62_44:                               ## %if.else.125
	c0	or $r0.7 = $r0.6, $r0.5
	c0	mov $r0.8 = 0
;;
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	slct $r0.4 = $b0.0, $r0.8, $r0.4
;;
LBB62_45:                               ## %if.end.131
	c0	shl $r0.2 = $r0.3, $r0.2
	c0	mov $r0.3 = 20
;;
	c0	shl $r0.3 = $r0.4, $r0.3
	c0	add $r0.2 = $r0.5, $r0.2
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.3 = $r0.2, $r0.3
	c0	mov $r0.4 = $r0.6
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_div
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_div
float64_div::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $r0.57
;;
	c0	stw 24[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
	c0	mov $r0.7 = $r0.3
	c0	mov $r0.10 = 31
;;
	c0	shru $r0.3 = $r0.7, $r0.2
	c0	xor $r0.11 = $r0.5, $r0.7
	c0	shru $r0.12 = $r0.5, $r0.2
;;
	c0	and $r0.9 = $r0.3, 2047
;;
	c0	cmpne $b0.0 = $r0.9, 2047
	c0	mov $r0.2 = $r0.4
;;
	c0	and $r0.8 = $r0.7, 1048575
	c0	and $r0.4 = $r0.5, 1048575
;;
	c0	shru $r0.3 = $r0.11, $r0.10
	c0	and $r0.11 = $r0.12, 2047
;;
	c0	br $b0.0, LBB63_6
;;
## BB#1:                                ## %if.then
	c0	or $r0.8 = $r0.8, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB63_2
;;
## BB#3:                                ## %if.end
	c0	cmpne $b0.0 = $r0.11, 2047
;;
;;
	c0	br $b0.0, LBB63_5
;;
## BB#4:                                ## %if.then.15
	c0	or $r0.3 = $r0.4, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.3, 0
;;
;;
	c0	brf $b0.0, LBB63_2
;;
	c0	goto LBB63_12
;;
LBB63_6:                                ## %if.end.23
	c0	cmpeq $b0.0 = $r0.11, 0
;;
;;
	c0	brf $b0.0, LBB63_7
;;
## BB#10:                               ## %if.then.36
	c0	or $r0.11 = $r0.4, $r0.6
;;
	c0	cmpne $b0.0 = $r0.11, 0
;;
;;
	c0	brf $b0.0, LBB63_11
;;
## BB#14:                               ## %if.end.48
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	brf $b0.0, LBB63_15
;;
## BB#21:                               ## %if.else.14.i.354
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.11 = 16
	c0	mov $r0.12 = 4
;;
	c0	shl $r0.5 = $r0.5, $r0.11
;;
	c0	mfb $r0.11 = $b0.0
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.5, 16777215
	c0	shl $r0.11 = $r0.11, $r0.12
;;
;;
	c0	br $b0.0, LBB63_23
;;
## BB#22:                               ## %if.then.4.i.54.i.359
	c0	or $r0.11 = $r0.11, 8
	c0	mov $r0.12 = 8
;;
	c0	shl $r0.5 = $r0.5, $r0.12
	c0	zxtb $r0.11 = $r0.11
;;
LBB63_23:                               ## %countLeadingZeros32.exit64.i.373
	c0	mov $r0.12 = 24
	c0	mov $r0.13 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.5 = $r0.5, $r0.12
;;
	c0	add $r0.5 = $r0.13, $r0.5
;;
	c0	ldb $r0.5 = 0[$r0.5]
;;
;;
	c0	add $r0.5 = $r0.5, $r0.11
;;
	c0	shl $r0.5 = $r0.5, $r0.12
;;
	c0	add $r0.5 = $r0.5, -184549376
;;
	c0	shr $r0.5 = $r0.5, $r0.12
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB63_25
;;
## BB#24:                               ## %cond.false.i.i.379
	c0	mov $r0.11 = 0
	c0	shl $r0.4 = $r0.4, $r0.5
;;
	c0	sub $r0.11 = $r0.11, $r0.5
;;
	c0	and $r0.11 = $r0.11, 31
;;
	c0	shru $r0.11 = $r0.6, $r0.11
;;
	c0	or $r0.4 = $r0.11, $r0.4
;;
LBB63_25:                               ## %shortShift64Left.exit.i.382
	c0	mov $r0.11 = 1
	c0	shl $r0.6 = $r0.6, $r0.5
	c0	goto LBB63_26
;;
LBB63_7:                                ## %if.end.23
	c0	cmpne $b0.0 = $r0.11, 2047
;;
;;
	c0	br $b0.0, LBB63_27
;;
## BB#8:                                ## %if.then.26
	c0	or $r0.4 = $r0.4, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB63_9
;;
LBB63_2:                                ## %if.then.11
	c0	mov $r0.4 = $r0.2
	c0	mov $r0.3 = $r0.7
;;
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	mov $r0.57 = 0
	c0	goto LBB63_75
;;
LBB63_5:                                ## %if.end.21
	c0	shl $r0.2 = $r0.3, $r0.10
	c0	mov $r0.57 = 0
;;
	c0	or $r0.3 = $r0.2, 2146435072
	c0	mov $r0.4 = $r0.57
	c0	goto LBB63_75
;;
LBB63_11:                               ## %if.then.40
	c0	or $r0.2 = $r0.8, $r0.2
;;
	c0	or $r0.2 = $r0.2, $r0.9
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB63_12
;;
## BB#13:                               ## %if.end.46
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.57 = 0
;;
	c0	ldb $r0.5 = 0[$r0.2]
	c0	shl $r0.3 = $r0.3, $r0.10
;;
	c0	or $r0.3 = $r0.3, 2146435072
	c0	mov $r0.4 = $r0.57
;;
	c0	or $r0.5 = $r0.5, 4
;;
	c0	stb 0[$r0.2] = $r0.5
	c0	goto LBB63_75
;;
LBB63_12:                               ## %invalid
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.57 = 0
;;
	c0	ldb $r0.5 = 0[$r0.2]
	c0	mov $r0.3 = -524288
	c0	mov $r0.4 = $r0.57
;;
;;
	c0	or $r0.5 = $r0.5, 1
;;
	c0	stb 0[$r0.2] = $r0.5
	c0	goto LBB63_75
;;
LBB63_15:                               ## %if.then.i.320
	c0	mov $r0.4 = 16
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.5 = 4
;;
	c0	shl $r0.4 = $r0.6, $r0.4
;;
	c0	mfb $r0.11 = $b0.0
	c0	slct $r0.4 = $b0.0, $r0.4, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.4, 16777215
	c0	shl $r0.5 = $r0.11, $r0.5
;;
;;
	c0	br $b0.0, LBB63_17
;;
## BB#16:                               ## %if.then.4.i.i.325
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.11 = 8
;;
	c0	shl $r0.4 = $r0.4, $r0.11
	c0	zxtb $r0.5 = $r0.5
;;
LBB63_17:                               ## %countLeadingZeros32.exit.i.338
	c0	mov $r0.11 = 24
	c0	mov $r0.12 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.4 = $r0.4, $r0.11
;;
	c0	add $r0.4 = $r0.12, $r0.4
;;
	c0	ldb $r0.4 = 0[$r0.4]
;;
;;
	c0	add $r0.4 = $r0.4, $r0.5
;;
	c0	shl $r0.4 = $r0.4, $r0.11
;;
	c0	add $r0.4 = $r0.4, -184549376
;;
	c0	cmpgt $b0.0 = $r0.4, -1
	c0	shr $r0.5 = $r0.4, $r0.11
;;
;;
	c0	brf $b0.0, LBB63_18
;;
## BB#19:                               ## %if.else.i.345
	c0	mov $r0.11 = 0
	c0	shl $r0.4 = $r0.6, $r0.5
	c0	goto LBB63_20
;;
LBB63_18:                               ## %if.then.5.i.343
	c0	mov $r0.4 = 0
	c0	and $r0.11 = $r0.5, 31
;;
	c0	sub $r0.4 = $r0.4, $r0.5
	c0	shl $r0.11 = $r0.6, $r0.11
;;
	c0	shru $r0.4 = $r0.6, $r0.4
;;
LBB63_20:                               ## %if.end.i.348
	c0	mov $r0.6 = $r0.11
	c0	mov $r0.11 = -31
;;
LBB63_26:                               ## %if.end.49
	c0	sub $r0.11 = $r0.11, $r0.5
;;
LBB63_27:                               ## %if.end.49
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	br $b0.0, LBB63_42
;;
## BB#28:                               ## %if.then.52
	c0	or $r0.5 = $r0.8, $r0.2
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB63_9
;;
## BB#29:                               ## %if.end.58
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB63_30
;;
## BB#36:                               ## %if.else.14.i
	c0	cmpltu $b0.0 = $r0.8, 65536
	c0	mov $r0.5 = 16
	c0	mov $r0.9 = 4
;;
	c0	shl $r0.5 = $r0.7, $r0.5
;;
	c0	mfb $r0.7 = $b0.0
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.8
;;
	c0	cmpgtu $b0.0 = $r0.5, 16777215
	c0	shl $r0.7 = $r0.7, $r0.9
;;
;;
	c0	br $b0.0, LBB63_38
;;
## BB#37:                               ## %if.then.4.i.54.i
	c0	or $r0.7 = $r0.7, 8
	c0	mov $r0.9 = 8
;;
	c0	shl $r0.5 = $r0.5, $r0.9
	c0	zxtb $r0.7 = $r0.7
;;
LBB63_38:                               ## %countLeadingZeros32.exit64.i
	c0	mov $r0.9 = 24
	c0	mov $r0.12 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.5 = $r0.5, $r0.9
;;
	c0	add $r0.5 = $r0.12, $r0.5
;;
	c0	ldb $r0.5 = 0[$r0.5]
;;
;;
	c0	add $r0.5 = $r0.5, $r0.7
;;
	c0	shl $r0.5 = $r0.5, $r0.9
;;
	c0	add $r0.5 = $r0.5, -184549376
;;
	c0	shr $r0.5 = $r0.5, $r0.9
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB63_40
;;
## BB#39:                               ## %cond.false.i.i
	c0	mov $r0.7 = 0
	c0	shl $r0.8 = $r0.8, $r0.5
;;
	c0	sub $r0.7 = $r0.7, $r0.5
;;
	c0	and $r0.7 = $r0.7, 31
;;
	c0	shru $r0.7 = $r0.2, $r0.7
;;
	c0	or $r0.8 = $r0.7, $r0.8
;;
LBB63_40:                               ## %shortShift64Left.exit.i
	c0	mov $r0.7 = 1
	c0	shl $r0.2 = $r0.2, $r0.5
	c0	goto LBB63_41
;;
LBB63_9:                                ## %if.end.31
	c0	mov $r0.57 = 0
	c0	shl $r0.3 = $r0.3, $r0.10
;;
	c0	mov $r0.4 = $r0.57
	c0	goto LBB63_75
;;
LBB63_30:                               ## %if.then.i
	c0	mov $r0.5 = 16
	c0	cmpltu $b0.0 = $r0.2, 65536
	c0	mov $r0.7 = 4
;;
	c0	shl $r0.5 = $r0.2, $r0.5
;;
	c0	mfb $r0.8 = $b0.0
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.2
;;
	c0	cmpgtu $b0.0 = $r0.5, 16777215
	c0	shl $r0.7 = $r0.8, $r0.7
;;
;;
	c0	br $b0.0, LBB63_32
;;
## BB#31:                               ## %if.then.4.i.i
	c0	or $r0.7 = $r0.7, 8
	c0	mov $r0.8 = 8
;;
	c0	shl $r0.5 = $r0.5, $r0.8
	c0	zxtb $r0.7 = $r0.7
;;
LBB63_32:                               ## %countLeadingZeros32.exit.i
	c0	mov $r0.8 = 24
	c0	mov $r0.9 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.5 = $r0.5, $r0.8
;;
	c0	add $r0.5 = $r0.9, $r0.5
;;
	c0	ldb $r0.5 = 0[$r0.5]
;;
;;
	c0	add $r0.5 = $r0.5, $r0.7
;;
	c0	shl $r0.5 = $r0.5, $r0.8
;;
	c0	add $r0.5 = $r0.5, -184549376
;;
	c0	cmpgt $b0.0 = $r0.5, -1
	c0	shr $r0.5 = $r0.5, $r0.8
	c0	mov $r0.7 = 0
;;
;;
	c0	brf $b0.0, LBB63_33
;;
## BB#34:                               ## %if.else.i
	c0	shl $r0.8 = $r0.2, $r0.5
	c0	mov $r0.2 = $r0.7
	c0	mov $r0.7 = -31
	c0	goto LBB63_41
;;
LBB63_33:                               ## %if.then.5.i
	c0	and $r0.8 = $r0.5, 31
	c0	sub $r0.7 = $r0.7, $r0.5
;;
	c0	shl $r0.9 = $r0.2, $r0.8
	c0	shru $r0.8 = $r0.2, $r0.7
;;
	c0	mov $r0.2 = $r0.9
	c0	mov $r0.7 = -31
;;
LBB63_41:                               ## %if.end.59
	c0	sub $r0.9 = $r0.7, $r0.5
;;
LBB63_42:                               ## %if.end.59
	c0	mov $r0.5 = 11
	c0	mov $r0.7 = 21
;;
	c0	shl $r0.4 = $r0.4, $r0.5
	c0	shru $r0.12 = $r0.2, $r0.7
	c0	shl $r0.14 = $r0.8, $r0.5
	c0	shru $r0.15 = $r0.6, $r0.7
;;
	c0	sub $r0.13 = $r0.9, $r0.11
	c0	shl $r0.8 = $r0.6, $r0.5
	c0	or $r0.11 = $r0.4, -2147483648
;;
	c0	or $r0.4 = $r0.12, $r0.14
;;
	c0	or $r0.14 = $r0.4, -2147483648
	c0	or $r0.9 = $r0.15, $r0.11
;;
	c0	cmpltu $b0.0 = $r0.9, $r0.14
;;
;;
	c0	br $b0.0, LBB63_45
;;
## BB#43:                               ## %lor.rhs.i
	c0	shl $r0.15 = $r0.2, $r0.5
	c0	add $r0.4 = $r0.13, 1021
;;
	c0	cmpgtu $b0.0 = $r0.8, $r0.15
;;
;;
	c0	br $b0.0, LBB63_46
;;
## BB#44:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.9, $r0.14
;;
;;
	c0	br $b0.0, LBB63_46
;;
LBB63_45:                               ## %if.then.64
	c0	mov $r0.15 = 10
	c0	mov $r0.16 = 1
	c0	shl $r0.10 = $r0.12, $r0.10
;;
	c0	add $r0.4 = $r0.13, 1022
	c0	shl $r0.2 = $r0.2, $r0.15
	c0	shru $r0.14 = $r0.14, $r0.16
;;
	c0	and $r0.2 = $r0.2, 2147482624
;;
	c0	or $r0.15 = $r0.10, $r0.2
;;
LBB63_46:                               ## %if.end.65
	c0	mov $r0.2 = 16
	c0	cmpgtu $b0.0 = $r0.9, $r0.14
;;
	c0	shru $r0.10 = $r0.11, $r0.2
;;
	c0	brf $b0.0, LBB63_47
;;
## BB#48:                               ## %if.end.i.237
	c0	shl $r0.13 = $r0.10, $r0.2
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.14
;;
;;
	c0	br $b0.0, LBB63_49
;;
## BB#50:                               ## %cond.false.i.240
	c0	cmplt $r0.11 = $r0.10, $r0.0
	c0	mov $r0.12 = 0
;;
	c0	shru $r0.16 = $r0.14, $r0.11
	c0	mtb $b0.0 = $r0.12
	c0	shru $r0.17 = $r0.10, $r0.11
	c0	mtb $b0.1 = $r0.12
;;
;;
	c0	addcg $r0.12, $b0.0 = $r0.16, $r0.16, $b0.0
;;
	c0	divs $r0.16, $b0.0 = $r0.0, $r0.17, $b0.0
	c0	addcg $r0.18, $b0.1 = $r0.12, $r0.12, $b0.1
;;
	c0	addcg $r0.12, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.16, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.0 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.17, $b0.0
;;
	c0	addcg $r0.16, $b0.2 = $r0.18, $r0.18, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
	c0	mtb $b0.0 = $r0.11
;;
	c0	addcg $r0.11, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.17, $b0.2
;;
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.17, $b0.2
;;
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.17, $b0.2
;;
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	addcg $r0.11, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.17, $b0.2
	c0	cmpgeu $r0.16 = $r0.14, $r0.10
;;
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.17, $b0.1
	c0	addcg $r0.17, $b0.2 = $r0.11, $r0.11, $b0.2
;;
	c0	cmpge $b0.2 = $r0.12, $r0.0
	c0	addcg $r0.11, $b0.1 = $r0.17, $r0.17, $b0.1
;;
	c0	orc $r0.11 = $r0.11, $r0.0
;;
	c0	mfb $r0.12 = $b0.2
;;
	c0	sh1add $r0.11 = $r0.11, $r0.12
;;
	c0	slct $r0.11 = $b0.0, $r0.16, $r0.11
;;
	c0	shl $r0.12 = $r0.11, $r0.2
	c0	goto LBB63_51
;;
LBB63_47:                               ## %if.end.65.estimateDiv64To32.exit283_crit_edge
	c0	zxth $r0.11 = $r0.9
	c0	mov $r0.12 = -1
	c0	goto LBB63_58
;;
LBB63_49:
	c0	mov $r0.12 = -65536
;;
LBB63_51:                               ## %cond.end.i.255
	c0	shru $r0.16 = $r0.12, $r0.2
	c0	zxth $r0.11 = $r0.9
	c0	mov $r0.17 = -1
;;
	c0	mpyhs $r0.18 = $r0.16, $r0.10
	c0	mpyhs $r0.19 = $r0.16, $r0.11
;;
	c0	mpylu $r0.20 = $r0.16, $r0.11
	c0	mpylu $r0.16 = $r0.16, $r0.10
;;
;;
	c0	add $r0.19 = $r0.20, $r0.19
	c0	add $r0.16 = $r0.16, $r0.18
;;
	c0	shl $r0.18 = $r0.19, $r0.2
	c0	shru $r0.19 = $r0.19, $r0.2
	c0	sub $r0.20 = $r0.14, $r0.16
;;
	c0	cmpltu $r0.21 = $r0.15, $r0.18
	c0	sub $r0.16 = $r0.15, $r0.18
	c0	sub $r0.18 = $r0.20, $r0.19
;;
	c0	mtb $b0.0 = $r0.21
;;
;;
	c0	slct $r0.17 = $b0.0, $r0.17, 0
;;
	c0	add $r0.17 = $r0.18, $r0.17
;;
	c0	cmpgt $b0.0 = $r0.17, -1
;;
;;
	c0	br $b0.0, LBB63_54
;;
## BB#52:                               ## %while.body.lr.ph.i.257
	c0	shl $r0.18 = $r0.9, $r0.2
;;
LBB63_53:                               ## %while.body.i.268
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.16 = $r0.16, $r0.18
	c0	add $r0.17 = $r0.17, $r0.10
	c0	add $r0.12 = $r0.12, -65536
;;
	c0	cmpltu $r0.19 = $r0.16, $r0.18
;;
	c0	add $r0.17 = $r0.17, $r0.19
;;
	c0	cmplt $b0.0 = $r0.17, 0
;;
;;
	c0	br $b0.0, LBB63_53
;;
LBB63_54:                               ## %while.end.i.276
	c0	shl $r0.17 = $r0.17, $r0.2
	c0	shru $r0.16 = $r0.16, $r0.2
;;
	c0	or $r0.16 = $r0.16, $r0.17
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.16
;;
;;
	c0	br $b0.0, LBB63_55
;;
## BB#56:                               ## %cond.false.10.i.278
	c0	cmplt $r0.13 = $r0.10, $r0.0
	c0	mov $r0.17 = 0
;;
	c0	shru $r0.18 = $r0.16, $r0.13
	c0	mtb $b0.0 = $r0.17
	c0	shru $r0.19 = $r0.10, $r0.13
	c0	mtb $b0.1 = $r0.17
;;
;;
	c0	addcg $r0.17, $b0.0 = $r0.18, $r0.18, $b0.0
;;
	c0	divs $r0.18, $b0.0 = $r0.0, $r0.19, $b0.0
	c0	addcg $r0.20, $b0.1 = $r0.17, $r0.17, $b0.1
;;
	c0	addcg $r0.17, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.18, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.19, $b0.0
;;
	c0	addcg $r0.18, $b0.0 = $r0.20, $r0.20, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.20, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.17, $b0.2 = $r0.17, $r0.19, $b0.0
	c0	mtb $b0.0 = $r0.13
;;
	c0	addcg $r0.13, $b0.2 = $r0.20, $r0.20, $b0.2
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.19, $b0.1
;;
	c0	addcg $r0.18, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.17, $r0.19, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.19, $b0.1
	c0	addcg $r0.17, $b0.2 = $r0.18, $r0.18, $b0.2
;;
	c0	addcg $r0.18, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.19, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.19, $b0.1
	c0	cmpgeu $r0.16 = $r0.16, $r0.10
	c0	addcg $r0.17, $b0.2 = $r0.18, $r0.18, $b0.2
;;
	c0	cmpge $b0.2 = $r0.13, $r0.0
	c0	addcg $r0.13, $b0.1 = $r0.17, $r0.17, $b0.1
;;
	c0	orc $r0.13 = $r0.13, $r0.0
;;
	c0	mfb $r0.17 = $b0.2
;;
	c0	sh1add $r0.13 = $r0.13, $r0.17
;;
	c0	slct $r0.13 = $b0.0, $r0.16, $r0.13
	c0	goto LBB63_57
;;
LBB63_55:
	c0	mov $r0.13 = 65535
;;
LBB63_57:                               ## %cond.end.12.i.281
	c0	or $r0.12 = $r0.13, $r0.12
;;
LBB63_58:                               ## %estimateDiv64To32.exit283
	c0	mov $r0.16 = 5
	c0	shru $r0.17 = $r0.12, $r0.2
	c0	zxth $r0.18 = $r0.12
;;
	c0	and $r0.13 = $r0.8, 63488
	c0	shru $r0.6 = $r0.6, $r0.16
	c0	mpyhs $r0.19 = $r0.18, $r0.10
;;
	c0	mpylu $r0.20 = $r0.18, $r0.10
	c0	mov $r0.16 = -1
	c0	zxth $r0.6 = $r0.6
	c0	mpylu $r0.21 = $r0.17, $r0.11
;;
	c0	mpyhs $r0.22 = $r0.17, $r0.11
	c0	mpyhs $r0.23 = $r0.17, $r0.13
;;
	c0	mpylu $r0.24 = $r0.17, $r0.13
	c0	add $r0.19 = $r0.20, $r0.19
	c0	mpylu $r0.20 = $r0.18, $r0.11
;;
	c0	mpyhs $r0.25 = $r0.18, $r0.11
	c0	add $r0.21 = $r0.21, $r0.22
;;
	c0	add $r0.22 = $r0.24, $r0.23
	c0	mpyhs $r0.23 = $r0.18, $r0.6
	c0	mpylu $r0.24 = $r0.18, $r0.6
	c0	add $r0.19 = $r0.21, $r0.19
;;
	c0	add $r0.20 = $r0.20, $r0.25
	c0	mpyhs $r0.25 = $r0.18, $r0.13
	c0	mpylu $r0.18 = $r0.18, $r0.13
	c0	shl $r0.26 = $r0.19, $r0.2
;;
	c0	mpyhs $r0.27 = $r0.17, $r0.6
	c0	mpylu $r0.28 = $r0.17, $r0.6
;;
	c0	mpylu $r0.29 = $r0.17, $r0.10
	c0	mpyhs $r0.17 = $r0.17, $r0.10
	c0	add $r0.23 = $r0.24, $r0.23
;;
	c0	add $r0.23 = $r0.22, $r0.23
	c0	add $r0.18 = $r0.18, $r0.25
	c0	add $r0.24 = $r0.28, $r0.27
;;
	c0	cmpltu $r0.22 = $r0.23, $r0.22
	c0	add $r0.20 = $r0.26, $r0.20
	c0	shl $r0.25 = $r0.23, $r0.2
	c0	shru $r0.23 = $r0.23, $r0.2
;;
	c0	shl $r0.22 = $r0.22, $r0.2
	c0	add $r0.24 = $r0.20, $r0.24
	c0	add $r0.18 = $r0.25, $r0.18
;;
	c0	or $r0.22 = $r0.22, $r0.23
	c0	cmpltu $r0.23 = $r0.18, $r0.25
	c0	cmpne $b0.1 = $r0.18, 0
;;
	c0	add $r0.22 = $r0.24, $r0.22
	c0	cmpltu $r0.24 = $r0.20, $r0.26
;;
	c0	mtb $b0.0 = $r0.24
	c0	add $r0.22 = $r0.22, $r0.23
	c0	mfb $r0.23 = $b0.1
;;
	c0	sub $r0.24 = $r0.15, $r0.22
	c0	cmpltu $r0.20 = $r0.22, $r0.20
	c0	cmpltu $r0.15 = $r0.15, $r0.22
;;
	c0	mtb $b0.1 = $r0.20
	c0	mtb $b0.2 = $r0.15
	c0	cmpltu $r0.15 = $r0.24, $r0.23
;;
	c0	mtb $b0.3 = $r0.15
	c0	mov $r0.57 = 0
	c0	add $r0.15 = $r0.29, $r0.17
;;
	c0	sub $r0.14 = $r0.14, $r0.15
	c0	shru $r0.15 = $r0.19, $r0.2
	c0	cmpltu $r0.17 = $r0.19, $r0.21
;;
	c0	shl $r0.17 = $r0.17, $r0.2
;;
	c0	or $r0.15 = $r0.17, $r0.15
;;
	c0	sub $r0.14 = $r0.14, $r0.15
	c0	sub $r0.15 = $r0.57, $r0.18
	c0	mfb $r0.17 = $b0.0
;;
	c0	add $r0.17 = $r0.14, $r0.17
	c0	sub $r0.14 = $r0.24, $r0.23
	c0	slct $r0.18 = $b0.1, $r0.16, 0
	c0	slct $r0.19 = $b0.2, $r0.16, 0
;;
	c0	slct $r0.20 = $b0.3, $r0.16, 0
	c0	add $r0.17 = $r0.17, $r0.18
;;
	c0	add $r0.17 = $r0.17, $r0.19
;;
	c0	add $r0.17 = $r0.17, $r0.20
;;
	c0	cmpgt $b0.0 = $r0.17, -1
;;
;;
	c0	br $b0.0, LBB63_60
;;
LBB63_59:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.15 = $r0.8, $r0.15
	c0	add $r0.18 = $r0.14, $r0.9
;;
	c0	cmpltu $r0.19 = $r0.15, $r0.8
	c0	cmpltu $r0.14 = $r0.18, $r0.14
	c0	add $r0.12 = $r0.12, -1
;;
	c0	add $r0.17 = $r0.14, $r0.17
	c0	add $r0.14 = $r0.19, $r0.18
;;
	c0	cmpltu $r0.18 = $r0.14, $r0.19
;;
	c0	add $r0.17 = $r0.17, $r0.18
;;
	c0	cmplt $b0.0 = $r0.17, 0
;;
;;
	c0	br $b0.0, LBB63_59
;;
LBB63_60:                               ## %while.end
	c0	cmpleu $b0.0 = $r0.9, $r0.14
;;
;;
	c0	br $b0.0, LBB63_74
;;
## BB#61:                               ## %if.end.i
	c0	shl $r0.18 = $r0.10, $r0.2
;;
	c0	cmpleu $b0.0 = $r0.18, $r0.14
;;
;;
	c0	br $b0.0, LBB63_62
;;
## BB#63:                               ## %cond.false.i
	c0	cmplt $r0.16 = $r0.10, $r0.0
	c0	mov $r0.17 = 0
;;
	c0	shru $r0.19 = $r0.14, $r0.16
	c0	mtb $b0.0 = $r0.17
	c0	shru $r0.20 = $r0.10, $r0.16
	c0	mtb $b0.1 = $r0.17
;;
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
;;
	c0	divs $r0.19, $b0.0 = $r0.0, $r0.20, $b0.0
	c0	addcg $r0.21, $b0.1 = $r0.17, $r0.17, $b0.1
;;
	c0	addcg $r0.17, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.19, $b0.1 = $r0.19, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.19, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.0 = $r0.17, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.2 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
	c0	mtb $b0.0 = $r0.16
;;
	c0	addcg $r0.16, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.2 = $r0.17, $r0.20, $b0.2
;;
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
	c0	addcg $r0.19, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.2 = $r0.17, $r0.20, $b0.2
;;
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
	c0	addcg $r0.19, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.2 = $r0.17, $r0.20, $b0.2
;;
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
	c0	addcg $r0.19, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.17, $b0.2 = $r0.17, $r0.20, $b0.2
	c0	cmpgeu $r0.19 = $r0.14, $r0.10
;;
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.20, $b0.1
	c0	addcg $r0.20, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	cmpge $b0.2 = $r0.17, $r0.0
	c0	addcg $r0.16, $b0.1 = $r0.20, $r0.20, $b0.1
;;
	c0	orc $r0.16 = $r0.16, $r0.0
;;
	c0	mfb $r0.17 = $b0.2
;;
	c0	sh1add $r0.16 = $r0.16, $r0.17
;;
	c0	slct $r0.16 = $b0.0, $r0.19, $r0.16
;;
	c0	shl $r0.16 = $r0.16, $r0.2
	c0	goto LBB63_64
;;
LBB63_62:
	c0	mov $r0.16 = -65536
;;
LBB63_64:                               ## %cond.end.i
	c0	shru $r0.19 = $r0.16, $r0.2
	c0	mov $r0.17 = -1
;;
	c0	mpyhs $r0.20 = $r0.19, $r0.11
	c0	mpylu $r0.21 = $r0.19, $r0.11
;;
	c0	mpyhs $r0.22 = $r0.19, $r0.10
	c0	mpylu $r0.19 = $r0.19, $r0.10
;;
	c0	add $r0.20 = $r0.21, $r0.20
;;
	c0	add $r0.19 = $r0.19, $r0.22
	c0	shl $r0.21 = $r0.20, $r0.2
	c0	shru $r0.20 = $r0.20, $r0.2
;;
	c0	sub $r0.22 = $r0.14, $r0.19
	c0	cmpltu $r0.23 = $r0.15, $r0.21
	c0	sub $r0.19 = $r0.15, $r0.21
;;
	c0	sub $r0.20 = $r0.22, $r0.20
	c0	mtb $b0.0 = $r0.23
;;
;;
	c0	slct $r0.21 = $b0.0, $r0.17, 0
;;
	c0	add $r0.20 = $r0.20, $r0.21
;;
	c0	cmpgt $b0.0 = $r0.20, -1
;;
;;
	c0	br $b0.0, LBB63_67
;;
## BB#65:                               ## %while.body.lr.ph.i
	c0	shl $r0.21 = $r0.9, $r0.2
;;
LBB63_66:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.19 = $r0.19, $r0.21
	c0	add $r0.20 = $r0.20, $r0.10
	c0	add $r0.16 = $r0.16, -65536
;;
	c0	cmpltu $r0.22 = $r0.19, $r0.21
;;
	c0	add $r0.20 = $r0.20, $r0.22
;;
	c0	cmplt $b0.0 = $r0.20, 0
;;
;;
	c0	br $b0.0, LBB63_66
;;
LBB63_67:                               ## %while.end.i
	c0	shl $r0.20 = $r0.20, $r0.2
	c0	shru $r0.19 = $r0.19, $r0.2
;;
	c0	or $r0.19 = $r0.19, $r0.20
;;
	c0	cmpleu $b0.0 = $r0.18, $r0.19
;;
;;
	c0	br $b0.0, LBB63_68
;;
## BB#69:                               ## %cond.false.10.i
	c0	cmplt $r0.18 = $r0.10, $r0.0
	c0	mov $r0.20 = 0
;;
	c0	shru $r0.21 = $r0.19, $r0.18
	c0	mtb $b0.0 = $r0.20
	c0	shru $r0.22 = $r0.10, $r0.18
	c0	mtb $b0.1 = $r0.20
;;
;;
	c0	addcg $r0.20, $b0.0 = $r0.21, $r0.21, $b0.0
;;
	c0	divs $r0.21, $b0.0 = $r0.0, $r0.22, $b0.0
	c0	addcg $r0.23, $b0.1 = $r0.20, $r0.20, $b0.1
;;
	c0	addcg $r0.20, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.21, $b0.1 = $r0.21, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.20, $r0.20, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.21, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.0 = $r0.20, $r0.22, $b0.0
;;
	c0	addcg $r0.21, $b0.0 = $r0.23, $r0.23, $b0.0
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.23, $b0.1 = $r0.21, $r0.21, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.22, $b0.0
	c0	mtb $b0.0 = $r0.18
;;
	c0	addcg $r0.18, $b0.2 = $r0.23, $r0.23, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.22, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.18, $b0.2 = $r0.20, $r0.22, $b0.2
;;
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.22, $b0.1
	c0	addcg $r0.20, $b0.2 = $r0.21, $r0.21, $b0.2
;;
	c0	addcg $r0.21, $b0.1 = $r0.20, $r0.20, $b0.1
	c0	divs $r0.18, $b0.2 = $r0.18, $r0.22, $b0.2
;;
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.22, $b0.1
	c0	cmpgeu $r0.19 = $r0.19, $r0.10
	c0	addcg $r0.20, $b0.2 = $r0.21, $r0.21, $b0.2
;;
	c0	cmpge $b0.2 = $r0.18, $r0.0
	c0	addcg $r0.18, $b0.1 = $r0.20, $r0.20, $b0.1
;;
	c0	orc $r0.18 = $r0.18, $r0.0
;;
	c0	mfb $r0.20 = $b0.2
;;
	c0	sh1add $r0.18 = $r0.18, $r0.20
;;
	c0	slct $r0.18 = $b0.0, $r0.19, $r0.18
	c0	goto LBB63_70
;;
LBB63_68:
	c0	mov $r0.18 = 65535
;;
LBB63_70:                               ## %estimateDiv64To32.exit
	c0	or $r0.16 = $r0.18, $r0.16
;;
	c0	and $r0.18 = $r0.16, 1023
;;
	c0	cmpgtu $b0.0 = $r0.18, 4
;;
;;
	c0	br $b0.0, LBB63_74
;;
## BB#71:                               ## %if.then.72
	c0	shru $r0.18 = $r0.16, $r0.2
	c0	zxth $r0.19 = $r0.16
;;
	c0	mpylu $r0.20 = $r0.18, $r0.13
	c0	mpyhs $r0.21 = $r0.18, $r0.13
;;
	c0	mpyhs $r0.22 = $r0.19, $r0.6
	c0	mpylu $r0.23 = $r0.19, $r0.6
;;
	c0	add $r0.20 = $r0.20, $r0.21
	c0	mpyhs $r0.21 = $r0.19, $r0.10
	c0	mpylu $r0.24 = $r0.19, $r0.10
;;
	c0	add $r0.22 = $r0.23, $r0.22
	c0	mpyhs $r0.23 = $r0.18, $r0.11
	c0	mpylu $r0.25 = $r0.18, $r0.11
;;
	c0	add $r0.21 = $r0.24, $r0.21
	c0	add $r0.22 = $r0.20, $r0.22
;;
	c0	add $r0.23 = $r0.25, $r0.23
	c0	mpylu $r0.24 = $r0.19, $r0.11
	c0	mpyhs $r0.11 = $r0.19, $r0.11
	c0	cmpltu $r0.20 = $r0.22, $r0.20
;;
	c0	add $r0.21 = $r0.23, $r0.21
	c0	mpylu $r0.25 = $r0.18, $r0.6
	c0	mpyhs $r0.6 = $r0.18, $r0.6
	c0	shru $r0.26 = $r0.22, $r0.2
;;
	c0	mpyhs $r0.27 = $r0.19, $r0.13
	c0	mpylu $r0.13 = $r0.19, $r0.13
	c0	shl $r0.19 = $r0.21, $r0.2
	c0	add $r0.11 = $r0.24, $r0.11
;;
	c0	shl $r0.20 = $r0.20, $r0.2
	c0	add $r0.11 = $r0.19, $r0.11
	c0	add $r0.6 = $r0.25, $r0.6
	c0	shl $r0.22 = $r0.22, $r0.2
;;
	c0	add $r0.13 = $r0.13, $r0.27
	c0	or $r0.20 = $r0.20, $r0.26
	c0	add $r0.6 = $r0.11, $r0.6
	c0	mpylu $r0.24 = $r0.18, $r0.10
;;
	c0	add $r0.13 = $r0.22, $r0.13
	c0	mpyhs $r0.10 = $r0.18, $r0.10
	c0	add $r0.6 = $r0.6, $r0.20
	c0	cmpltu $r0.18 = $r0.11, $r0.19
;;
	c0	cmpltu $r0.19 = $r0.13, $r0.22
	c0	cmpne $b0.1 = $r0.13, 0
;;
	c0	add $r0.10 = $r0.24, $r0.10
	c0	mtb $b0.0 = $r0.18
	c0	add $r0.6 = $r0.6, $r0.19
;;
	c0	mfb $r0.18 = $b0.1
	c0	sub $r0.19 = $r0.15, $r0.6
	c0	cmpltu $r0.15 = $r0.15, $r0.6
	c0	cmpltu $r0.6 = $r0.6, $r0.11
;;
	c0	mtb $b0.1 = $r0.15
	c0	mtb $b0.2 = $r0.6
	c0	cmpltu $r0.6 = $r0.19, $r0.18
;;
	c0	mtb $b0.3 = $r0.6
	c0	mov $r0.6 = 0
	c0	sub $r0.10 = $r0.14, $r0.10
	c0	cmpltu $r0.11 = $r0.21, $r0.23
;;
	c0	shru $r0.14 = $r0.21, $r0.2
	c0	shl $r0.11 = $r0.11, $r0.2
	c0	sub $r0.2 = $r0.6, $r0.13
;;
	c0	or $r0.6 = $r0.11, $r0.14
;;
	c0	sub $r0.6 = $r0.10, $r0.6
	c0	mfb $r0.11 = $b0.0
	c0	sub $r0.10 = $r0.19, $r0.18
;;
	c0	add $r0.6 = $r0.6, $r0.11
	c0	slct $r0.11 = $b0.2, $r0.17, 0
	c0	slct $r0.13 = $b0.1, $r0.17, 0
	c0	slct $r0.14 = $b0.3, $r0.17, 0
;;
	c0	add $r0.6 = $r0.6, $r0.11
;;
	c0	add $r0.6 = $r0.6, $r0.13
;;
	c0	add $r0.6 = $r0.6, $r0.14
;;
	c0	cmpgt $b0.0 = $r0.6, -1
;;
;;
	c0	br $b0.0, LBB63_73
;;
LBB63_72:                               ## %while.body.76
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.2 = $r0.8, $r0.2
	c0	add $r0.11 = $r0.10, $r0.9
;;
	c0	cmpltu $r0.13 = $r0.2, $r0.8
	c0	cmpltu $r0.10 = $r0.11, $r0.10
	c0	add $r0.16 = $r0.16, -1
;;
	c0	add $r0.6 = $r0.10, $r0.6
	c0	add $r0.10 = $r0.13, $r0.11
;;
	c0	cmpltu $r0.11 = $r0.10, $r0.13
;;
	c0	add $r0.6 = $r0.6, $r0.11
;;
	c0	cmplt $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB63_72
;;
LBB63_73:                               ## %while.end.78
	c0	or $r0.6 = $r0.10, $r0.6
;;
	c0	or $r0.2 = $r0.6, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.16 = $r0.2, $r0.16
;;
LBB63_74:                               ## %if.end.84
	c0	shru $r0.2 = $r0.16, $r0.5
	c0	shl $r0.6 = $r0.12, $r0.7
	c0	shl $r0.7 = $r0.16, $r0.7
	c0	shru $r0.5 = $r0.12, $r0.5
;;
	c0	or $r0.6 = $r0.2, $r0.6
;;
.call roundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = roundAndPackFloat64
;;
LBB63_75:                               ## %cleanup
	c0	or $r0.4 = $r0.4, $r0.57
	c0	ldw $l0.0 = 24[$r0.1]
;;
	c0	ldw $r0.57 = 28[$r0.1]
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float64_rem
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_rem
float64_rem::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
	c0	and $r0.7 = $r0.5, 1048575
;;
	c0	shru $r0.8 = $r0.3, $r0.2
;;
	c0	and $r0.9 = $r0.8, 2047
	c0	shru $r0.2 = $r0.5, $r0.2
;;
	c0	cmpne $b0.0 = $r0.9, 2047
	c0	and $r0.8 = $r0.3, 1048575
;;
	c0	and $r0.2 = $r0.2, 2047
;;
	c0	br $b0.0, LBB64_5
;;
## BB#1:                                ## %if.then
	c0	or $r0.8 = $r0.8, $r0.4
;;
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB64_4
;;
## BB#2:                                ## %lor.lhs.false
	c0	cmpne $b0.0 = $r0.2, 2047
;;
;;
	c0	br $b0.0, LBB64_9
;;
## BB#3:                                ## %lor.lhs.false
	c0	or $r0.2 = $r0.7, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB64_4
;;
	c0	goto LBB64_9
;;
LBB64_5:                                ## %if.end.13
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB64_6
;;
## BB#8:                                ## %if.then.23
	c0	or $r0.2 = $r0.7, $r0.6
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB64_9
;;
## BB#10:                               ## %if.end.27
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	brf $b0.0, LBB64_11
;;
## BB#17:                               ## %if.else.14.i.418
	c0	cmpltu $b0.0 = $r0.7, 65536
	c0	mov $r0.2 = 16
	c0	mov $r0.10 = 4
;;
	c0	shl $r0.2 = $r0.5, $r0.2
;;
	c0	mfb $r0.5 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.7
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.5 = $r0.5, $r0.10
;;
;;
	c0	br $b0.0, LBB64_19
;;
## BB#18:                               ## %if.then.4.i.54.i.423
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.10 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.10
	c0	zxtb $r0.5 = $r0.5
;;
LBB64_19:                               ## %countLeadingZeros32.exit64.i.437
	c0	mov $r0.10 = 24
	c0	mov $r0.11 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.10
;;
	c0	add $r0.2 = $r0.11, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	shl $r0.2 = $r0.2, $r0.10
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	shr $r0.2 = $r0.2, $r0.10
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB64_21
;;
## BB#20:                               ## %cond.false.i.i.443
	c0	mov $r0.5 = 0
	c0	shl $r0.7 = $r0.7, $r0.2
;;
	c0	sub $r0.5 = $r0.5, $r0.2
;;
	c0	and $r0.5 = $r0.5, 31
;;
	c0	shru $r0.5 = $r0.6, $r0.5
;;
	c0	or $r0.7 = $r0.5, $r0.7
;;
LBB64_21:                               ## %shortShift64Left.exit.i.446
	c0	mov $r0.5 = 1
	c0	shl $r0.6 = $r0.6, $r0.2
	c0	goto LBB64_22
;;
LBB64_6:                                ## %if.end.13
	c0	cmpne $b0.0 = $r0.2, 2047
;;
;;
	c0	br $b0.0, LBB64_23
;;
## BB#7:                                ## %if.then.15
	c0	or $r0.2 = $r0.7, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB64_89
;;
LBB64_4:                                ## %if.then.11
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	goto LBB64_89
;;
LBB64_9:                                ## %invalid
	c0	mov $r0.5 = float_exception_flags
	c0	mov $r0.2 = 0
;;
	c0	ldb $r0.6 = 0[$r0.5]
	c0	mov $r0.3 = -524288
	c0	mov $r0.4 = $r0.2
;;
;;
	c0	or $r0.6 = $r0.6, 1
;;
	c0	stb 0[$r0.5] = $r0.6
	c0	goto LBB64_90
;;
LBB64_11:                               ## %if.then.i.384
	c0	mov $r0.2 = 16
	c0	cmpltu $b0.0 = $r0.6, 65536
	c0	mov $r0.5 = 4
;;
	c0	shl $r0.2 = $r0.6, $r0.2
;;
	c0	mfb $r0.7 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.6
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.5 = $r0.7, $r0.5
;;
;;
	c0	br $b0.0, LBB64_13
;;
## BB#12:                               ## %if.then.4.i.i.389
	c0	or $r0.5 = $r0.5, 8
	c0	mov $r0.7 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.7
	c0	zxtb $r0.5 = $r0.5
;;
LBB64_13:                               ## %countLeadingZeros32.exit.i.402
	c0	mov $r0.7 = 24
	c0	mov $r0.10 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.10, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.5
;;
	c0	shl $r0.2 = $r0.2, $r0.7
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	cmpgt $b0.0 = $r0.2, -1
	c0	shr $r0.2 = $r0.2, $r0.7
	c0	mov $r0.5 = 0
;;
;;
	c0	brf $b0.0, LBB64_14
;;
## BB#15:                               ## %if.else.i.409
	c0	shl $r0.7 = $r0.6, $r0.2
	c0	mov $r0.6 = $r0.5
	c0	mov $r0.5 = -31
	c0	goto LBB64_22
;;
LBB64_14:                               ## %if.then.5.i.407
	c0	and $r0.7 = $r0.2, 31
	c0	sub $r0.5 = $r0.5, $r0.2
;;
	c0	shl $r0.10 = $r0.6, $r0.7
	c0	shru $r0.7 = $r0.6, $r0.5
;;
	c0	mov $r0.6 = $r0.10
	c0	mov $r0.5 = -31
;;
LBB64_22:                               ## %if.end.28
	c0	sub $r0.2 = $r0.5, $r0.2
;;
LBB64_23:                               ## %if.end.28
	c0	cmpne $b0.0 = $r0.9, 0
;;
;;
	c0	brf $b0.0, LBB64_25
;;
## BB#24:
	c0	mov $r0.11 = $r0.4
	c0	goto LBB64_39
;;
LBB64_25:                               ## %if.then.30
	c0	or $r0.5 = $r0.8, $r0.4
;;
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	brf $b0.0, LBB64_89
;;
## BB#26:                               ## %if.end.34
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB64_27
;;
## BB#33:                               ## %if.else.14.i
	c0	cmpltu $b0.0 = $r0.8, 65536
	c0	mov $r0.5 = 16
	c0	mov $r0.9 = 4
;;
	c0	shl $r0.5 = $r0.3, $r0.5
;;
	c0	mfb $r0.10 = $b0.0
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.8
;;
	c0	cmpgtu $b0.0 = $r0.5, 16777215
	c0	shl $r0.9 = $r0.10, $r0.9
;;
;;
	c0	br $b0.0, LBB64_35
;;
## BB#34:                               ## %if.then.4.i.54.i
	c0	or $r0.9 = $r0.9, 8
	c0	mov $r0.10 = 8
;;
	c0	shl $r0.5 = $r0.5, $r0.10
	c0	zxtb $r0.9 = $r0.9
;;
LBB64_35:                               ## %countLeadingZeros32.exit64.i
	c0	mov $r0.10 = 24
	c0	mov $r0.11 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.5 = $r0.5, $r0.10
;;
	c0	add $r0.5 = $r0.11, $r0.5
;;
	c0	ldb $r0.5 = 0[$r0.5]
;;
;;
	c0	add $r0.5 = $r0.5, $r0.9
;;
	c0	shl $r0.5 = $r0.5, $r0.10
;;
	c0	add $r0.5 = $r0.5, -184549376
;;
	c0	shr $r0.5 = $r0.5, $r0.10
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB64_37
;;
## BB#36:                               ## %cond.false.i.i
	c0	mov $r0.9 = 0
	c0	shl $r0.8 = $r0.8, $r0.5
;;
	c0	sub $r0.9 = $r0.9, $r0.5
;;
	c0	and $r0.9 = $r0.9, 31
;;
	c0	shru $r0.9 = $r0.4, $r0.9
;;
	c0	or $r0.8 = $r0.9, $r0.8
;;
LBB64_37:                               ## %shortShift64Left.exit.i
	c0	mov $r0.9 = 1
	c0	shl $r0.11 = $r0.4, $r0.5
	c0	goto LBB64_38
;;
LBB64_27:                               ## %if.then.i
	c0	mov $r0.5 = 16
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.8 = 4
;;
	c0	shl $r0.5 = $r0.4, $r0.5
;;
	c0	mfb $r0.9 = $b0.0
	c0	slct $r0.5 = $b0.0, $r0.5, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.5, 16777215
	c0	shl $r0.8 = $r0.9, $r0.8
;;
;;
	c0	br $b0.0, LBB64_29
;;
## BB#28:                               ## %if.then.4.i.i
	c0	or $r0.8 = $r0.8, 8
	c0	mov $r0.9 = 8
;;
	c0	shl $r0.5 = $r0.5, $r0.9
	c0	zxtb $r0.8 = $r0.8
;;
LBB64_29:                               ## %countLeadingZeros32.exit.i
	c0	mov $r0.9 = 24
	c0	mov $r0.10 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.5 = $r0.5, $r0.9
;;
	c0	add $r0.5 = $r0.10, $r0.5
;;
	c0	ldb $r0.5 = 0[$r0.5]
;;
;;
	c0	add $r0.5 = $r0.5, $r0.8
;;
	c0	shl $r0.5 = $r0.5, $r0.9
;;
	c0	add $r0.5 = $r0.5, -184549376
;;
	c0	cmpgt $b0.0 = $r0.5, -1
	c0	shr $r0.5 = $r0.5, $r0.9
;;
;;
	c0	brf $b0.0, LBB64_30
;;
## BB#31:                               ## %if.else.i.375
	c0	mov $r0.11 = 0
	c0	shl $r0.8 = $r0.4, $r0.5
	c0	mov $r0.9 = -31
	c0	goto LBB64_38
;;
LBB64_30:                               ## %if.then.5.i
	c0	mov $r0.8 = 0
	c0	and $r0.9 = $r0.5, 31
;;
	c0	sub $r0.8 = $r0.8, $r0.5
	c0	shl $r0.11 = $r0.4, $r0.9
;;
	c0	shru $r0.8 = $r0.4, $r0.8
	c0	mov $r0.9 = -31
;;
LBB64_38:                               ## %if.end.35
	c0	sub $r0.9 = $r0.9, $r0.5
;;
LBB64_39:                               ## %if.end.35
	c0	sub $r0.9 = $r0.9, $r0.2
;;
	c0	cmpgt $b0.0 = $r0.9, -2
;;
;;
	c0	brf $b0.0, LBB64_89
;;
## BB#40:                               ## %if.end.38
	c0	mov $r0.4 = 31
	c0	mov $r0.10 = 11
	c0	mov $r0.20 = 0
	c0	mov $r0.5 = 21
;;
	c0	shru $r0.12 = $r0.9, $r0.4
	c0	shl $r0.13 = $r0.7, $r0.10
	c0	or $r0.8 = $r0.8, 1048576
;;
	c0	shru $r0.7 = $r0.6, $r0.5
	c0	sub $r0.12 = $r0.10, $r0.12
	c0	or $r0.5 = $r0.13, -2147483648
;;
	c0	shl $r0.18 = $r0.6, $r0.10
	c0	shl $r0.10 = $r0.11, $r0.12
	c0	shl $r0.13 = $r0.8, $r0.12
	c0	sub $r0.12 = $r0.20, $r0.12
;;
	c0	or $r0.8 = $r0.7, $r0.5
	c0	and $r0.12 = $r0.12, 23
;;
	c0	shru $r0.11 = $r0.11, $r0.12
;;
	c0	or $r0.11 = $r0.11, $r0.13
;;
	c0	cmpgtu $b0.0 = $r0.11, $r0.8
;;
;;
	c0	brf $b0.0, LBB64_42
;;
## BB#41:
	c0	mov $r0.20 = 1
	c0	goto LBB64_44
;;
LBB64_42:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.11, $r0.8
;;
;;
	c0	br $b0.0, LBB64_45
;;
## BB#43:                               ## %le64.exit
	c0	cmpgeu $b0.0 = $r0.10, $r0.18
	c0	cmpltu $b0.1 = $r0.10, $r0.18
;;
;;
	c0	mfb $r0.20 = $b0.0
	c0	br $b0.1, LBB64_45
;;
LBB64_44:                               ## %if.then.46
	c0	cmpltu $r0.12 = $r0.10, $r0.18
	c0	mov $r0.13 = -1
	c0	sub $r0.11 = $r0.11, $r0.8
	c0	sub $r0.10 = $r0.10, $r0.18
;;
	c0	mtb $b0.0 = $r0.12
;;
;;
	c0	slct $r0.12 = $b0.0, $r0.13, 0
;;
	c0	add $r0.11 = $r0.11, $r0.12
;;
LBB64_45:                               ## %if.end.47
	c0	cmplt $b0.0 = $r0.9, 33
	c0	add $r0.9 = $r0.9, -32
;;
;;
	c0	br $b0.0, LBB64_56
;;
## BB#46:                               ## %while.body.lr.ph
	c0	mov $r0.12 = 16
	c0	mov $r0.20 = 5
;;
	c0	shru $r0.13 = $r0.5, $r0.12
	c0	zxth $r0.14 = $r0.8
	c0	mov $r0.15 = 0
;;
	c0	mov $r0.16 = -65536
	c0	mov $r0.17 = -1
;;
	c0	and $r0.18 = $r0.18, 63488
	c0	mov $r0.19 = 65535
;;
	c0	shru $r0.20 = $r0.6, $r0.20
	c0	shl $r0.21 = $r0.8, $r0.12
	c0	cmplt $r0.22 = $r0.13, $r0.0
	c0	shl $r0.23 = $r0.13, $r0.12
;;
	c0	zxth $r0.24 = $r0.20
	c0	mtb $b0.0 = $r0.22
	c0	shru $r0.25 = $r0.13, $r0.22
;;
LBB64_47:                               ## %while.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB64_51 Depth 2
	c0	cmpleu $b0.1 = $r0.8, $r0.11
	c0	mov $r0.20 = $r0.17
;;
;;
	c0	br $b0.1, LBB64_55
;;
## BB#48:                               ## %if.end.i.296
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	cmpleu $b0.1 = $r0.23, $r0.11
	c0	mov $r0.20 = $r0.16
;;
;;
	c0	br $b0.1, LBB64_50
;;
## BB#49:                               ## %cond.false.i.299
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	shru $r0.20 = $r0.11, $r0.22
	c0	mtb $b0.1 = $r0.15
	c0	mtb $b0.2 = $r0.15
	c0	cmpgeu $r0.26 = $r0.11, $r0.13
;;
;;
	c0	addcg $r0.27, $b0.1 = $r0.20, $r0.20, $b0.1
;;
	c0	divs $r0.20, $b0.1 = $r0.0, $r0.25, $b0.1
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	addcg $r0.28, $b0.2 = $r0.27, $r0.27, $b0.2
	c0	divs $r0.20, $b0.1 = $r0.20, $r0.25, $b0.1
;;
	c0	divs $r0.20, $b0.2 = $r0.20, $r0.25, $b0.2
	c0	addcg $r0.27, $b0.1 = $r0.28, $r0.28, $b0.1
;;
	c0	cmpge $b0.1 = $r0.20, $r0.0
	c0	addcg $r0.20, $b0.2 = $r0.27, $r0.27, $b0.2
;;
	c0	orc $r0.20 = $r0.20, $r0.0
;;
	c0	mfb $r0.27 = $b0.1
;;
	c0	sh1add $r0.20 = $r0.20, $r0.27
;;
	c0	slct $r0.20 = $b0.0, $r0.26, $r0.20
;;
	c0	shl $r0.20 = $r0.20, $r0.12
;;
LBB64_50:                               ## %cond.end.i.314
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	shru $r0.26 = $r0.20, $r0.12
;;
	c0	mpylu $r0.27 = $r0.26, $r0.14
	c0	mpyhs $r0.28 = $r0.26, $r0.14
;;
	c0	mpylu $r0.29 = $r0.26, $r0.13
	c0	mpyhs $r0.26 = $r0.26, $r0.13
;;
	c0	add $r0.27 = $r0.27, $r0.28
;;
	c0	add $r0.26 = $r0.29, $r0.26
	c0	shl $r0.28 = $r0.27, $r0.12
	c0	shru $r0.27 = $r0.27, $r0.12
;;
	c0	sub $r0.29 = $r0.11, $r0.26
	c0	cmpltu $r0.30 = $r0.10, $r0.28
	c0	sub $r0.26 = $r0.10, $r0.28
;;
	c0	sub $r0.27 = $r0.29, $r0.27
	c0	mtb $b0.1 = $r0.30
;;
;;
	c0	slct $r0.28 = $b0.1, $r0.17, 0
;;
	c0	add $r0.27 = $r0.27, $r0.28
;;
	c0	cmpgt $b0.1 = $r0.27, -1
;;
;;
	c0	br $b0.1, LBB64_52
;;
LBB64_51:                               ## %while.body.i.327
                                        ##   Parent Loop BB64_47 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.26 = $r0.26, $r0.21
	c0	add $r0.27 = $r0.27, $r0.13
	c0	add $r0.20 = $r0.20, -65536
;;
	c0	cmpltu $r0.28 = $r0.26, $r0.21
;;
	c0	add $r0.27 = $r0.27, $r0.28
;;
	c0	cmplt $b0.1 = $r0.27, 0
;;
;;
	c0	br $b0.1, LBB64_51
;;
LBB64_52:                               ## %while.end.i.335
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	shl $r0.27 = $r0.27, $r0.12
	c0	shru $r0.28 = $r0.26, $r0.12
	c0	mov $r0.26 = $r0.19
;;
	c0	or $r0.27 = $r0.28, $r0.27
;;
	c0	cmpleu $b0.1 = $r0.23, $r0.27
;;
;;
	c0	br $b0.1, LBB64_54
;;
## BB#53:                               ## %cond.false.10.i.337
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	shru $r0.26 = $r0.27, $r0.22
	c0	mtb $b0.1 = $r0.15
	c0	mtb $b0.2 = $r0.15
	c0	cmpgeu $r0.27 = $r0.27, $r0.13
;;
;;
	c0	addcg $r0.28, $b0.1 = $r0.26, $r0.26, $b0.1
;;
	c0	divs $r0.26, $b0.1 = $r0.0, $r0.25, $b0.1
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	addcg $r0.29, $b0.2 = $r0.28, $r0.28, $b0.2
	c0	divs $r0.26, $b0.1 = $r0.26, $r0.25, $b0.1
;;
	c0	divs $r0.26, $b0.2 = $r0.26, $r0.25, $b0.2
	c0	addcg $r0.28, $b0.1 = $r0.29, $r0.29, $b0.1
;;
	c0	cmpge $b0.1 = $r0.26, $r0.0
	c0	addcg $r0.26, $b0.2 = $r0.28, $r0.28, $b0.2
;;
	c0	orc $r0.26 = $r0.26, $r0.0
;;
	c0	mfb $r0.28 = $b0.1
;;
	c0	sh1add $r0.26 = $r0.26, $r0.28
;;
	c0	slct $r0.26 = $b0.0, $r0.27, $r0.26
;;
LBB64_54:                               ## %cond.end.12.i.340
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	or $r0.20 = $r0.26, $r0.20
;;
LBB64_55:                               ## %estimateDiv64To32.exit342
                                        ##   in Loop: Header=BB64_47 Depth=1
	c0	cmpgtu $b0.2 = $r0.20, 4
	c0	add $r0.20 = $r0.20, -4
	c0	mov $r0.26 = 29
	c0	mov $r0.27 = 3
;;
	c0	shl $r0.11 = $r0.11, $r0.26
	c0	shru $r0.10 = $r0.10, $r0.27
	c0	cmpgt $b0.1 = $r0.9, 29
	c0	add $r0.9 = $r0.9, -29
;;
	c0	slct $r0.20 = $b0.2, $r0.20, 0
;;
	c0	zxth $r0.28 = $r0.20
	c0	shru $r0.29 = $r0.20, $r0.12
;;
	c0	mpylu $r0.30 = $r0.29, $r0.18
	c0	mpyhs $r0.31 = $r0.29, $r0.18
;;
	c0	mpyhs $r0.32 = $r0.28, $r0.13
	c0	mpylu $r0.33 = $r0.28, $r0.13
;;
	c0	mpylu $r0.34 = $r0.28, $r0.24
	c0	mpyhs $r0.35 = $r0.28, $r0.24
;;
	c0	mpylu $r0.36 = $r0.29, $r0.14
	c0	mpyhs $r0.37 = $r0.29, $r0.14
;;
	c0	mpyhs $r0.38 = $r0.28, $r0.18
	c0	mpylu $r0.39 = $r0.28, $r0.18
;;
	c0	mpylu $r0.40 = $r0.29, $r0.24
	c0	mpyhs $r0.41 = $r0.29, $r0.24
;;
	c0	mpylu $r0.42 = $r0.28, $r0.14
	c0	mpyhs $r0.28 = $r0.28, $r0.14
	c0	add $r0.32 = $r0.33, $r0.32
	c0	add $r0.30 = $r0.30, $r0.31
;;
	c0	add $r0.31 = $r0.34, $r0.35
	c0	add $r0.33 = $r0.36, $r0.37
	c0	mpyhs $r0.34 = $r0.29, $r0.13
	c0	add $r0.35 = $r0.39, $r0.38
;;
	c0	add $r0.31 = $r0.30, $r0.31
	c0	add $r0.32 = $r0.33, $r0.32
	c0	add $r0.28 = $r0.42, $r0.28
	c0	add $r0.33 = $r0.40, $r0.41
;;
	c0	cmpltu $r0.30 = $r0.31, $r0.30
	c0	shl $r0.36 = $r0.32, $r0.12
	c0	shru $r0.37 = $r0.31, $r0.12
	c0	shl $r0.31 = $r0.31, $r0.12
;;
	c0	shl $r0.30 = $r0.30, $r0.12
	c0	add $r0.28 = $r0.36, $r0.28
	c0	mpylu $r0.29 = $r0.29, $r0.13
	c0	add $r0.35 = $r0.31, $r0.35
;;
	c0	or $r0.30 = $r0.30, $r0.37
	c0	add $r0.33 = $r0.28, $r0.33
	c0	cmpltu $r0.31 = $r0.35, $r0.31
;;
	c0	add $r0.30 = $r0.33, $r0.30
;;
	c0	add $r0.30 = $r0.30, $r0.31
;;
	c0	cmpltu $b0.2 = $r0.30, $r0.28
	c0	or $r0.11 = $r0.11, $r0.10
	c0	add $r0.10 = $r0.29, $r0.34
	c0	shru $r0.29 = $r0.35, $r0.27
;;
	c0	shl $r0.31 = $r0.30, $r0.26
	c0	shru $r0.32 = $r0.32, $r0.12
;;
	c0	add $r0.10 = $r0.32, $r0.10
	c0	cmpltu $r0.28 = $r0.28, $r0.36
	c0	or $r0.29 = $r0.31, $r0.29
;;
	c0	add $r0.28 = $r0.10, $r0.28
	c0	shru $r0.27 = $r0.30, $r0.27
	c0	cmpne $r0.30 = $r0.29, 0
	c0	sub $r0.10 = $r0.15, $r0.29
;;
	c0	mfb $r0.29 = $b0.2
	c0	mtb $b0.2 = $r0.30
;;
	c0	add $r0.28 = $r0.28, $r0.29
;;
	c0	shl $r0.26 = $r0.28, $r0.26
	c0	slct $r0.28 = $b0.2, $r0.17, 0
;;
	c0	or $r0.26 = $r0.26, $r0.27
	c0	add $r0.11 = $r0.28, $r0.11
;;
	c0	sub $r0.11 = $r0.11, $r0.26
	c0	br $b0.1, LBB64_47
;;
LBB64_56:                               ## %while.end
	c0	cmplt $b0.0 = $r0.9, -31
;;
;;
	c0	br $b0.0, LBB64_79
;;
## BB#57:                               ## %if.then.58
	c0	cmpleu $b0.0 = $r0.8, $r0.11
;;
;;
	c0	br $b0.0, LBB64_58
;;
## BB#59:                               ## %if.end.i
	c0	mov $r0.15 = 16
;;
	c0	shru $r0.12 = $r0.5, $r0.15
;;
	c0	shl $r0.14 = $r0.12, $r0.15
;;
	c0	cmpleu $b0.0 = $r0.14, $r0.11
;;
;;
	c0	br $b0.0, LBB64_60
;;
## BB#61:                               ## %cond.false.i.216
	c0	cmplt $r0.13 = $r0.12, $r0.0
	c0	mov $r0.16 = 0
;;
	c0	shru $r0.17 = $r0.11, $r0.13
	c0	mtb $b0.0 = $r0.16
	c0	shru $r0.18 = $r0.12, $r0.13
	c0	mtb $b0.1 = $r0.16
;;
;;
	c0	addcg $r0.16, $b0.0 = $r0.17, $r0.17, $b0.0
;;
	c0	divs $r0.17, $b0.0 = $r0.0, $r0.18, $b0.0
	c0	addcg $r0.19, $b0.1 = $r0.16, $r0.16, $b0.1
;;
	c0	addcg $r0.16, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.17, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.2 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
	c0	mtb $b0.0 = $r0.13
;;
	c0	addcg $r0.13, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.18, $b0.2
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
	c0	addcg $r0.17, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	addcg $r0.13, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.18, $b0.2
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
	c0	addcg $r0.17, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	addcg $r0.13, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.18, $b0.2
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
	c0	addcg $r0.17, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	addcg $r0.13, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.18, $b0.2
	c0	cmpgeu $r0.17 = $r0.11, $r0.12
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
	c0	addcg $r0.18, $b0.2 = $r0.13, $r0.13, $b0.2
;;
	c0	cmpge $b0.2 = $r0.16, $r0.0
	c0	addcg $r0.13, $b0.1 = $r0.18, $r0.18, $b0.1
;;
	c0	orc $r0.13 = $r0.13, $r0.0
;;
	c0	mfb $r0.16 = $b0.2
;;
	c0	sh1add $r0.13 = $r0.13, $r0.16
;;
	c0	slct $r0.13 = $b0.0, $r0.17, $r0.13
;;
	c0	shl $r0.13 = $r0.13, $r0.15
	c0	goto LBB64_62
;;
LBB64_79:                               ## %if.else.73
	c0	mov $r0.9 = 3
	c0	mov $r0.5 = 8
	c0	mov $r0.12 = 24
;;
	c0	shru $r0.8 = $r0.8, $r0.5
	c0	shru $r0.10 = $r0.10, $r0.5
	c0	shl $r0.7 = $r0.7, $r0.12
	c0	shl $r0.12 = $r0.11, $r0.12
;;
	c0	shru $r0.5 = $r0.11, $r0.5
	c0	shl $r0.6 = $r0.6, $r0.9
;;
	c0	and $r0.9 = $r0.6, 16777208
	c0	or $r0.6 = $r0.12, $r0.10
;;
	c0	or $r0.7 = $r0.7, $r0.9
	c0	goto LBB64_80
;;
LBB64_58:
	c0	mov $r0.12 = -1
	c0	goto LBB64_69
;;
LBB64_60:
	c0	mov $r0.13 = -65536
;;
LBB64_62:                               ## %cond.end.i
	c0	shru $r0.16 = $r0.13, $r0.15
	c0	zxth $r0.17 = $r0.8
	c0	mov $r0.18 = -1
;;
	c0	mpylu $r0.19 = $r0.16, $r0.12
	c0	mpyhs $r0.20 = $r0.16, $r0.17
;;
	c0	mpylu $r0.17 = $r0.16, $r0.17
	c0	mpyhs $r0.16 = $r0.16, $r0.12
;;
;;
	c0	add $r0.17 = $r0.17, $r0.20
	c0	add $r0.16 = $r0.19, $r0.16
;;
	c0	shl $r0.19 = $r0.17, $r0.15
	c0	shru $r0.17 = $r0.17, $r0.15
	c0	sub $r0.20 = $r0.11, $r0.16
;;
	c0	cmpltu $r0.21 = $r0.10, $r0.19
	c0	sub $r0.16 = $r0.10, $r0.19
	c0	sub $r0.17 = $r0.20, $r0.17
;;
	c0	mtb $b0.0 = $r0.21
;;
;;
	c0	slct $r0.18 = $b0.0, $r0.18, 0
;;
	c0	add $r0.17 = $r0.17, $r0.18
;;
	c0	cmpgt $b0.0 = $r0.17, -1
;;
;;
	c0	br $b0.0, LBB64_65
;;
## BB#63:                               ## %while.body.lr.ph.i
	c0	shl $r0.18 = $r0.8, $r0.15
;;
LBB64_64:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.16 = $r0.16, $r0.18
	c0	add $r0.17 = $r0.17, $r0.12
	c0	add $r0.13 = $r0.13, -65536
;;
	c0	cmpltu $r0.19 = $r0.16, $r0.18
;;
	c0	add $r0.17 = $r0.17, $r0.19
;;
	c0	cmplt $b0.0 = $r0.17, 0
;;
;;
	c0	br $b0.0, LBB64_64
;;
LBB64_65:                               ## %while.end.i
	c0	shl $r0.17 = $r0.17, $r0.15
	c0	shru $r0.15 = $r0.16, $r0.15
;;
	c0	or $r0.15 = $r0.15, $r0.17
;;
	c0	cmpleu $b0.0 = $r0.14, $r0.15
;;
;;
	c0	br $b0.0, LBB64_66
;;
## BB#67:                               ## %cond.false.10.i
	c0	cmplt $r0.14 = $r0.12, $r0.0
	c0	mov $r0.16 = 0
;;
	c0	shru $r0.17 = $r0.15, $r0.14
	c0	mtb $b0.0 = $r0.16
	c0	shru $r0.18 = $r0.12, $r0.14
	c0	mtb $b0.1 = $r0.16
;;
;;
	c0	addcg $r0.16, $b0.0 = $r0.17, $r0.17, $b0.0
;;
	c0	divs $r0.17, $b0.0 = $r0.0, $r0.18, $b0.0
	c0	addcg $r0.19, $b0.1 = $r0.16, $r0.16, $b0.1
;;
	c0	addcg $r0.16, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.17, $b0.1 = $r0.17, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.17, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.0 = $r0.16, $r0.18, $b0.0
;;
	c0	addcg $r0.17, $b0.0 = $r0.19, $r0.19, $b0.0
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.18, $b0.0
	c0	mtb $b0.0 = $r0.14
;;
	c0	addcg $r0.14, $b0.2 = $r0.19, $r0.19, $b0.2
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.18, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.16, $r0.18, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.18, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.17, $r0.17, $b0.2
;;
	c0	addcg $r0.17, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.18, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.18, $b0.1
	c0	cmpgeu $r0.12 = $r0.15, $r0.12
	c0	addcg $r0.15, $b0.2 = $r0.17, $r0.17, $b0.2
;;
	c0	cmpge $b0.2 = $r0.14, $r0.0
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
;;
	c0	orc $r0.14 = $r0.14, $r0.0
;;
	c0	mfb $r0.15 = $b0.2
;;
	c0	sh1add $r0.14 = $r0.14, $r0.15
;;
	c0	slct $r0.12 = $b0.0, $r0.12, $r0.14
	c0	goto LBB64_68
;;
LBB64_66:
	c0	mov $r0.12 = 65535
;;
LBB64_68:                               ## %cond.end.12.i
	c0	or $r0.12 = $r0.12, $r0.13
;;
LBB64_69:                               ## %estimateDiv64To32.exit
	c0	mov $r0.13 = 3
	c0	cmpgtu $b0.0 = $r0.12, 4
	c0	add $r0.15 = $r0.12, -4
	c0	mov $r0.12 = 0
;;
	c0	shl $r0.13 = $r0.6, $r0.13
	c0	mov $r0.14 = 24
	c0	cmpgt $b0.1 = $r0.9, -25
	c0	mov $r0.6 = 8
;;
	c0	sub $r0.16 = $r0.12, $r0.9
	c0	shl $r0.7 = $r0.7, $r0.14
	c0	shru $r0.8 = $r0.8, $r0.6
;;
	c0	and $r0.6 = $r0.13, 16777208
	c0	slct $r0.15 = $b0.0, $r0.15, 0
;;
	c0	or $r0.7 = $r0.7, $r0.6
	c0	shru $r0.20 = $r0.15, $r0.16
	c0	br $b0.1, LBB64_75
;;
## BB#70:                               ## %if.then.70
	c0	mov $r0.6 = -24
;;
	c0	sub $r0.6 = $r0.6, $r0.9
;;
	c0	cmpeq $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB64_71
;;
## BB#72:                               ## %if.else.i
	c0	cmpgt $b0.0 = $r0.6, 31
;;
;;
	c0	br $b0.0, LBB64_74
;;
## BB#73:                               ## %if.then.4.i
	c0	sub $r0.9 = $r0.12, $r0.6
	c0	shru $r0.10 = $r0.10, $r0.6
	c0	shru $r0.12 = $r0.11, $r0.6
;;
	c0	and $r0.6 = $r0.9, 31
;;
	c0	shl $r0.6 = $r0.11, $r0.6
;;
	c0	or $r0.6 = $r0.6, $r0.10
	c0	goto LBB64_78
;;
LBB64_75:                               ## %if.else
	c0	add $r0.12 = $r0.9, 24
;;
	c0	cmpeq $b0.0 = $r0.12, 0
	c0	shl $r0.6 = $r0.10, $r0.12
;;
;;
	c0	br $b0.0, LBB64_76
;;
## BB#77:                               ## %cond.false.i
	c0	mov $r0.15 = -24
	c0	shl $r0.11 = $r0.11, $r0.12
;;
	c0	sub $r0.9 = $r0.15, $r0.9
;;
	c0	and $r0.9 = $r0.9, 31
;;
	c0	shru $r0.9 = $r0.10, $r0.9
;;
	c0	or $r0.12 = $r0.9, $r0.11
	c0	goto LBB64_78
;;
LBB64_71:
	c0	mov $r0.6 = $r0.10
	c0	mov $r0.12 = $r0.11
	c0	goto LBB64_78
;;
LBB64_76:
	c0	mov $r0.12 = $r0.11
	c0	goto LBB64_78
;;
LBB64_74:                               ## %if.else.7.i
	c0	and $r0.9 = $r0.6, 31
	c0	cmplt $b0.0 = $r0.6, 64
;;
	c0	shru $r0.6 = $r0.11, $r0.9
;;
	c0	slct $r0.6 = $b0.0, $r0.6, 0
;;
LBB64_78:                               ## %if.end.72
	c0	mov $r0.9 = 16
	c0	and $r0.10 = $r0.13, 65528
	c0	zxth $r0.11 = $r0.20
;;
	c0	shru $r0.5 = $r0.5, $r0.14
	c0	shru $r0.13 = $r0.7, $r0.9
	c0	shru $r0.14 = $r0.20, $r0.9
	c0	zxth $r0.15 = $r0.8
;;
	c0	mpylu $r0.16 = $r0.11, $r0.10
	c0	mpylu $r0.17 = $r0.14, $r0.10
;;
	c0	mpyhs $r0.18 = $r0.14, $r0.10
	c0	mpylu $r0.19 = $r0.11, $r0.13
;;
	c0	mpyhs $r0.21 = $r0.11, $r0.13
	c0	mpyhs $r0.10 = $r0.11, $r0.10
;;
	c0	add $r0.17 = $r0.17, $r0.18
;;
	c0	add $r0.18 = $r0.19, $r0.21
	c0	mpyhs $r0.19 = $r0.14, $r0.15
;;
	c0	add $r0.18 = $r0.17, $r0.18
	c0	mpylu $r0.21 = $r0.14, $r0.15
	c0	mpyhs $r0.22 = $r0.11, $r0.5
;;
	c0	mpylu $r0.5 = $r0.11, $r0.5
	c0	mpyhs $r0.23 = $r0.11, $r0.15
;;
	c0	mpylu $r0.11 = $r0.11, $r0.15
	c0	mpyhs $r0.15 = $r0.14, $r0.13
;;
	c0	mpylu $r0.13 = $r0.14, $r0.13
	c0	shl $r0.14 = $r0.18, $r0.9
	c0	add $r0.10 = $r0.16, $r0.10
;;
	c0	add $r0.10 = $r0.14, $r0.10
;;
	c0	cmpltu $r0.14 = $r0.10, $r0.14
;;
	c0	mtb $b0.0 = $r0.14
	c0	mov $r0.14 = -1
	c0	add $r0.11 = $r0.11, $r0.23
	c0	add $r0.5 = $r0.5, $r0.22
;;
	c0	add $r0.13 = $r0.13, $r0.15
	c0	add $r0.15 = $r0.21, $r0.19
;;
	c0	add $r0.11 = $r0.13, $r0.11
	c0	add $r0.5 = $r0.15, $r0.5
	c0	cmpltu $r0.13 = $r0.18, $r0.17
	c0	shru $r0.15 = $r0.18, $r0.9
;;
	c0	shl $r0.5 = $r0.5, $r0.9
	c0	shl $r0.9 = $r0.13, $r0.9
;;
	c0	add $r0.5 = $r0.11, $r0.5
	c0	cmpltu $r0.11 = $r0.6, $r0.10
	c0	sub $r0.6 = $r0.6, $r0.10
	c0	or $r0.9 = $r0.9, $r0.15
;;
	c0	mtb $b0.1 = $r0.11
	c0	add $r0.5 = $r0.5, $r0.9
	c0	mfb $r0.9 = $b0.0
;;
;;
	c0	slct $r0.10 = $b0.1, $r0.14, 0
	c0	sub $r0.5 = $r0.9, $r0.5
;;
	c0	add $r0.5 = $r0.5, $r0.12
;;
	c0	add $r0.5 = $r0.5, $r0.10
;;
LBB64_80:                               ## %do.body.preheader
	c0	shru $r0.3 = $r0.3, $r0.4
	c0	mov $r0.9 = -1
;;
LBB64_81:                               ## %do.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	mov $r0.10 = $r0.6
	c0	mov $r0.11 = $r0.5
;;
	c0	cmpltu $r0.5 = $r0.10, $r0.7
	c0	sub $r0.12 = $r0.11, $r0.8
;;
	c0	mtb $b0.0 = $r0.5
	c0	add $r0.20 = $r0.20, 1
	c0	sub $r0.6 = $r0.10, $r0.7
;;
;;
	c0	slct $r0.5 = $b0.0, $r0.9, 0
;;
	c0	add $r0.5 = $r0.12, $r0.5
;;
	c0	cmpgt $b0.0 = $r0.5, -1
;;
;;
	c0	br $b0.0, LBB64_81
;;
## BB#82:                               ## %do.end
	c0	add $r0.7 = $r0.6, $r0.10
	c0	add $r0.8 = $r0.5, $r0.11
;;
	c0	cmpltu $r0.12 = $r0.7, $r0.6
;;
	c0	add $r0.8 = $r0.8, $r0.12
;;
	c0	cmplt $b0.0 = $r0.8, 0
;;
;;
	c0	br $b0.0, LBB64_85
;;
## BB#83:                               ## %lor.lhs.false.79
	c0	and $r0.12 = $r0.20, 1
;;
	c0	cmpeq $b0.0 = $r0.12, 0
;;
;;
	c0	br $b0.0, LBB64_86
;;
## BB#84:                               ## %lor.lhs.false.79
	c0	or $r0.7 = $r0.8, $r0.7
;;
	c0	cmpne $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB64_86
;;
LBB64_85:                               ## %if.then.85
	c0	mov $r0.6 = $r0.10
	c0	mov $r0.5 = $r0.11
;;
LBB64_86:                               ## %if.end.86
	c0	shru $r0.7 = $r0.5, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB64_88
;;
## BB#87:                               ## %if.then.91
	c0	cmpne $r0.4 = $r0.6, 0
	c0	mov $r0.8 = 0
;;
	c0	mtb $b0.0 = $r0.4
	c0	sub $r0.6 = $r0.8, $r0.6
;;
;;
	c0	slct $r0.4 = $b0.0, $r0.9, 0
;;
	c0	sub $r0.5 = $r0.4, $r0.5
;;
LBB64_88:                               ## %if.end.92
	c0	add $r0.4 = $r0.2, -4
	c0	xor $r0.3 = $r0.7, $r0.3
;;
.call normalizeRoundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = normalizeRoundAndPackFloat64
;;
LBB64_89:                               ## %cleanup
	c0	mov $r0.2 = 0
;;
LBB64_90:                               ## %cleanup
	c0	or $r0.4 = $r0.4, $r0.2
	c0	ldw $l0.0 = 28[$r0.1]
;;
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @normalizeRoundAndPackFloat64
normalizeRoundAndPackFloat64::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $l0.0
	c0	mov $r0.2 = 16
	c0	cmpeq $b0.0 = $r0.5, 0
	c0	mov $r0.8 = 4
;;
;;
	c0	slct $r0.5 = $b0.0, $r0.6, $r0.5
;;
	c0	cmpltu $b0.1 = $r0.5, 65536
	c0	shl $r0.2 = $r0.5, $r0.2
;;
;;
	c0	slct $r0.9 = $b0.1, $r0.2, $r0.5
	c0	mfb $r0.10 = $b0.1
;;
	c0	cmpgtu $b0.1 = $r0.9, 16777215
	c0	mov $r0.7 = 0
	c0	add $r0.2 = $r0.4, -32
;;
	c0	shl $r0.8 = $r0.10, $r0.8
;;
	c0	br $b0.1, LBB65_2
;;
## BB#1:                                ## %if.then.4.i
	c0	or $r0.8 = $r0.8, 8
	c0	mov $r0.10 = 8
;;
	c0	shl $r0.9 = $r0.9, $r0.10
	c0	zxtb $r0.8 = $r0.8
;;
LBB65_2:                                ## %countLeadingZeros32.exit
	c0	mov $r0.10 = 24
	c0	mov $r0.11 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.9 = $r0.9, $r0.10
;;
	c0	add $r0.9 = $r0.11, $r0.9
;;
	c0	ldb $r0.9 = 0[$r0.9]
;;
;;
	c0	add $r0.8 = $r0.9, $r0.8
;;
	c0	shl $r0.8 = $r0.8, $r0.10
;;
	c0	add $r0.9 = $r0.8, -184549376
	c0	slct $r0.8 = $b0.0, $r0.7, $r0.6
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.4
;;
	c0	cmplt $b0.0 = $r0.9, -16777215
	c0	shr $r0.4 = $r0.9, $r0.10
;;
;;
	c0	br $b0.0, LBB65_5
;;
## BB#3:                                ## %if.then.6
	c0	cmpeq $b0.0 = $r0.4, 0
	c0	shl $r0.6 = $r0.8, $r0.4
;;
;;
	c0	br $b0.0, LBB65_15
;;
## BB#4:                                ## %cond.false.i
	c0	mov $r0.7 = 0
	c0	shl $r0.5 = $r0.5, $r0.4
;;
	c0	sub $r0.9 = $r0.7, $r0.4
;;
	c0	and $r0.9 = $r0.9, 31
;;
	c0	shru $r0.8 = $r0.8, $r0.9
;;
	c0	or $r0.5 = $r0.8, $r0.5
	c0	goto LBB65_15
;;
LBB65_5:                                ## %if.else
	c0	cmpeq $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB65_6
;;
## BB#7:                                ## %if.else.i
	c0	cmplt $b0.0 = $r0.9, -536870911
	c0	and $r0.6 = $r0.4, 31
	c0	sub $r0.10 = $r0.7, $r0.4
;;
;;
	c0	br $b0.0, LBB65_9
;;
## BB#8:                                ## %if.then.4.i.29
	c0	shru $r0.11 = $r0.8, $r0.10
	c0	shl $r0.12 = $r0.5, $r0.6
	c0	shl $r0.9 = $r0.8, $r0.6
	c0	shru $r0.7 = $r0.5, $r0.10
;;
	c0	mov $r0.8 = 0
	c0	or $r0.5 = $r0.12, $r0.11
	c0	goto LBB65_14
;;
LBB65_6:
	c0	mov $r0.6 = $r0.8
	c0	goto LBB65_15
;;
LBB65_9:                                ## %if.else.9.i
	c0	cmpeq $b0.0 = $r0.10, 32
	c0	mov $r0.7 = 0
;;
;;
	c0	brf $b0.0, LBB65_11
;;
## BB#10:
	c0	mov $r0.9 = $r0.8
	c0	mov $r0.8 = $r0.7
	c0	goto LBB65_14
;;
LBB65_11:                               ## %if.else.13.i
	c0	cmplt $b0.0 = $r0.9, -1073741823
;;
;;
	c0	br $b0.0, LBB65_13
;;
## BB#12:                               ## %if.then.17.i
	c0	and $r0.10 = $r0.10, 31
	c0	shl $r0.9 = $r0.5, $r0.6
;;
	c0	shru $r0.5 = $r0.5, $r0.10
	c0	goto LBB65_14
;;
LBB65_13:                               ## %if.else.22.i
	c0	cmpne $b0.0 = $r0.5, 0
	c0	cmpeq $b0.1 = $r0.10, 64
	c0	mov $r0.7 = 0
;;
;;
	c0	mfb $r0.6 = $b0.0
;;
	c0	slct $r0.9 = $b0.1, $r0.5, $r0.6
	c0	mov $r0.5 = $r0.7
;;
LBB65_14:                               ## %if.end.28.i
	c0	cmpne $b0.0 = $r0.8, 0
	c0	mov $r0.6 = $r0.5
	c0	mov $r0.5 = $r0.7
;;
;;
	c0	mfb $r0.7 = $b0.0
;;
	c0	or $r0.7 = $r0.7, $r0.9
;;
LBB65_15:                               ## %if.end.10
	c0	sub $r0.4 = $r0.2, $r0.4
	c0	ldw $l0.0 = 28[$r0.1]
	c0	add $r0.1 = $r0.1, 32
;;
.call roundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = roundAndPackFloat64
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_sqrt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_sqrt
float64_sqrt::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $r0.57
;;
	c0	stw 24[$r0.1] = $l0.0
	c0	mov $r0.2 = 20
	c0	mov $r0.6 = 31
;;
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	and $r0.5 = $r0.2, 2047
;;
	c0	cmpne $b0.0 = $r0.5, 2047
	c0	and $r0.8 = $r0.3, 1048575
;;
	c0	shru $r0.2 = $r0.3, $r0.6
;;
	c0	br $b0.0, LBB66_5
;;
## BB#1:                                ## %if.then
	c0	or $r0.5 = $r0.8, $r0.4
;;
	c0	cmpeq $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB66_3
;;
## BB#2:                                ## %if.then.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.6 = $r0.4
;;
.call propagateFloat64NaN, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = propagateFloat64NaN
;;
	c0	mov $r0.5 = $r0.4
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.57 = 0
	c0	goto LBB66_59
;;
LBB66_5:                                ## %if.end.9
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB66_8
;;
## BB#6:                                ## %if.then.11
	c0	or $r0.2 = $r0.8, $r0.4
;;
	c0	or $r0.2 = $r0.2, $r0.5
;;
LBB66_3:                                ## %if.end
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB66_4
;;
## BB#7:                                ## %invalid
	c0	mov $r0.3 = float_exception_flags
	c0	mov $r0.57 = 0
;;
	c0	ldb $r0.4 = 0[$r0.3]
	c0	mov $r0.2 = -524288
	c0	mov $r0.5 = $r0.57
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
	c0	stb 0[$r0.3] = $r0.4
	c0	goto LBB66_59
;;
LBB66_8:                                ## %if.end.17
	c0	cmpne $b0.0 = $r0.5, 0
;;
;;
	c0	br $b0.0, LBB66_23
;;
## BB#9:                                ## %if.then.19
	c0	or $r0.7 = $r0.8, $r0.4
	c0	mov $r0.2 = 0
;;
	c0	mov $r0.57 = $r0.2
	c0	mov $r0.5 = $r0.2
	c0	cmpeq $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB66_59
;;
## BB#10:                               ## %if.end.24
	c0	cmpne $b0.0 = $r0.8, 0
;;
;;
	c0	brf $b0.0, LBB66_11
;;
## BB#17:                               ## %if.else.14.i
	c0	cmpltu $b0.0 = $r0.8, 65536
	c0	mov $r0.2 = 16
	c0	mov $r0.5 = 4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	mfb $r0.3 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.8
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.3 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB66_19
;;
## BB#18:                               ## %if.then.4.i.54.i
	c0	or $r0.3 = $r0.3, 8
	c0	mov $r0.5 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.5
	c0	zxtb $r0.3 = $r0.3
;;
LBB66_19:                               ## %countLeadingZeros32.exit64.i
	c0	mov $r0.5 = 24
	c0	mov $r0.7 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.7, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
	c0	shl $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	shr $r0.2 = $r0.2, $r0.5
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB66_21
;;
## BB#20:                               ## %cond.false.i.i
	c0	mov $r0.3 = 0
	c0	shl $r0.5 = $r0.8, $r0.2
;;
	c0	sub $r0.3 = $r0.3, $r0.2
;;
	c0	and $r0.3 = $r0.3, 31
;;
	c0	shru $r0.3 = $r0.4, $r0.3
;;
	c0	or $r0.8 = $r0.3, $r0.5
;;
LBB66_21:                               ## %shortShift64Left.exit.i
	c0	mov $r0.3 = 1
	c0	shl $r0.4 = $r0.4, $r0.2
	c0	goto LBB66_22
;;
LBB66_4:                                ## %if.then.7
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.57 = 0
	c0	goto LBB66_58
;;
LBB66_11:                               ## %if.then.i.255
	c0	mov $r0.2 = 16
	c0	cmpltu $b0.0 = $r0.4, 65536
	c0	mov $r0.3 = 4
;;
	c0	shl $r0.2 = $r0.4, $r0.2
;;
	c0	mfb $r0.5 = $b0.0
	c0	slct $r0.2 = $b0.0, $r0.2, $r0.4
;;
	c0	cmpgtu $b0.0 = $r0.2, 16777215
	c0	shl $r0.3 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB66_13
;;
## BB#12:                               ## %if.then.4.i.i
	c0	or $r0.3 = $r0.3, 8
	c0	mov $r0.5 = 8
;;
	c0	shl $r0.2 = $r0.2, $r0.5
	c0	zxtb $r0.3 = $r0.3
;;
LBB66_13:                               ## %countLeadingZeros32.exit.i
	c0	mov $r0.5 = 24
	c0	mov $r0.7 = countLeadingZeros32.countLeadingZerosHigh
;;
	c0	shru $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.7, $r0.2
;;
	c0	ldb $r0.2 = 0[$r0.2]
;;
;;
	c0	add $r0.2 = $r0.2, $r0.3
;;
	c0	shl $r0.2 = $r0.2, $r0.5
;;
	c0	add $r0.2 = $r0.2, -184549376
;;
	c0	cmpgt $b0.0 = $r0.2, -1
	c0	shr $r0.2 = $r0.2, $r0.5
	c0	mov $r0.3 = 0
;;
;;
	c0	brf $b0.0, LBB66_14
;;
## BB#15:                               ## %if.else.i.260
	c0	shl $r0.8 = $r0.4, $r0.2
	c0	mov $r0.4 = $r0.3
	c0	mov $r0.3 = -31
	c0	goto LBB66_22
;;
LBB66_14:                               ## %if.then.5.i
	c0	and $r0.5 = $r0.2, 31
	c0	sub $r0.3 = $r0.3, $r0.2
;;
	c0	shl $r0.5 = $r0.4, $r0.5
	c0	shru $r0.8 = $r0.4, $r0.3
;;
	c0	mov $r0.4 = $r0.5
	c0	mov $r0.3 = -31
;;
LBB66_22:                               ## %if.end.25
	c0	sub $r0.5 = $r0.3, $r0.2
;;
LBB66_23:                               ## %if.end.25
	c0	and $r0.9 = $r0.5, 1
	c0	mov $r0.2 = 16
	c0	mov $r0.10 = 21
;;
	c0	or $r0.7 = $r0.8, 1048576
	c0	mov $r0.11 = 6
	c0	mov $r0.12 = 11
;;
	c0	mov $r0.3 = 1
	c0	add $r0.5 = $r0.5, -1023
	c0	shru $r0.13 = $r0.4, $r0.10
;;
	c0	cmpeq $b0.0 = $r0.9, 0
	c0	shru $r0.8 = $r0.8, $r0.2
	c0	shru $r0.11 = $r0.7, $r0.11
	c0	shl $r0.12 = $r0.7, $r0.12
;;
	c0	and $r0.10 = $r0.8, 15
	c0	and $r0.11 = $r0.11, 32767
	c0	or $r0.8 = $r0.13, $r0.12
;;
	c0	brf $b0.0, LBB66_24
;;
## BB#27:                               ## %if.else.i
	c0	mov $r0.12 = estimateSqrt32.sqrtEvenAdjustments
	c0	or $r0.11 = $r0.11, 32768
;;
	c0	mov $r0.13 = 0
	c0	sh1add $r0.10 = $r0.10, $r0.12
;;
	c0	mtb $b0.0 = $r0.13
	c0	mtb $b0.1 = $r0.13
	c0	ldhu $r0.10 = 0[$r0.10]
;;
;;
	c0	sub $r0.10 = $r0.11, $r0.10
;;
	c0	cmplt $r0.11 = $r0.10, $r0.0
;;
	c0	shru $r0.12 = $r0.8, $r0.11
	c0	shru $r0.13 = $r0.10, $r0.11
;;
	c0	addcg $r0.14, $b0.0 = $r0.12, $r0.12, $b0.0
;;
	c0	addcg $r0.12, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.0, $r0.13, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.12, $r0.12, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.14, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.14, $r0.14, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.14, $r0.14, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.14, $r0.14, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.12, $b0.2 = $r0.12, $r0.13, $b0.0
	c0	mtb $b0.0 = $r0.11
;;
	c0	divs $r0.11, $b0.1 = $r0.12, $r0.13, $b0.1
	c0	addcg $r0.12, $b0.2 = $r0.14, $r0.14, $b0.2
;;
	c0	addcg $r0.14, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.12, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.12, $r0.12, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
	c0	cmpgeu $r0.12 = $r0.8, $r0.10
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
;;
	c0	addcg $r0.14, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	addcg $r0.15, $b0.2 = $r0.14, $r0.14, $b0.2
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	mov $r0.14 = 15
;;
	c0	addcg $r0.16, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	addcg $r0.16, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.11, $b0.2 = $r0.11, $r0.13, $b0.2
;;
	c0	divs $r0.11, $b0.1 = $r0.11, $r0.13, $b0.1
	c0	addcg $r0.13, $b0.2 = $r0.16, $r0.16, $b0.2
;;
	c0	cmpge $b0.2 = $r0.11, $r0.0
	c0	addcg $r0.11, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	orc $r0.11 = $r0.11, $r0.0
;;
	c0	mfb $r0.13 = $b0.2
;;
	c0	sh1add $r0.11 = $r0.11, $r0.13
;;
	c0	slct $r0.11 = $b0.0, $r0.12, $r0.11
	c0	mov $r0.12 = -32768
;;
	c0	add $r0.10 = $r0.10, $r0.11
;;
	c0	cmpgtu $b0.0 = $r0.10, 131071
	c0	shl $r0.10 = $r0.10, $r0.14
;;
;;
	c0	slct $r0.10 = $b0.0, $r0.12, $r0.10
;;
	c0	cmpgtu $b0.0 = $r0.10, $r0.8
;;
;;
	c0	br $b0.0, LBB66_25
;;
## BB#28:                               ## %if.then.19.i
	c0	shr $r0.8 = $r0.8, $r0.3
	c0	goto LBB66_40
;;
LBB66_24:                               ## %if.then.i
	c0	mov $r0.12 = estimateSqrt32.sqrtOddAdjustments
	c0	add $r0.11 = $r0.11, 16384
;;
	c0	mov $r0.13 = 0
	c0	sh1add $r0.10 = $r0.10, $r0.12
;;
	c0	mtb $b0.0 = $r0.13
	c0	mtb $b0.1 = $r0.13
	c0	ldhu $r0.10 = 0[$r0.10]
;;
;;
	c0	sub $r0.10 = $r0.11, $r0.10
;;
	c0	cmplt $r0.11 = $r0.10, $r0.0
;;
	c0	shru $r0.12 = $r0.8, $r0.11
	c0	shru $r0.13 = $r0.10, $r0.11
;;
	c0	addcg $r0.14, $b0.0 = $r0.12, $r0.12, $b0.0
;;
	c0	divs $r0.12, $b0.0 = $r0.0, $r0.13, $b0.0
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
	c0	mov $r0.15 = 14
;;
	c0	addcg $r0.16, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
	c0	mov $r0.14 = 15
;;
	c0	divs $r0.12, $b0.1 = $r0.12, $r0.13, $b0.1
	c0	addcg $r0.17, $b0.0 = $r0.16, $r0.16, $b0.0
	c0	cmpgeu $r0.16 = $r0.8, $r0.10
	c0	shl $r0.10 = $r0.10, $r0.14
;;
	c0	addcg $r0.14, $b0.1 = $r0.17, $r0.17, $b0.1
	c0	divs $r0.12, $b0.0 = $r0.12, $r0.13, $b0.0
	c0	mtb $b0.2 = $r0.11
	c0	shru $r0.8 = $r0.8, $r0.3
;;
	c0	divs $r0.11, $b0.1 = $r0.12, $r0.13, $b0.1
;;
	c0	cmpge $b0.3 = $r0.11, $r0.0
	c0	addcg $r0.11, $b0.0 = $r0.14, $r0.14, $b0.0
;;
	c0	addcg $r0.12, $b0.0 = $r0.11, $r0.11, $b0.1
;;
	c0	orc $r0.11 = $r0.12, $r0.0
	c0	mfb $r0.12 = $b0.3
;;
	c0	sh1add $r0.11 = $r0.11, $r0.12
;;
	c0	slct $r0.11 = $b0.2, $r0.16, $r0.11
;;
	c0	shl $r0.11 = $r0.11, $r0.15
;;
	c0	add $r0.10 = $r0.10, $r0.11
;;
LBB66_25:                               ## %if.end.21.i
	c0	cmpleu $b0.0 = $r0.10, $r0.8
;;
;;
	c0	br $b0.0, LBB66_26
;;
## BB#29:                               ## %if.end.i.200
	c0	shru $r0.11 = $r0.10, $r0.2
;;
	c0	shl $r0.13 = $r0.11, $r0.2
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.8
;;
;;
	c0	br $b0.0, LBB66_30
;;
## BB#31:                               ## %cond.false.i.203
	c0	cmplt $r0.12 = $r0.11, $r0.0
	c0	mov $r0.14 = 0
;;
	c0	shru $r0.15 = $r0.8, $r0.12
	c0	mtb $b0.0 = $r0.14
	c0	shru $r0.16 = $r0.11, $r0.12
	c0	mtb $b0.1 = $r0.14
;;
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
;;
	c0	divs $r0.15, $b0.0 = $r0.0, $r0.16, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.15, $b0.1 = $r0.15, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.15, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.2 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	mtb $b0.0 = $r0.12
;;
	c0	addcg $r0.12, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.2
	c0	cmpgeu $r0.15 = $r0.8, $r0.11
;;
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
	c0	addcg $r0.16, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	cmpge $b0.2 = $r0.14, $r0.0
	c0	addcg $r0.12, $b0.1 = $r0.16, $r0.16, $b0.1
;;
	c0	orc $r0.12 = $r0.12, $r0.0
;;
	c0	mfb $r0.14 = $b0.2
;;
	c0	sh1add $r0.12 = $r0.12, $r0.14
;;
	c0	slct $r0.12 = $b0.0, $r0.15, $r0.12
;;
	c0	shl $r0.12 = $r0.12, $r0.2
	c0	goto LBB66_32
;;
LBB66_26:
	c0	mov $r0.8 = 2147483647
	c0	goto LBB66_39
;;
LBB66_30:
	c0	mov $r0.12 = -65536
;;
LBB66_32:                               ## %cond.end.i.218
	c0	shru $r0.14 = $r0.12, $r0.2
	c0	zxth $r0.15 = $r0.10
	c0	mov $r0.16 = -1
;;
	c0	mpyhs $r0.17 = $r0.14, $r0.11
	c0	mpyhs $r0.18 = $r0.14, $r0.15
;;
	c0	mpylu $r0.15 = $r0.14, $r0.15
	c0	mpylu $r0.14 = $r0.14, $r0.11
;;
;;
	c0	add $r0.15 = $r0.15, $r0.18
	c0	mov $r0.18 = 0
	c0	add $r0.14 = $r0.14, $r0.17
;;
	c0	shl $r0.17 = $r0.15, $r0.2
	c0	shru $r0.15 = $r0.15, $r0.2
	c0	sub $r0.14 = $r0.8, $r0.14
;;
	c0	cmpne $r0.19 = $r0.17, 0
	c0	sub $r0.8 = $r0.18, $r0.17
	c0	sub $r0.14 = $r0.14, $r0.15
;;
	c0	mtb $b0.0 = $r0.19
;;
;;
	c0	slct $r0.15 = $b0.0, $r0.16, 0
;;
	c0	add $r0.14 = $r0.14, $r0.15
;;
	c0	cmpgt $b0.0 = $r0.14, -1
;;
;;
	c0	br $b0.0, LBB66_35
;;
## BB#33:                               ## %while.body.lr.ph.i.220
	c0	shl $r0.15 = $r0.10, $r0.2
;;
LBB66_34:                               ## %while.body.i.231
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.8 = $r0.8, $r0.15
	c0	add $r0.14 = $r0.14, $r0.11
	c0	add $r0.12 = $r0.12, -65536
;;
	c0	cmpltu $r0.16 = $r0.8, $r0.15
;;
	c0	add $r0.14 = $r0.14, $r0.16
;;
	c0	cmplt $b0.0 = $r0.14, 0
;;
;;
	c0	br $b0.0, LBB66_34
;;
LBB66_35:                               ## %while.end.i.239
	c0	shl $r0.14 = $r0.14, $r0.2
	c0	shru $r0.8 = $r0.8, $r0.2
;;
	c0	or $r0.8 = $r0.8, $r0.14
;;
	c0	cmpleu $b0.0 = $r0.13, $r0.8
;;
;;
	c0	br $b0.0, LBB66_36
;;
## BB#37:                               ## %cond.false.10.i.241
	c0	cmplt $r0.13 = $r0.11, $r0.0
	c0	mov $r0.14 = 0
;;
	c0	shru $r0.15 = $r0.8, $r0.13
	c0	mtb $b0.0 = $r0.14
	c0	shru $r0.16 = $r0.11, $r0.13
	c0	mtb $b0.1 = $r0.14
;;
;;
	c0	addcg $r0.14, $b0.0 = $r0.15, $r0.15, $b0.0
;;
	c0	divs $r0.15, $b0.0 = $r0.0, $r0.16, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.15, $b0.1 = $r0.15, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.15, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.0 = $r0.14, $r0.16, $b0.0
;;
	c0	addcg $r0.15, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.15, $r0.15, $b0.1
	c0	divs $r0.14, $b0.2 = $r0.14, $r0.16, $b0.0
	c0	mtb $b0.0 = $r0.13
;;
	c0	addcg $r0.13, $b0.2 = $r0.17, $r0.17, $b0.2
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.16, $b0.1
;;
	c0	addcg $r0.15, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.14, $r0.16, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.16, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	addcg $r0.15, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.16, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.16, $b0.1
	c0	cmpgeu $r0.8 = $r0.8, $r0.11
	c0	addcg $r0.11, $b0.2 = $r0.15, $r0.15, $b0.2
;;
	c0	cmpge $b0.2 = $r0.13, $r0.0
	c0	addcg $r0.13, $b0.1 = $r0.11, $r0.11, $b0.1
;;
	c0	orc $r0.11 = $r0.13, $r0.0
;;
	c0	mfb $r0.13 = $b0.2
;;
	c0	sh1add $r0.11 = $r0.11, $r0.13
;;
	c0	slct $r0.8 = $b0.0, $r0.8, $r0.11
	c0	goto LBB66_38
;;
LBB66_36:
	c0	mov $r0.8 = 65535
;;
LBB66_38:                               ## %cond.end.12.i.244
	c0	or $r0.8 = $r0.8, $r0.12
;;
	c0	shru $r0.8 = $r0.8, $r0.3
;;
LBB66_39:                               ## %estimateDiv64To32.exit246
	c0	shru $r0.10 = $r0.10, $r0.3
;;
	c0	add $r0.8 = $r0.8, $r0.10
;;
LBB66_40:                               ## %estimateSqrt32.exit
	c0	shru $r0.8 = $r0.8, $r0.3
	c0	mov $r0.11 = 9
	c0	mov $r0.10 = 17
	c0	mov $r0.57 = 0
;;
	c0	add $r0.8 = $r0.8, 1
	c0	sub $r0.11 = $r0.11, $r0.9
	c0	mov $r0.9 = 15
	c0	mov $r0.14 = -1
;;
	c0	shru $r0.12 = $r0.8, $r0.2
	c0	zxth $r0.13 = $r0.8
	c0	sub $r0.15 = $r0.57, $r0.11
	c0	shl $r0.16 = $r0.4, $r0.11
;;
	c0	mpyhs $r0.17 = $r0.12, $r0.13
	c0	mpylu $r0.18 = $r0.12, $r0.13
	c0	and $r0.15 = $r0.15, 31
	c0	shl $r0.7 = $r0.7, $r0.11
;;
	c0	mpylu $r0.11 = $r0.13, $r0.13
	c0	mpyhs $r0.13 = $r0.13, $r0.13
	c0	shru $r0.15 = $r0.4, $r0.15
;;
	c0	mpyhs $r0.19 = $r0.12, $r0.12
	c0	add $r0.17 = $r0.18, $r0.17
;;
	c0	shl $r0.4 = $r0.17, $r0.10
	c0	add $r0.11 = $r0.11, $r0.13
	c0	mpylu $r0.12 = $r0.12, $r0.12
	c0	shl $r0.13 = $r0.17, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.13, $r0.17
	c0	add $r0.11 = $r0.4, $r0.11
;;
	c0	cmpltu $r0.4 = $r0.11, $r0.4
	c0	cmpltu $r0.13 = $r0.16, $r0.11
;;
	c0	mtb $b0.1 = $r0.4
	c0	mtb $b0.2 = $r0.13
	c0	shr $r0.4 = $r0.5, $r0.3
	c0	shl $r0.5 = $r0.8, $r0.3
;;
	c0	or $r0.7 = $r0.15, $r0.7
	c0	add $r0.12 = $r0.12, $r0.19
	c0	shru $r0.13 = $r0.17, $r0.9
;;
	c0	sub $r0.12 = $r0.7, $r0.12
	c0	zxth $r0.13 = $r0.13
	c0	sub $r0.7 = $r0.16, $r0.11
	c0	mfb $r0.11 = $b0.0
;;
	c0	shl $r0.11 = $r0.11, $r0.2
	c0	mfb $r0.15 = $b0.1
	c0	slct $r0.16 = $b0.2, $r0.14, 0
;;
	c0	or $r0.11 = $r0.11, $r0.13
	c0	add $r0.12 = $r0.12, $r0.15
;;
	c0	add $r0.12 = $r0.12, $r0.16
;;
	c0	sub $r0.11 = $r0.12, $r0.11
;;
	c0	cmpgt $b0.0 = $r0.11, -1
;;
;;
	c0	br $b0.0, LBB66_42
;;
LBB66_41:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.12 = $r0.5, -1
;;
	c0	add $r0.7 = $r0.12, $r0.7
	c0	add $r0.8 = $r0.8, -1
	c0	add $r0.5 = $r0.5, -2
;;
	c0	cmpltu $r0.12 = $r0.7, $r0.12
;;
	c0	add $r0.11 = $r0.12, $r0.11
;;
	c0	cmplt $b0.0 = $r0.11, 0
;;
;;
	c0	br $b0.0, LBB66_41
;;
LBB66_42:                               ## %while.end
	c0	cmpleu $b0.0 = $r0.5, $r0.7
	c0	add $r0.4 = $r0.4, 1022
;;
;;
	c0	br $b0.0, LBB66_57
;;
## BB#43:                               ## %if.end.i
	c0	shru $r0.11 = $r0.5, $r0.2
;;
	c0	shl $r0.16 = $r0.11, $r0.2
;;
	c0	cmpleu $b0.0 = $r0.16, $r0.7
;;
;;
	c0	br $b0.0, LBB66_44
;;
## BB#45:                               ## %cond.false.i
	c0	cmplt $r0.12 = $r0.11, $r0.0
	c0	mov $r0.13 = 0
;;
	c0	shru $r0.14 = $r0.7, $r0.12
	c0	mtb $b0.0 = $r0.13
	c0	shru $r0.15 = $r0.11, $r0.12
	c0	mtb $b0.1 = $r0.13
;;
;;
	c0	addcg $r0.13, $b0.0 = $r0.14, $r0.14, $b0.0
;;
	c0	divs $r0.14, $b0.0 = $r0.0, $r0.15, $b0.0
	c0	addcg $r0.17, $b0.1 = $r0.13, $r0.13, $b0.1
;;
	c0	addcg $r0.13, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.14, $b0.1 = $r0.14, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.13, $r0.13, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.14, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.0 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
;;
	c0	addcg $r0.17, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.0 = $r0.13, $r0.15, $b0.0
;;
	c0	addcg $r0.14, $b0.2 = $r0.17, $r0.17, $b0.0
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
	c0	mtb $b0.0 = $r0.12
;;
	c0	addcg $r0.12, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.15, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.15, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.15, $b0.2
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
	c0	addcg $r0.14, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	addcg $r0.12, $b0.1 = $r0.14, $r0.14, $b0.1
	c0	divs $r0.13, $b0.2 = $r0.13, $r0.15, $b0.2
	c0	cmpgeu $r0.14 = $r0.7, $r0.11
;;
	c0	divs $r0.13, $b0.1 = $r0.13, $r0.15, $b0.1
	c0	addcg $r0.15, $b0.2 = $r0.12, $r0.12, $b0.2
;;
	c0	cmpge $b0.2 = $r0.13, $r0.0
	c0	addcg $r0.12, $b0.1 = $r0.15, $r0.15, $b0.1
;;
	c0	orc $r0.12 = $r0.12, $r0.0
;;
	c0	mfb $r0.13 = $b0.2
;;
	c0	sh1add $r0.12 = $r0.12, $r0.13
;;
	c0	slct $r0.12 = $b0.0, $r0.14, $r0.12
;;
	c0	shl $r0.14 = $r0.12, $r0.2
	c0	goto LBB66_46
;;
LBB66_44:
	c0	mov $r0.14 = -65536
;;
LBB66_46:                               ## %cond.end.i
	c0	shru $r0.13 = $r0.14, $r0.2
	c0	and $r0.15 = $r0.5, 65534
	c0	mov $r0.12 = -1
;;
	c0	mpyhs $r0.17 = $r0.13, $r0.11
	c0	mpyhs $r0.18 = $r0.13, $r0.15
;;
	c0	mpylu $r0.19 = $r0.13, $r0.15
	c0	mpylu $r0.20 = $r0.13, $r0.11
;;
;;
	c0	add $r0.18 = $r0.19, $r0.18
	c0	mov $r0.13 = 0
	c0	add $r0.17 = $r0.20, $r0.17
;;
	c0	shl $r0.19 = $r0.18, $r0.2
	c0	shru $r0.18 = $r0.18, $r0.2
	c0	sub $r0.20 = $r0.7, $r0.17
;;
	c0	cmpne $r0.21 = $r0.19, 0
	c0	sub $r0.17 = $r0.13, $r0.19
	c0	sub $r0.18 = $r0.20, $r0.18
;;
	c0	mtb $b0.0 = $r0.21
;;
;;
	c0	slct $r0.19 = $b0.0, $r0.12, 0
;;
	c0	add $r0.18 = $r0.18, $r0.19
;;
	c0	cmpgt $b0.0 = $r0.18, -1
;;
;;
	c0	br $b0.0, LBB66_49
;;
## BB#47:                               ## %while.body.lr.ph.i
	c0	shl $r0.19 = $r0.5, $r0.2
;;
LBB66_48:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.17 = $r0.17, $r0.19
	c0	add $r0.18 = $r0.18, $r0.11
	c0	add $r0.14 = $r0.14, -65536
;;
	c0	cmpltu $r0.20 = $r0.17, $r0.19
;;
	c0	add $r0.18 = $r0.18, $r0.20
;;
	c0	cmplt $b0.0 = $r0.18, 0
;;
;;
	c0	br $b0.0, LBB66_48
;;
LBB66_49:                               ## %while.end.i
	c0	shl $r0.18 = $r0.18, $r0.2
	c0	shru $r0.17 = $r0.17, $r0.2
;;
	c0	or $r0.17 = $r0.17, $r0.18
;;
	c0	cmpleu $b0.0 = $r0.16, $r0.17
;;
;;
	c0	br $b0.0, LBB66_50
;;
## BB#51:                               ## %cond.false.10.i
	c0	cmplt $r0.16 = $r0.11, $r0.0
	c0	mov $r0.18 = 0
;;
	c0	shru $r0.19 = $r0.17, $r0.16
	c0	mtb $b0.0 = $r0.18
	c0	shru $r0.20 = $r0.11, $r0.16
	c0	mtb $b0.1 = $r0.18
;;
;;
	c0	addcg $r0.18, $b0.0 = $r0.19, $r0.19, $b0.0
;;
	c0	divs $r0.19, $b0.0 = $r0.0, $r0.20, $b0.0
	c0	addcg $r0.21, $b0.1 = $r0.18, $r0.18, $b0.1
;;
	c0	addcg $r0.18, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.19, $b0.1 = $r0.19, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.19, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.0 = $r0.18, $r0.20, $b0.0
;;
	c0	addcg $r0.19, $b0.0 = $r0.21, $r0.21, $b0.0
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.21, $b0.1 = $r0.19, $r0.19, $b0.1
	c0	divs $r0.18, $b0.2 = $r0.18, $r0.20, $b0.0
	c0	mtb $b0.0 = $r0.16
;;
	c0	addcg $r0.16, $b0.2 = $r0.21, $r0.21, $b0.2
	c0	divs $r0.18, $b0.1 = $r0.18, $r0.20, $b0.1
;;
	c0	addcg $r0.19, $b0.1 = $r0.16, $r0.16, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.18, $r0.20, $b0.2
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.20, $b0.1
	c0	addcg $r0.18, $b0.2 = $r0.19, $r0.19, $b0.2
;;
	c0	addcg $r0.19, $b0.1 = $r0.18, $r0.18, $b0.1
	c0	divs $r0.16, $b0.2 = $r0.16, $r0.20, $b0.2
;;
	c0	divs $r0.16, $b0.1 = $r0.16, $r0.20, $b0.1
	c0	cmpgeu $r0.17 = $r0.17, $r0.11
	c0	addcg $r0.18, $b0.2 = $r0.19, $r0.19, $b0.2
;;
	c0	cmpge $b0.2 = $r0.16, $r0.0
	c0	addcg $r0.16, $b0.1 = $r0.18, $r0.18, $b0.1
;;
	c0	orc $r0.16 = $r0.16, $r0.0
;;
	c0	mfb $r0.18 = $b0.2
;;
	c0	sh1add $r0.16 = $r0.16, $r0.18
;;
	c0	slct $r0.16 = $b0.0, $r0.17, $r0.16
	c0	goto LBB66_52
;;
LBB66_50:
	c0	mov $r0.16 = 65535
;;
LBB66_52:                               ## %estimateDiv64To32.exit
	c0	or $r0.14 = $r0.16, $r0.14
;;
	c0	and $r0.16 = $r0.14, 510
;;
	c0	cmpgtu $b0.0 = $r0.16, 5
;;
;;
	c0	br $b0.0, LBB66_57
;;
## BB#53:                               ## %if.then.41
	c0	cmpeq $b0.0 = $r0.14, 0
;;
;;
	c0	slct $r0.16 = $b0.0, $r0.3, $r0.14
;;
	c0	zxth $r0.17 = $r0.16
	c0	shru $r0.18 = $r0.16, $r0.2
;;
	c0	mpylu $r0.19 = $r0.18, $r0.17
	c0	mpyhs $r0.20 = $r0.18, $r0.17
;;
	c0	mpylu $r0.21 = $r0.17, $r0.11
	c0	mpylu $r0.22 = $r0.18, $r0.15
;;
	c0	mpyhs $r0.23 = $r0.18, $r0.15
	c0	mpylu $r0.24 = $r0.17, $r0.17
;;
	c0	mpyhs $r0.25 = $r0.17, $r0.17
	c0	mpyhs $r0.26 = $r0.17, $r0.15
;;
	c0	mpylu $r0.15 = $r0.17, $r0.15
	c0	mpyhs $r0.27 = $r0.18, $r0.18
;;
	c0	mpylu $r0.28 = $r0.18, $r0.18
	c0	mpyhs $r0.17 = $r0.17, $r0.11
	c0	add $r0.19 = $r0.19, $r0.20
;;
	c0	shl $r0.3 = $r0.19, $r0.3
;;
	c0	cmpltu $b0.0 = $r0.3, $r0.19
	c0	mpyhs $r0.3 = $r0.18, $r0.11
	c0	mpylu $r0.11 = $r0.18, $r0.11
	c0	add $r0.17 = $r0.21, $r0.17
;;
	c0	add $r0.18 = $r0.22, $r0.23
	c0	add $r0.20 = $r0.24, $r0.25
	c0	add $r0.15 = $r0.15, $r0.26
	c0	shl $r0.10 = $r0.19, $r0.10
;;
	c0	add $r0.17 = $r0.18, $r0.17
	c0	add $r0.21 = $r0.28, $r0.27
	c0	shru $r0.9 = $r0.19, $r0.9
;;
	c0	shl $r0.19 = $r0.17, $r0.2
	c0	add $r0.20 = $r0.10, $r0.20
	c0	zxth $r0.9 = $r0.9
;;
	c0	cmpltu $r0.10 = $r0.20, $r0.10
	c0	cmpne $b0.1 = $r0.20, 0
	c0	add $r0.15 = $r0.19, $r0.15
;;
	c0	cmpltu $r0.19 = $r0.15, $r0.19
	c0	sub $r0.22 = $r0.13, $r0.15
	c0	cmpne $r0.15 = $r0.15, 0
	c0	mfb $r0.23 = $b0.0
;;
	c0	add $r0.10 = $r0.10, $r0.21
	c0	shl $r0.21 = $r0.23, $r0.2
	c0	mtb $b0.0 = $r0.19
	c0	mtb $b0.2 = $r0.15
;;
	c0	or $r0.9 = $r0.21, $r0.9
;;
	c0	add $r0.9 = $r0.10, $r0.9
;;
	c0	cmpgtu $r0.10 = $r0.9, $r0.22
;;
	c0	mtb $b0.3 = $r0.10
	c0	add $r0.3 = $r0.11, $r0.3
;;
	c0	sub $r0.7 = $r0.7, $r0.3
	c0	shru $r0.10 = $r0.17, $r0.2
	c0	cmpltu $r0.11 = $r0.17, $r0.18
	c0	sub $r0.3 = $r0.13, $r0.20
;;
	c0	shl $r0.2 = $r0.11, $r0.2
;;
	c0	or $r0.2 = $r0.2, $r0.10
	c0	mfb $r0.10 = $b0.1
;;
	c0	sub $r0.2 = $r0.7, $r0.2
	c0	mfb $r0.7 = $b0.0
	c0	slct $r0.11 = $b0.2, $r0.12, 0
	c0	sub $r0.9 = $r0.22, $r0.9
;;
	c0	add $r0.7 = $r0.2, $r0.7
	c0	cmpltu $r0.13 = $r0.9, $r0.10
	c0	sub $r0.2 = $r0.9, $r0.10
;;
	c0	add $r0.7 = $r0.7, $r0.11
	c0	mtb $b0.0 = $r0.13
	c0	slct $r0.9 = $b0.3, $r0.12, 0
;;
;;
	c0	slct $r0.10 = $b0.0, $r0.12, 0
	c0	add $r0.7 = $r0.7, $r0.9
;;
	c0	add $r0.7 = $r0.7, $r0.10
;;
	c0	cmpgt $b0.0 = $r0.7, -1
;;
;;
	c0	br $b0.0, LBB66_56
;;
## BB#54:                               ## %while.body.47.preheader
	c0	maxu $r0.9 = $r0.14, 1
;;
	c0	sh1add $r0.9 = $r0.9, $r0.12
;;
LBB66_55:                               ## %while.body.47
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.16 = $r0.16, -1
	c0	add $r0.3 = $r0.9, $r0.3
;;
	c0	shru $r0.10 = $r0.16, $r0.6
;;
	c0	or $r0.10 = $r0.10, $r0.5
	c0	cmpltu $r0.11 = $r0.3, $r0.9
;;
	c0	add $r0.2 = $r0.10, $r0.2
	c0	add $r0.9 = $r0.9, -2
;;
	c0	cmpltu $r0.10 = $r0.2, $r0.10
	c0	add $r0.2 = $r0.11, $r0.2
;;
	c0	add $r0.7 = $r0.10, $r0.7
	c0	cmpltu $r0.10 = $r0.2, $r0.11
;;
	c0	add $r0.7 = $r0.7, $r0.10
;;
	c0	cmplt $b0.0 = $r0.7, 0
;;
;;
	c0	br $b0.0, LBB66_55
;;
LBB66_56:                               ## %while.end.51
	c0	or $r0.2 = $r0.2, $r0.7
;;
	c0	or $r0.2 = $r0.2, $r0.3
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	or $r0.14 = $r0.2, $r0.16
;;
LBB66_57:                               ## %if.end.56
	c0	mov $r0.2 = 22
	c0	mov $r0.5 = 10
	c0	mov $r0.3 = $r0.57
;;
	c0	shru $r0.6 = $r0.14, $r0.5
	c0	shru $r0.5 = $r0.8, $r0.5
	c0	shl $r0.7 = $r0.14, $r0.2
	c0	shl $r0.2 = $r0.8, $r0.2
;;
	c0	or $r0.6 = $r0.6, $r0.2
;;
.call roundAndPackFloat64, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = roundAndPackFloat64
;;
	c0	mov $r0.2 = $r0.3
;;
LBB66_58:                               ## %cleanup
	c0	mov $r0.5 = $r0.4
;;
LBB66_59:                               ## %cleanup
	c0	or $r0.4 = $r0.5, $r0.57
	c0	mov $r0.3 = $r0.2
	c0	ldw $l0.0 = 24[$r0.1]
;;
	c0	ldw $r0.57 = 28[$r0.1]
;;
;;
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl float64_eq
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_eq
float64_eq::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_4
;;
LBB67_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_13
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_13
;;
LBB67_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_7
;;
## BB#5:                                ## %land.rhs.i.100
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB67_12
;;
## BB#6:                                ## %land.rhs.i.100
	c0	and $r0.2 = $r0.3, 524287
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_12
;;
LBB67_7:                                ## %lor.lhs.false.12
	c0	and $r0.2 = $r0.5, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB67_8
;;
## BB#9:                                ## %land.rhs.i
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB67_12
;;
## BB#10:                               ## %land.rhs.i
	c0	and $r0.2 = $r0.5, 524287
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB67_12
;;
## BB#11:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB67_13:                               ## %if.end.17
	c0	cmpne $b0.0 = $r0.4, $r0.6
	c0	mov $r0.2 = 0
;;
;;
	c0	br $b0.0, LBB67_18
;;
## BB#14:                               ## %land.rhs
	c0	cmpeq $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB67_16
;;
## BB#15:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB67_12:                               ## %if.then.16
	c0	mov $r0.3 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.3]
	c0	mov $r0.2 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.3] = $r0.4
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB67_8:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB67_16:                               ## %lor.rhs
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB67_18
;;
## BB#17:                               ## %land.rhs.27
	c0	or $r0.2 = $r0.5, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
LBB67_18:                               ## %return
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_le
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_le
float64_le::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB68_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB68_4
;;
LBB68_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB68_5
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB68_5
;;
LBB68_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB68_6
;;
## BB#9:                                ## %if.end.26
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB68_15
;;
## BB#10:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB68_12
;;
## BB#11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_6:                                ## %if.then.15
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB68_8
;;
## BB#7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_15:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB68_17
;;
## BB#16:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_8:                                ## %lor.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_12:                               ## %lor.rhs.i.111
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB68_13
;;
## BB#14:                               ## %land.rhs.i.114
	c0	cmpleu $b0.0 = $r0.6, $r0.4
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_17:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB68_18
;;
## BB#19:                               ## %land.rhs.i
	c0	cmpleu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_13:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB68_18:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_lt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_lt
float64_lt::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_4
;;
LBB69_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_5
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_5
;;
LBB69_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB69_6
;;
## BB#9:                                ## %if.end.26
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_15
;;
## BB#10:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB69_12
;;
## BB#11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_6:                                ## %if.then.15
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB69_7
;;
## BB#8:                                ## %land.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_15:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB69_17
;;
## BB#16:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_12:                               ## %lor.rhs.i.111
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB69_13
;;
## BB#14:                               ## %land.rhs.i.114
	c0	cmpltu $b0.0 = $r0.6, $r0.4
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_17:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB69_18
;;
## BB#19:                               ## %land.rhs.i
	c0	cmpltu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_13:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB69_18:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_eq_signaling
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_eq_signaling
float64_eq_signaling::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB70_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB70_4
;;
LBB70_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB70_5
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB70_5
;;
LBB70_4:                                ## %if.then
	c0	mov $r0.3 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.3]
	c0	mov $r0.2 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.3] = $r0.4
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB70_5:                                ## %if.end
	c0	cmpne $b0.0 = $r0.4, $r0.6
	c0	mov $r0.2 = 0
;;
;;
	c0	br $b0.0, LBB70_10
;;
## BB#6:                                ## %land.rhs
	c0	cmpeq $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB70_8
;;
## BB#7:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB70_8:                                ## %lor.rhs
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB70_10
;;
## BB#9:                                ## %land.rhs.16
	c0	or $r0.2 = $r0.5, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
LBB70_10:                               ## %return
.return ret($r0.3:u32)
	c0	mov $r0.3 = $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_le_quiet
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_le_quiet
float64_le_quiet::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_4
;;
LBB71_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_13
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_13
;;
LBB71_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_7
;;
## BB#5:                                ## %land.rhs.i.155
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB71_12
;;
## BB#6:                                ## %land.rhs.i.155
	c0	and $r0.2 = $r0.3, 524287
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_12
;;
LBB71_7:                                ## %lor.lhs.false.12
	c0	and $r0.2 = $r0.5, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_8
;;
## BB#9:                                ## %land.rhs.i.148
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB71_12
;;
## BB#10:                               ## %land.rhs.i.148
	c0	and $r0.2 = $r0.5, 524287
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB71_12
;;
## BB#11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_13:                               ## %if.end.17
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB71_14
;;
## BB#17:                               ## %if.end.35
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB71_23
;;
## BB#18:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB71_20
;;
## BB#19:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_14:                               ## %if.then.24
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB71_16
;;
## BB#15:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_12:                               ## %if.then.16
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_8:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_23:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB71_25
;;
## BB#24:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_16:                               ## %lor.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_20:                               ## %lor.rhs.i.138
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB71_21
;;
## BB#22:                               ## %land.rhs.i.141
	c0	cmpleu $b0.0 = $r0.6, $r0.4
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_25:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB71_26
;;
## BB#27:                               ## %land.rhs.i
	c0	cmpleu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_21:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB71_26:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_lt_quiet
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_lt_quiet
float64_lt_quiet::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_4
;;
LBB72_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_13
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_13
;;
LBB72_4:                                ## %if.then
	c0	and $r0.2 = $r0.3, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_7
;;
## BB#5:                                ## %land.rhs.i.155
	c0	cmpne $b0.0 = $r0.4, 0
;;
;;
	c0	br $b0.0, LBB72_12
;;
## BB#6:                                ## %land.rhs.i.155
	c0	and $r0.2 = $r0.3, 524287
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_12
;;
LBB72_7:                                ## %lor.lhs.false.12
	c0	and $r0.2 = $r0.5, 2146959360
;;
	c0	xor $r0.2 = $r0.2, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_8
;;
## BB#9:                                ## %land.rhs.i.148
	c0	cmpne $b0.0 = $r0.6, 0
;;
;;
	c0	br $b0.0, LBB72_12
;;
## BB#10:                               ## %land.rhs.i.148
	c0	and $r0.2 = $r0.5, 524287
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB72_12
;;
## BB#11:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_13:                               ## %if.end.17
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB72_14
;;
## BB#17:                               ## %if.end.35
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_23
;;
## BB#18:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB72_20
;;
## BB#19:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_14:                               ## %if.then.24
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB72_15
;;
## BB#16:                               ## %land.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_12:                               ## %if.then.16
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_8:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_23:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB72_25
;;
## BB#24:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_15:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_20:                               ## %lor.rhs.i.138
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB72_21
;;
## BB#22:                               ## %land.rhs.i.141
	c0	cmpltu $b0.0 = $r0.6, $r0.4
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_25:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB72_26
;;
## BB#27:                               ## %land.rhs.i
	c0	cmpltu $b0.0 = $r0.4, $r0.6
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_21:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB72_26:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_gt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_gt
float32_gt::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB73_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB73_4
;;
LBB73_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB73_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB73_5
;;
LBB73_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB73_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB73_6
;;
## BB#9:                                ## %if.end.18
	c0	cmpgtu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 0
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB73_6:                                ## %if.then.12
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB73_7
;;
## BB#8:                                ## %land.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB73_7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float32_ge
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float32_ge
float32_ge::
## BB#0:                                ## %entry
	c0	and $r0.2 = $r0.3, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB74_2
;;
## BB#1:                                ## %entry
	c0	and $r0.2 = $r0.3, 8388607
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB74_4
;;
LBB74_2:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 2139095040
;;
	c0	cmpne $b0.0 = $r0.2, 2139095040
;;
;;
	c0	br $b0.0, LBB74_5
;;
## BB#3:                                ## %lor.lhs.false
	c0	and $r0.2 = $r0.4, 8388607
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB74_5
;;
LBB74_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
	c0	mov $r0.3 = 0
;;
	c0	ldb $r0.4 = 0[$r0.2]
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB74_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.5 = $r0.4, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.5
;;
;;
	c0	brf $b0.0, LBB74_6
;;
## BB#9:                                ## %if.end.18
	c0	cmpgtu $b0.0 = $r0.3, $r0.4
	c0	cmpeq $b0.1 = $r0.3, $r0.4
	c0	mov $r0.3 = 1
;;
;;
	c0	mfb $r0.4 = $b0.0
;;
	c0	cmpne $b0.0 = $r0.2, $r0.4
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	slct $r0.3 = $b0.1, $r0.3, $r0.2
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB74_6:                                ## %if.then.12
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB74_8
;;
## BB#7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB74_8:                                ## %lor.rhs
	c0	or $r0.2 = $r0.4, $r0.3
;;
	c0	and $r0.2 = $r0.2, 2147483647
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_gt
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_gt
float64_gt::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_4
;;
LBB75_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_5
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_5
;;
LBB75_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB75_6
;;
## BB#9:                                ## %if.end.26
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_15
;;
## BB#10:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB75_12
;;
## BB#11:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_6:                                ## %if.then.15
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB75_7
;;
## BB#8:                                ## %land.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_15:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB75_17
;;
## BB#16:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_12:                               ## %lor.rhs.i.113
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB75_13
;;
## BB#14:                               ## %land.rhs.i.116
	c0	cmpleu $b0.0 = $r0.6, $r0.4
	c0	goto LBB75_20
;;
LBB75_17:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB75_18
;;
## BB#19:                               ## %land.rhs.i
	c0	cmpleu $b0.0 = $r0.4, $r0.6
;;
LBB75_20:                               ## %cond.end
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_13:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB75_18:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

#.globl float64_ge
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @float64_ge
float64_ge::
## BB#0:                                ## %entry
	c0	andc $r0.2 = $r0.3, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB76_2
;;
## BB#1:                                ## %land.lhs.true
	c0	and $r0.2 = $r0.3, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.4
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB76_4
;;
LBB76_2:                                ## %lor.lhs.false
	c0	andc $r0.2 = $r0.5, 2146435072
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB76_5
;;
## BB#3:                                ## %land.lhs.true.5
	c0	and $r0.2 = $r0.5, 1048575
;;
	c0	or $r0.2 = $r0.2, $r0.6
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB76_5
;;
LBB76_4:                                ## %if.then
	c0	mov $r0.2 = float_exception_flags
;;
	c0	ldb $r0.4 = 0[$r0.2]
	c0	mov $r0.3 = 0
;;
;;
	c0	or $r0.4 = $r0.4, 1
;;
.return ret($r0.3:u32)
	c0	stb 0[$r0.2] = $r0.4
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_5:                                ## %if.end
	c0	mov $r0.2 = 31
;;
	c0	shru $r0.7 = $r0.5, $r0.2
	c0	shru $r0.2 = $r0.3, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, $r0.7
;;
;;
	c0	brf $b0.0, LBB76_6
;;
## BB#9:                                ## %if.end.26
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB76_15
;;
## BB#10:                               ## %cond.true
	c0	cmpltu $b0.0 = $r0.5, $r0.3
;;
;;
	c0	brf $b0.0, LBB76_12
;;
## BB#11:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_6:                                ## %if.then.15
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	brf $b0.0, LBB76_8
;;
## BB#7:
.return ret($r0.3:u32)
	c0	mov $r0.3 = 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_15:                               ## %cond.false
	c0	cmpltu $b0.0 = $r0.3, $r0.5
;;
;;
	c0	brf $b0.0, LBB76_17
;;
## BB#16:
	c0	mov $r0.2 = 1
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_8:                                ## %lor.rhs
	c0	mov $r0.2 = 1
	c0	or $r0.3 = $r0.5, $r0.3
	c0	or $r0.4 = $r0.6, $r0.4
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	or $r0.2 = $r0.4, $r0.2
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
.return ret($r0.3:u32)
	c0	mfb $r0.3 = $b0.0
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_12:                               ## %lor.rhs.i.113
	c0	cmpne $b0.0 = $r0.5, $r0.3
;;
;;
	c0	br $b0.0, LBB76_13
;;
## BB#14:                               ## %land.rhs.i.116
	c0	cmpltu $b0.0 = $r0.6, $r0.4
	c0	goto LBB76_20
;;
LBB76_17:                               ## %lor.rhs.i
	c0	cmpne $b0.0 = $r0.3, $r0.5
;;
;;
	c0	br $b0.0, LBB76_18
;;
## BB#19:                               ## %land.rhs.i
	c0	cmpltu $b0.0 = $r0.4, $r0.6
;;
LBB76_20:                               ## %cond.end
	c0	mfb $r0.2 = $b0.0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_13:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
LBB76_18:
	c0	mov $r0.2 = 0
;;
.return ret($r0.3:u32)
	c0	xor $r0.3 = $r0.2, 1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

	.section	.bss .section .data
#.globl float_rounding_mode             ## @float_rounding_mode
float_rounding_mode:
	.data1	0                       ## 0x0

#.globl float_exception_flags           ## @float_exception_flags
float_exception_flags:
	.data1	0                       ## 0x0

#.globl float_detect_tininess           ## @float_detect_tininess
float_detect_tininess:
	.data1	0                       ## 0x0

	.section	.data 
countLeadingZeros32.countLeadingZerosHigh: ## @countLeadingZeros32.countLeadingZerosHigh
	.data1 8
	.data1 7
	.data1 6
	.data1 6
	.data1 5
	.data1 5
	.data1 5
	.data1 5
	.data1 4
	.data1 4
	.data1 4
	.data1 4
	.data1 4
	.data1 4
	.data1 4
	.data1 4
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 3
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 2
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 1
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0
	.data1 0

	.align	2                       ## @estimateSqrt32.sqrtOddAdjustments
estimateSqrt32.sqrtOddAdjustments:
	.data2	4                       ## 0x4
	.data2	34                      ## 0x22
	.data2	93                      ## 0x5d
	.data2	177                     ## 0xb1
	.data2	285                     ## 0x11d
	.data2	415                     ## 0x19f
	.data2	566                     ## 0x236
	.data2	736                     ## 0x2e0
	.data2	924                     ## 0x39c
	.data2	1128                    ## 0x468
	.data2	1349                    ## 0x545
	.data2	1585                    ## 0x631
	.data2	1835                    ## 0x72b
	.data2	2098                    ## 0x832
	.data2	2374                    ## 0x946
	.data2	2663                    ## 0xa67

	.align	2                       ## @estimateSqrt32.sqrtEvenAdjustments
estimateSqrt32.sqrtEvenAdjustments:
	.data2	2605                    ## 0xa2d
	.data2	2223                    ## 0x8af
	.data2	1882                    ## 0x75a
	.data2	1577                    ## 0x629
	.data2	1306                    ## 0x51a
	.data2	1065                    ## 0x429
	.data2	854                     ## 0x356
	.data2	670                     ## 0x29e
	.data2	512                     ## 0x200
	.data2	377                     ## 0x179
	.data2	265                     ## 0x109
	.data2	175                     ## 0xaf
	.data2	104                     ## 0x68
	.data2	52                      ## 0x34
	.data2	18                      ## 0x12
	.data2	2                       ## 0x2


.import addFloat32Sigs
.type addFloat32Sigs, @function
.import addFloat64Sigs
.type addFloat64Sigs, @function
.import normalizeRoundAndPackFloat64
.type normalizeRoundAndPackFloat64, @function
.import propagateFloat64NaN
.type propagateFloat64NaN, @function
.import roundAndPackFloat32
.type roundAndPackFloat32, @function
.import roundAndPackFloat64
.type roundAndPackFloat64, @function
.import subFloat32Sigs
.type subFloat32Sigs, @function
.import subFloat64Sigs
.type subFloat64Sigs, @function
