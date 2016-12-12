.section .text
#.globl main
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-64, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @main
main::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -64
;;
	c0	stw 60[$r0.1] = $r0.57
;;
	c0	stw 56[$r0.1] = $r0.58
;;
	c0	stw 52[$r0.1] = $r0.59
;;
	c0	stw 48[$r0.1] = $r0.60
;;
	c0	stw 44[$r0.1] = $r0.61
;;
	c0	stw 40[$r0.1] = $r0.62
;;
	c0	stw 36[$r0.1] = $r0.63
;;
	c0	stw 32[$r0.1] = $l0.0
	c0	mov $r0.57 = outputFileName
;;
	c0	ldw $r0.4 = 4[$r0.4]
	c0	mov $r0.3 = $r0.57
;;
;;
.call strcpy, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = strcpy
;;
	c0	mov $r0.4 = .str
	c0	mov $r0.3 = $r0.57
;;
.call fopen, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = fopen
;;
	c0	mov $r0.2 = entry_number
;;
	c0	ldw $r0.2 = 0[$r0.2]
;;
;;
	c0	cmplt $b0.0 = $r0.2, 1
	c0	mov $r0.62 = $r0.3
;;
;;
	c0	br $b0.0, LBB0_9
;;
## BB#1:                                ## %for.body.lr.ph
	c0	stw 24[$r0.1] = $r0.62
	c0	mov $r0.3 = 2
	c0	mov $r0.58 = t1t2xy
;;
	c0	mov $r0.61 = theta1
	c0	mov $r0.59 = 0
;;
	c0	mov $r0.62 = theta2
	c0	shl $r0.60 = $r0.2, $r0.3
	c0	stw 20[$r0.1] = $r0.2
;;
	c0	add $r0.2 = $r0.58, 4
	c0	max $r0.5 = $r0.60, 4
;;
	c0	add $r0.5 = $r0.5, -1
;;
	c0	shru $r0.3 = $r0.5, $r0.3
;;
	c0	add $r0.63 = $r0.3, 1
;;
LBB0_2:                                 ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.3 = $r0.61, $r0.59
	c0	add $r0.5 = $r0.62, $r0.59
	c0	add $r0.63 = $r0.63, -1
	c0	mov $r0.4 = $r0.59
;;
	c0	ldw $r0.6 = 0[$r0.3]
	c0	add $r0.59 = $r0.59, 4
	c0	add $r0.57 = $r0.2, 16
	c0	mov $r0.3 = $r0.58
;;
	c0	ldw $r0.5 = 0[$r0.5]
;;
	c0	stw -4[$r0.2] = $r0.6
	c0	cmpeq $b0.0 = $r0.63, 0
;;
;;
	c0	mfb $r0.6 = $b0.0
;;
	c0	stw 28[$r0.1] = $r0.6
;;
.call forwardk2j, caller, arg($r0.3:u32,$r0.4:u32), ret()
	c0	stw 0[$r0.2] = $r0.5
	c0	call $l0.0 = forwardk2j
;;
	c0	mov $r0.2 = $r0.57
	c0	ldw $r0.3 = 28[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.3
;;
;;
	c0	brf $b0.0, LBB0_2
;;
## BB#3:                                ## %for.cond.8.preheader
	c0	ldw $r0.2 = 20[$r0.1]
;;
;;
	c0	cmpgt $b0.0 = $r0.2, 0
	c0	ldw $r0.62 = 24[$r0.1]
;;
;;
	c0	brf $b0.0, LBB0_9
;;
## BB#4:
	c0	mfb $r0.2 = $b0.0
;;
	c0	stw 20[$r0.1] = $r0.2
	c0	mov $r0.6 = 0
	c0	add $r0.59 = $r0.58, 12
;;
	c0	mov $r0.58 = t1t2xy
;;
LBB0_5:                                 ## %for.body.12
                                        ## =>This Inner Loop Header: Depth=1
	c0	add $r0.57 = $r0.6, 4
	c0	ldw $r0.3 = -4[$r0.59]
;;
	c0	ldw $r0.4 = 0[$r0.59]
	c0	mov $r0.5 = $r0.58
	c0	add $r0.59 = $r0.59, 16
	c0	cmplt $b0.0 = $r0.57, $r0.60
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.call inversek2j, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret()
	c0	stw 28[$r0.1] = $r0.2
	c0	call $l0.0 = inversek2j
;;
	c0	mov $r0.6 = $r0.57
	c0	ldw $r0.2 = 28[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.2
;;
;;
	c0	br $b0.0, LBB0_5
;;
## BB#6:                                ## %for.cond.20.preheader
	c0	ldw $r0.2 = 20[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.2
;;
;;
	c0	brf $b0.0, LBB0_9
;;
## BB#7:
	c0	mov $r0.61 = 0
	c0	mov $r0.59 = .str.1
;;
LBB0_8:                                 ## %for.body.24
                                        ## =>This Inner Loop Header: Depth=1
	c0	ldw $r0.3 = 0[$r0.58]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	add $r0.61 = $r0.61, 4
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.5 = $r0.3
;;
	c0	mov $r0.3 = $r0.62
	c0	add $r0.58 = $r0.58, 16
	c0	cmplt $b0.0 = $r0.61, $r0.60
;;
;;
	c0	mfb $r0.2 = $b0.0
;;
.call fprintf, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32,$r0.7:u32,$r0.8:u32,$r0.9:u32,$r0.10:u32), ret($r0.3:u32)
	c0	stw 28[$r0.1] = $r0.2
	c0	call $l0.0 = fprintf
;;
	c0	ldw $r0.2 = 28[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.2
;;
;;
	c0	br $b0.0, LBB0_8
;;
LBB0_9:                                 ## %for.end.29
	c0	mov $r0.3 = $r0.62
;;
.call fclose, caller, arg($r0.3:u32), ret($r0.3:u32)
	c0	call $l0.0 = fclose
;;
	c0	mov $r0.3 = 0
	c0	ldw $l0.0 = 32[$r0.1]
;;
	c0	ldw $r0.63 = 36[$r0.1]
;;
	c0	ldw $r0.62 = 40[$r0.1]
;;
	c0	ldw $r0.61 = 44[$r0.1]
;;
	c0	ldw $r0.60 = 48[$r0.1]
;;
	c0	ldw $r0.59 = 52[$r0.1]
;;
	c0	ldw $r0.58 = 56[$r0.1]
;;
.return ret($r0.3:u32)
	c0	ldw $r0.57 = 60[$r0.1]
	c0	return $r0.1 = $r0.1, 64, $l0.0
;;
.endp

#.globl poww
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @poww
poww::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $r0.57
;;
	c0	stw 24[$r0.1] = $r0.58
;;
	c0	stw 20[$r0.1] = $r0.59
;;
	c0	stw 16[$r0.1] = $l0.0
	c0	cmpeq $b0.0 = $r0.5, 0
	c0	mov $r0.57 = $r0.4
	c0	mov $r0.58 = $r0.3
;;
;;
	c0	br $b0.0, LBB1_1
;;
## BB#2:                                ## %for.cond.preheader
	c0	cmplt $b0.0 = $r0.5, 2
;;
;;
	c0	br $b0.0, LBB1_3
;;
## BB#4:                                ## %for.body.preheader
	c0	mov $r0.3 = $r0.58
	c0	add $r0.59 = $r0.5, -1
	c0	mov $r0.4 = $r0.57
;;
LBB1_5:                                 ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	mov $r0.6 = $r0.57
	c0	mov $r0.5 = $r0.58
	c0	add $r0.59 = $r0.59, -1
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.59, 0
;;
;;
	c0	br $b0.0, LBB1_5
;;
	c0	goto LBB1_6
;;
LBB1_1:
	c0	mov $r0.4 = 0
	c0	mov $r0.3 = 1072693248
	c0	goto LBB1_6
;;
LBB1_3:
	c0	mov $r0.3 = $r0.58
	c0	mov $r0.4 = $r0.57
;;
LBB1_6:                                 ## %return
	c0	ldw $l0.0 = 16[$r0.1]
;;
	c0	ldw $r0.59 = 20[$r0.1]
;;
	c0	ldw $r0.58 = 24[$r0.1]
;;
	c0	ldw $r0.57 = 28[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl fat
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @fat
fat::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $r0.57
;;
	c0	stw 24[$r0.1] = $r0.58
;;
	c0	stw 20[$r0.1] = $r0.59
;;
	c0	stw 16[$r0.1] = $l0.0
	c0	mov $r0.59 = $r0.3
;;
	c0	cmplt $b0.0 = $r0.59, 1
	c0	mov $r0.57 = 0
	c0	mov $r0.58 = 1072693248
;;
;;
	c0	br $b0.0, LBB2_2
;;
LBB2_1:                                 ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	c0	mov $r0.3 = $r0.59
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.59, 0
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB2_1
;;
LBB2_2:                                 ## %for.end
	c0	mov $r0.3 = $r0.58
	c0	mov $r0.4 = $r0.57
	c0	ldw $l0.0 = 16[$r0.1]
;;
	c0	ldw $r0.59 = 20[$r0.1]
;;
	c0	ldw $r0.58 = 24[$r0.1]
;;
	c0	ldw $r0.57 = 28[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

#.globl cosx
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-96, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @cosx
cosx::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -96
;;
	c0	stw 92[$r0.1] = $r0.57
;;
	c0	stw 88[$r0.1] = $r0.58
;;
	c0	stw 84[$r0.1] = $r0.59
;;
	c0	stw 80[$r0.1] = $r0.60
;;
	c0	stw 76[$r0.1] = $r0.61
;;
	c0	stw 72[$r0.1] = $r0.62
;;
	c0	stw 68[$r0.1] = $r0.63
;;
	c0	stw 64[$r0.1] = $l0.0
	c0	mov $r0.57 = 0
;;
	c0	stw 60[$r0.1] = $r0.57
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 56[$r0.1] = $r0.2
	c0	mov $r0.2 = -1
;;
	c0	stw 32[$r0.1] = $r0.2
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 36[$r0.1] = $r0.2
	c0	mov $r0.2 = 1
;;
	c0	stw 40[$r0.1] = $r0.2
	c0	mov $r0.60 = $r0.4
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.4 = $r0.57
;;
	c0	goto LBB3_1
;;
LBB3_2:                                 ## %fat.exit.thread
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	ldw $r0.5 = 56[$r0.1]
;;
	c0	ldw $r0.6 = 60[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	ldw $r0.57 = 40[$r0.1]
;;
LBB3_1:                                 ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB3_5 Depth 2
                                        ##     Child Loop BB3_8 Depth 2
                                        ##     Child Loop BB3_11 Depth 2
	c0	cmpne $b0.0 = $r0.57, 0
;;
;;
	c0	brf $b0.0, LBB3_2
;;
## BB#3:                                ## %for.cond.preheader.i
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	stw 48[$r0.1] = $r0.4
;;
	c0	stw 52[$r0.1] = $r0.3
	c0	cmplt $b0.0 = $r0.57, 2
;;
	c0	ldw $r0.59 = 36[$r0.1]
;;
	c0	br $b0.0, LBB3_6
;;
## BB#4:                                ## %for.body.i.preheader
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	add $r0.2 = $r0.57, -1
	c0	ldw $r0.59 = 36[$r0.1]
;;
LBB3_5:                                 ## %for.body.i
                                        ##   Parent Loop BB3_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, -1
	c0	xor $r0.59 = $r0.59, -2147483648
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB3_5
;;
LBB3_6:                                 ## %for.cond.preheader.i.18
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	ldw $r0.2 = 40[$r0.1]
;;
;;
	c0	shl $r0.63 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.58
	c0	mov $r0.2 = $r0.60
;;
	c0	cmplt $b0.0 = $r0.63, 2
;;
;;
	c0	br $b0.0, LBB3_9
;;
## BB#7:                                ## %for.body.i.24.preheader
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	mov $r0.3 = $r0.58
	c0	ldw $r0.2 = 32[$r0.1]
;;
;;
	c0	sh1add $r0.61 = $r0.57, $r0.2
	c0	mov $r0.2 = $r0.60
;;
LBB3_8:                                 ## %for.body.i.24
                                        ##   Parent Loop BB3_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.60
	c0	mov $r0.5 = $r0.58
	c0	mov $r0.4 = $r0.2
	c0	add $r0.61 = $r0.61, -1
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.61, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB3_8
;;
LBB3_9:                                 ## %poww.exit26
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.62 = 60[$r0.1]
;;
;;
	c0	stw 60[$r0.1] = $r0.62
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmplt $b0.0 = $r0.57, 1
	c0	ldw $r0.61 = 56[$r0.1]
;;
	c0	stw 44[$r0.1] = $r0.4
	c0	mov $r0.59 = $r0.3
;;
	c0	br $b0.0, LBB3_12
;;
## BB#10:                               ## %for.body.i.15.preheader
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	ldw $r0.61 = 56[$r0.1]
;;
	c0	ldw $r0.62 = 60[$r0.1]
;;
LBB3_11:                                ## %for.body.i.15
                                        ##   Parent Loop BB3_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.63
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.63 = $r0.63, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.63, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB3_11
;;
LBB3_12:                                ## %fat.exit
                                        ##   in Loop: Header=BB3_1 Depth=1
	c0	mov $r0.5 = $r0.61
	c0	ldw $r0.4 = 44[$r0.1]
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.6 = $r0.62
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 48[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 52[$r0.1]
	c0	add $r0.57 = $r0.57, 1
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
;;
;;
	c0	br $b0.0, LBB3_1
;;
## BB#13:                               ## %for.end
	c0	ldw $l0.0 = 64[$r0.1]
;;
	c0	ldw $r0.63 = 68[$r0.1]
;;
	c0	ldw $r0.62 = 72[$r0.1]
;;
	c0	ldw $r0.61 = 76[$r0.1]
;;
	c0	ldw $r0.60 = 80[$r0.1]
;;
	c0	ldw $r0.59 = 84[$r0.1]
;;
	c0	ldw $r0.58 = 88[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	ldw $r0.57 = 92[$r0.1]
	c0	return $r0.1 = $r0.1, 96, $l0.0
;;
.endp

#.globl sinx
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-96, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @sinx
sinx::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -96
;;
	c0	stw 92[$r0.1] = $r0.57
;;
	c0	stw 88[$r0.1] = $r0.58
;;
	c0	stw 84[$r0.1] = $r0.59
;;
	c0	stw 80[$r0.1] = $r0.60
;;
	c0	stw 76[$r0.1] = $r0.61
;;
	c0	stw 72[$r0.1] = $r0.62
;;
	c0	stw 68[$r0.1] = $r0.63
;;
	c0	stw 64[$r0.1] = $l0.0
	c0	mov $r0.57 = 0
;;
	c0	stw 52[$r0.1] = $r0.57
	c0	mov $r0.63 = $r0.3
;;
	c0	stw 40[$r0.1] = $r0.63
;;
	c0	stw 40[$r0.1] = $r0.63
	c0	mov $r0.5 = 1
;;
	c0	stw 56[$r0.1] = $r0.5
	c0	mov $r0.5 = 1072693248
;;
	c0	stw 36[$r0.1] = $r0.5
	c0	mov $r0.5 = -1074790400
;;
	c0	stw 32[$r0.1] = $r0.5
	c0	mov $r0.59 = $r0.4
;;
	c0	stw 60[$r0.1] = $r0.57
	c0	mov $r0.5 = $r0.57
	c0	mov $r0.4 = $r0.57
;;
LBB4_1:                                 ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_3 Depth 2
                                        ##     Child Loop BB4_5 Depth 2
                                        ##     Child Loop BB4_8 Depth 2
	c0	stw 44[$r0.1] = $r0.5
;;
	c0	stw 48[$r0.1] = $r0.4
	c0	cmpeq $b0.0 = $r0.57, 0
	c0	mov $r0.4 = $r0.59
;;
	c0	ldw $r0.62 = 56[$r0.1]
;;
	c0	br $b0.0, LBB4_7
;;
## BB#2:                                ## %for.cond.preheader.i
                                        ##   in Loop: Header=BB4_1 Depth=1
	c0	cmplt $b0.0 = $r0.57, 2
	c0	ldw $r0.63 = 32[$r0.1]
;;
	c0	ldw $r0.2 = 56[$r0.1]
;;
	c0	br $b0.0, LBB4_4
;;
LBB4_3:                                 ## %for.body.i
                                        ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, 1
	c0	xor $r0.63 = $r0.63, -2147483648
;;
	c0	cmpne $b0.0 = $r0.57, $r0.2
;;
;;
	c0	br $b0.0, LBB4_3
;;
LBB4_4:                                 ## %poww.exit
                                        ##   in Loop: Header=BB4_1 Depth=1
	c0	ldw $r0.2 = 56[$r0.1]
;;
;;
	c0	shl $r0.4 = $r0.57, $r0.2
	c0	ldw $r0.61 = 40[$r0.1]
;;
;;
	c0	mov $r0.3 = $r0.61
	c0	ldw $r0.60 = 60[$r0.1]
	c0	mov $r0.2 = $r0.59
	c0	or $r0.62 = $r0.4, 1
;;
	c0	cmplt $b0.0 = $r0.62, 2
;;
;;
	c0	br $b0.0, LBB4_6
;;
LBB4_5:                                 ## %for.body.i.27
                                        ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.59
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.4 = $r0.2
	c0	add $r0.60 = $r0.60, -1
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.60, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB4_5
;;
LBB4_6:                                 ## %poww.exit29
                                        ##   in Loop: Header=BB4_1 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.61 = 52[$r0.1]
;;
;;
	c0	stw 52[$r0.1] = $r0.61
	c0	mov $r0.4 = $r0.61
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmplt $b0.0 = $r0.62, 1
	c0	ldw $r0.60 = 36[$r0.1]
	c0	mov $r0.63 = $r0.3
;;
;;
	c0	br $b0.0, LBB4_10
;;
LBB4_7:                                 ## %for.body.i.19.preheader
                                        ##   in Loop: Header=BB4_1 Depth=1
	c0	mov $r0.58 = $r0.4
	c0	ldw $r0.60 = 36[$r0.1]
;;
	c0	ldw $r0.61 = 52[$r0.1]
;;
LBB4_8:                                 ## %for.body.i.19
                                        ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.62
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.61
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.62 = $r0.62, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.62, 0
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.61 = $r0.4
;;
;;
	c0	br $b0.0, LBB4_8
;;
## BB#9:                                ##   in Loop: Header=BB4_1 Depth=1
	c0	mov $r0.4 = $r0.58
;;
LBB4_10:                                ## %fat.exit
                                        ##   in Loop: Header=BB4_1 Depth=1
	c0	mov $r0.5 = $r0.60
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.61
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 44[$r0.1]
;;
	c0	ldw $r0.4 = 48[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	add $r0.57 = $r0.57, 1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.2 = 60[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 2
;;
	c0	stw 60[$r0.1] = $r0.2
	c0	cmpne $b0.0 = $r0.57, 31
;;
	c0	ldw $r0.63 = 40[$r0.1]
;;
	c0	br $b0.0, LBB4_1
;;
## BB#11:                               ## %for.end
	c0	mov $r0.3 = $r0.5
	c0	ldw $l0.0 = 64[$r0.1]
;;
	c0	ldw $r0.63 = 68[$r0.1]
;;
	c0	ldw $r0.62 = 72[$r0.1]
;;
	c0	ldw $r0.61 = 76[$r0.1]
;;
	c0	ldw $r0.60 = 80[$r0.1]
;;
	c0	ldw $r0.59 = 84[$r0.1]
;;
	c0	ldw $r0.58 = 88[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	ldw $r0.57 = 92[$r0.1]
	c0	return $r0.1 = $r0.1, 96, $l0.0
;;
.endp

#.globl acosx
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-96, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @acosx
acosx::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -96
;;
	c0	stw 92[$r0.1] = $r0.57
;;
	c0	stw 88[$r0.1] = $r0.58
;;
	c0	stw 84[$r0.1] = $r0.59
;;
	c0	stw 80[$r0.1] = $r0.60
;;
	c0	stw 76[$r0.1] = $r0.61
;;
	c0	stw 72[$r0.1] = $r0.62
;;
	c0	stw 68[$r0.1] = $r0.63
;;
	c0	stw 64[$r0.1] = $l0.0
	c0	mov $r0.59 = 0
;;
	c0	stw 32[$r0.1] = $r0.59
;;
	c0	stw 32[$r0.1] = $r0.59
	c0	mov $r0.2 = -1
;;
	c0	stw 24[$r0.1] = $r0.2
	c0	mov $r0.57 = 1
	c0	mov $r0.58 = $r0.4
;;
	c0	mov $r0.4 = 1072693248
;;
	c0	stw 56[$r0.1] = $r0.4
	c0	mov $r0.4 = 1071644672
;;
	c0	stw 28[$r0.1] = $r0.4
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.62 = $r0.59
;;
	c0	stw 52[$r0.1] = $r0.59
	c0	mov $r0.6 = $r0.59
	c0	mov $r0.7 = $r0.59
;;
	c0	stw 48[$r0.1] = $r0.2
;;
LBB5_1:                                 ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB5_3 Depth 2
                                        ##     Child Loop BB5_6 Depth 2
                                        ##     Child Loop BB5_9 Depth 2
	c0	stw 36[$r0.1] = $r0.7
;;
	c0	stw 40[$r0.1] = $r0.6
;;
	c0	stw 44[$r0.1] = $r0.62
	c0	add $r0.2 = $r0.57, -1
;;
	c0	ldw $r0.3 = 56[$r0.1]
;;
;;
	c0	stw 56[$r0.1] = $r0.3
	c0	mov $r0.62 = $r0.3
	c0	mov $r0.61 = $r0.59
	c0	mov $r0.63 = $r0.3
;;
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB5_8
;;
## BB#2:                                ## %for.cond.preheader.i
                                        ##   in Loop: Header=BB5_1 Depth=1
	c0	stw 60[$r0.1] = $r0.57
	c0	cmplt $b0.0 = $r0.2, 2
;;
	c0	ldw $r0.62 = 28[$r0.1]
;;
;;
	c0	mov $r0.63 = $r0.62
	c0	ldw $r0.57 = 48[$r0.1]
;;
	c0	ldw $r0.59 = 32[$r0.1]
;;
;;
	c0	mov $r0.61 = $r0.59
	c0	br $b0.0, LBB5_4
;;
LBB5_3:                                 ## %for.body.i
                                        ##   Parent Loop BB5_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.59
	c0	mov $r0.5 = $r0.62
	c0	mov $r0.4 = $r0.61
	c0	mov $r0.3 = $r0.63
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.63 = $r0.3
	c0	mov $r0.61 = $r0.4
;;
;;
	c0	br $b0.0, LBB5_3
;;
LBB5_4:                                 ## %poww.exit
                                        ##   in Loop: Header=BB5_1 Depth=1
	c0	stw 28[$r0.1] = $r0.62
;;
	c0	ldw $r0.2 = 60[$r0.1]
;;
;;
	c0	cmplt $b0.0 = $r0.2, 2
	c0	ldw $r0.62 = 56[$r0.1]
;;
	c0	ldw $r0.57 = 52[$r0.1]
;;
	c0	br $b0.0, LBB5_5
;;
LBB5_6:                                 ## %for.body.i.32
                                        ##   Parent Loop BB5_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.57
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.62
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.62 = $r0.3
	c0	mov $r0.59 = $r0.4
;;
;;
	c0	br $b0.0, LBB5_6
;;
	c0	goto LBB5_7
;;
LBB5_5:                                 ##   in Loop: Header=BB5_1 Depth=1
	c0	ldw $r0.62 = 56[$r0.1]
;;
	c0	ldw $r0.59 = 32[$r0.1]
;;
LBB5_7:                                 ##   in Loop: Header=BB5_1 Depth=1
	c0	ldw $r0.57 = 60[$r0.1]
;;                                      ## 4-byte Folded Reload
LBB5_8:                                 ## %fat.exit
                                        ##   in Loop: Header=BB5_1 Depth=1
	c0	stw 60[$r0.1] = $r0.57
;;
	c0	ldw $r0.2 = 24[$r0.1]
;;
;;
	c0	sh1add $r0.57 = $r0.57, $r0.2
;;
	c0	mov $r0.3 = $r0.57
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.5 = $r0.62
	c0	mov $r0.6 = $r0.59
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.4 = $r0.61
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	cmplt $b0.0 = $r0.57, 2
	c0	mov $r0.2 = $r0.60
	c0	ldw $r0.62 = 44[$r0.1]
;;
;;
	c0	mov $r0.57 = $r0.62
	c0	mov $r0.59 = $r0.4
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.7 = $r0.58
;;
	c0	br $b0.0, LBB5_10
;;
LBB5_9:                                 ## %for.body.i.26
                                        ##   Parent Loop BB5_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.58
	c0	mov $r0.5 = $r0.60
	c0	mov $r0.4 = $r0.7
	c0	mov $r0.3 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.7 = $r0.4
;;
;;
	c0	br $b0.0, LBB5_9
;;
LBB5_10:                                ## %poww.exit28
                                        ##   in Loop: Header=BB5_1 Depth=1
	c0	mov $r0.5 = $r0.2
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.6 = $r0.7
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 36[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 40[$r0.1]
;;
	c0	ldw $r0.57 = 60[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, 1
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
	c0	ldw $r0.2 = 48[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 1
;;
	c0	stw 48[$r0.1] = $r0.2
	c0	add $r0.62 = $r0.62, 2
	c0	mov $r0.7 = $r0.4
	c0	mov $r0.6 = $r0.3
;;
	c0	ldw $r0.2 = 52[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 1
;;
	c0	stw 52[$r0.1] = $r0.2
;;
	c0	ldw $r0.59 = 32[$r0.1]
	c0	br $b0.0, LBB5_1
;;
## BB#11:                               ## %for.end
	c0	mov $r0.3 = 1073291771
	c0	mov $r0.4 = 1413754602
;;
	c0	mov $r0.5 = $r0.6
	c0	mov $r0.6 = $r0.7
;;
.call float64_sub, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_sub
;;
	c0	ldw $l0.0 = 64[$r0.1]
;;
	c0	ldw $r0.63 = 68[$r0.1]
;;
	c0	ldw $r0.62 = 72[$r0.1]
;;
	c0	ldw $r0.61 = 76[$r0.1]
;;
	c0	ldw $r0.60 = 80[$r0.1]
;;
	c0	ldw $r0.59 = 84[$r0.1]
;;
	c0	ldw $r0.58 = 88[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	ldw $r0.57 = 92[$r0.1]
	c0	return $r0.1 = $r0.1, 96, $l0.0
;;
.endp

#.globl asinx
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-96, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @asinx
asinx::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -96
;;
	c0	stw 92[$r0.1] = $r0.57
;;
	c0	stw 88[$r0.1] = $r0.58
;;
	c0	stw 84[$r0.1] = $r0.59
;;
	c0	stw 80[$r0.1] = $r0.60
;;
	c0	stw 76[$r0.1] = $r0.61
;;
	c0	stw 72[$r0.1] = $r0.62
;;
	c0	stw 68[$r0.1] = $r0.63
;;
	c0	stw 64[$r0.1] = $l0.0
	c0	mov $r0.2 = 0
;;
	c0	stw 60[$r0.1] = $r0.2
	c0	mov $r0.5 = $r0.3
;;
	c0	stw 24[$r0.1] = $r0.5
	c0	mov $r0.3 = 1
;;
	c0	stw 28[$r0.1] = $r0.3
	c0	mov $r0.58 = 1072693248
;;
	c0	stw 20[$r0.1] = $r0.58
	c0	mov $r0.3 = 1073741824
;;
	c0	stw 16[$r0.1] = $r0.3
;;
	c0	stw 48[$r0.1] = $r0.4
	c0	mov $r0.60 = $r0.2
	c0	mov $r0.3 = $r0.2
	c0	mov $r0.4 = $r0.2
;;
	c0	mov $r0.59 = $r0.2
;;
LBB6_1:                                 ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB6_2 Depth 2
                                        ##     Child Loop BB6_5 Depth 2
                                        ##     Child Loop BB6_7 Depth 2
                                        ##     Child Loop BB6_9 Depth 2
	c0	stw 36[$r0.1] = $r0.4
;;
	c0	stw 40[$r0.1] = $r0.3
	c0	cmplt $b0.0 = $r0.59, 1
	c0	mov $r0.61 = $r0.58
	c0	mov $r0.57 = $r0.60
;;
	c0	ldw $r0.62 = 60[$r0.1]
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	stw 32[$r0.1] = $r0.2
	c0	br $b0.0, LBB6_3
;;
LBB6_2:                                 ## %for.body.i
                                        ##   Parent Loop BB6_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.57
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB6_2
;;
LBB6_3:                                 ## %fat.exit
                                        ##   in Loop: Header=BB6_1 Depth=1
	c0	cmpeq $b0.0 = $r0.59, 0
	c0	mov $r0.63 = $r0.58
	c0	ldw $r0.2 = 28[$r0.1]
;;
;;
	c0	shl $r0.2 = $r0.59, $r0.2
;;
	c0	stw 52[$r0.1] = $r0.2
;;
	c0	stw 56[$r0.1] = $r0.59
;;
	c0	ldw $r0.59 = 60[$r0.1]
	c0	br $b0.0, LBB6_6
;;
## BB#4:                                ## %for.cond.preheader.i
                                        ##   in Loop: Header=BB6_1 Depth=1
	c0	ldw $r0.2 = 52[$r0.1]
;;
;;
	c0	cmplt $b0.0 = $r0.2, 2
	c0	ldw $r0.59 = 60[$r0.1]
;;
	c0	ldw $r0.63 = 16[$r0.1]
;;
	c0	ldw $r0.57 = 28[$r0.1]
	c0	br $b0.0, LBB6_6
;;
LBB6_5:                                 ## %for.body.i.51
                                        ##   Parent Loop BB6_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.5 = $r0.63
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.59
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	add $r0.57 = $r0.57, 1
	c0	mov $r0.63 = $r0.3
	c0	mov $r0.59 = $r0.4
;;
	c0	cmpne $b0.0 = $r0.60, $r0.57
;;
;;
	c0	br $b0.0, LBB6_5
;;
LBB6_6:                                 ## %poww.exit53
                                        ##   in Loop: Header=BB6_1 Depth=1
	c0	stw 44[$r0.1] = $r0.60
	c0	mov $r0.60 = $r0.58
;;
	c0	ldw $r0.58 = 56[$r0.1]
;;
	c0	ldw $r0.57 = 60[$r0.1]
;;
	c0	ldw $r0.2 = 32[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.2
;;
;;
	c0	br $b0.0, LBB6_8
;;
LBB6_7:                                 ## %for.body.i.42
                                        ##   Parent Loop BB6_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.58
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB6_7
;;
LBB6_8:                                 ## %fat.exit44
                                        ##   in Loop: Header=BB6_1 Depth=1
	c0	mov $r0.5 = $r0.60
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.60
	c0	mov $r0.6 = $r0.57
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.4 = $r0.59
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
	c0	ldw $r0.2 = 52[$r0.1]
;;
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.62 = $r0.2, 1
	c0	call $l0.0 = float64_div
;;
	c0	cmplt $b0.0 = $r0.62, 2
	c0	ldw $r0.63 = 24[$r0.1]
;;
;;
	c0	mov $r0.60 = $r0.63
	c0	ldw $r0.58 = 60[$r0.1]
;;
	c0	stw 52[$r0.1] = $r0.4
;;
	c0	stw 32[$r0.1] = $r0.3
;;
	c0	ldw $r0.59 = 48[$r0.1]
;;
;;
	c0	mov $r0.57 = $r0.59
	c0	ldw $r0.61 = 44[$r0.1]
	c0	br $b0.0, LBB6_10
;;
LBB6_9:                                 ## %for.body.i.25
                                        ##   Parent Loop BB6_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.59
	c0	mov $r0.5 = $r0.63
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, 1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.61, $r0.58
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB6_9
;;
LBB6_10:                                ## %poww.exit
                                        ##   in Loop: Header=BB6_1 Depth=1
	c0	stw 48[$r0.1] = $r0.59
	c0	mov $r0.3 = $r0.62
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.60
	c0	mov $r0.4 = $r0.57
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 32[$r0.1]
;;
	c0	ldw $r0.4 = 52[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 36[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 40[$r0.1]
;;
	c0	ldw $r0.59 = 56[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, 1
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.59, 31
	c0	add $r0.61 = $r0.61, 2
	c0	ldw $r0.58 = 20[$r0.1]
;;
	c0	mov $r0.60 = $r0.61
;;
	c0	br $b0.0, LBB6_1
;;
## BB#11:                               ## %for.end
	c0	ldw $l0.0 = 64[$r0.1]
;;
	c0	ldw $r0.63 = 68[$r0.1]
;;
	c0	ldw $r0.62 = 72[$r0.1]
;;
	c0	ldw $r0.61 = 76[$r0.1]
;;
	c0	ldw $r0.60 = 80[$r0.1]
;;
	c0	ldw $r0.59 = 84[$r0.1]
;;
	c0	ldw $r0.58 = 88[$r0.1]
;;
.return ret($r0.3:u32,$r0.4:u32)
	c0	ldw $r0.57 = 92[$r0.1]
	c0	return $r0.1 = $r0.1, 96, $l0.0
;;
.endp

#.globl forwardk2j
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-128, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @forwardk2j
forwardk2j::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -128
;;
	c0	stw 124[$r0.1] = $r0.57
;;
	c0	stw 120[$r0.1] = $r0.58
;;
	c0	stw 116[$r0.1] = $r0.59
;;
	c0	stw 112[$r0.1] = $r0.60
;;
	c0	stw 108[$r0.1] = $r0.61
;;
	c0	stw 104[$r0.1] = $r0.62
;;
	c0	stw 100[$r0.1] = $r0.63
;;
	c0	stw 96[$r0.1] = $l0.0
	c0	mov $r0.5 = l1
;;
	c0	stw 36[$r0.1] = $r0.5
	c0	sh2add $r0.2 = $r0.4, $r0.3
;;
	c0	stw 40[$r0.1] = $r0.2
;;
	c0	ldw $r0.3 = 0[$r0.2]
;;
;;
	c0	stw 60[$r0.1] = $r0.3
	c0	mov $r0.57 = 0
;;
	c0	stw 88[$r0.1] = $r0.57
;;
	c0	ldw $r0.2 = 0[$r0.5]
;;
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	stw 64[$r0.1] = $r0.2
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.2 = $r0.57
	c0	mov $r0.6 = $r0.57
	c0	mov $r0.5 = -1
;;
	c0	stw 48[$r0.1] = $r0.5
	c0	mov $r0.5 = -1074790400
;;
	c0	stw 68[$r0.1] = $r0.5
	c0	mov $r0.5 = 1
;;
	c0	stw 72[$r0.1] = $r0.5
	c0	mov $r0.5 = 1072693248
;;
	c0	stw 84[$r0.1] = $r0.5
;;
	c0	stw 92[$r0.1] = $r0.4
	c0	mov $r0.58 = $r0.3
	c0	goto LBB7_1
;;
LBB7_2:                                 ## %fat.exit.thread.i
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	ldw $r0.5 = 84[$r0.1]
	c0	mov $r0.4 = $r0.2
	c0	mov $r0.3 = $r0.6
;;
	c0	ldw $r0.6 = 88[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.6 = $r0.3
	c0	ldw $r0.57 = 72[$r0.1]
;;
LBB7_1:                                 ## %for.body.i
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_5 Depth 2
                                        ##     Child Loop BB7_8 Depth 2
                                        ##     Child Loop BB7_11 Depth 2
	c0	cmpne $b0.0 = $r0.57, 0
;;
;;
	c0	brf $b0.0, LBB7_2
;;
## BB#3:                                ## %for.cond.preheader.i.i
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	stw 76[$r0.1] = $r0.6
;;
	c0	stw 80[$r0.1] = $r0.2
	c0	cmplt $b0.0 = $r0.57, 2
;;
	c0	ldw $r0.63 = 68[$r0.1]
;;
	c0	ldw $r0.60 = 92[$r0.1]
	c0	br $b0.0, LBB7_6
;;
## BB#4:                                ## %for.body.i.i.preheader
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	add $r0.2 = $r0.57, -1
	c0	ldw $r0.63 = 68[$r0.1]
;;
LBB7_5:                                 ## %for.body.i.i
                                        ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, -1
	c0	xor $r0.63 = $r0.63, -2147483648
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB7_5
;;
LBB7_6:                                 ## %for.cond.preheader.i.18.i
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	ldw $r0.2 = 72[$r0.1]
;;
;;
	c0	shl $r0.62 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.58
	c0	mov $r0.2 = $r0.60
;;
	c0	cmplt $b0.0 = $r0.62, 2
;;
;;
	c0	br $b0.0, LBB7_9
;;
## BB#7:                                ## %for.body.i.24.i.preheader
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	mov $r0.3 = $r0.58
	c0	ldw $r0.2 = 48[$r0.1]
;;
;;
	c0	sh1add $r0.59 = $r0.57, $r0.2
	c0	mov $r0.2 = $r0.60
;;
LBB7_8:                                 ## %for.body.i.24.i
                                        ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.59, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_8
;;
LBB7_9:                                 ## %poww.exit26.i
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	stw 92[$r0.1] = $r0.60
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.60 = 88[$r0.1]
;;
;;
	c0	stw 88[$r0.1] = $r0.60
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmplt $b0.0 = $r0.57, 1
	c0	ldw $r0.61 = 84[$r0.1]
	c0	mov $r0.59 = $r0.4
	c0	mov $r0.63 = $r0.3
;;
;;
	c0	br $b0.0, LBB7_12
;;
## BB#10:                               ## %for.body.i.15.i.preheader
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	ldw $r0.61 = 84[$r0.1]
;;
	c0	ldw $r0.60 = 88[$r0.1]
;;
LBB7_11:                                ## %for.body.i.15.i
                                        ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.62
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.62 = $r0.62, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.62, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.60 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_11
;;
LBB7_12:                                ## %fat.exit.i
                                        ##   in Loop: Header=BB7_1 Depth=1
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.60
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 80[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 76[$r0.1]
	c0	add $r0.57 = $r0.57, 1
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
	c0	mov $r0.6 = $r0.3
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_1
;;
## BB#13:                               ## %cosx.exit
	c0	stw 76[$r0.1] = $r0.6
;;
	c0	stw 80[$r0.1] = $r0.2
;;
	c0	ldw $r0.2 = 40[$r0.1]
;;
;;
	c0	ldw $r0.4 = 4[$r0.2]
;;
	c0	ldw $r0.3 = 60[$r0.1]
	c0	mov $r0.57 = l2
;;
.call float32_add, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	stw 32[$r0.1] = $r0.57
	c0	call $l0.0 = float32_add
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.59 = $r0.3
;;
	c0	stw 44[$r0.1] = $r0.59
	c0	mov $r0.60 = $r0.4
	c0	mov $r0.61 = 0
;;
	c0	stw 88[$r0.1] = $r0.61
;;
	c0	ldw $r0.3 = 64[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	ldw $r0.2 = 0[$r0.57]
;;
;;
	c0	stw 28[$r0.1] = $r0.2
	c0	mov $r0.62 = $r0.61
	c0	mov $r0.63 = $r0.61
;;
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 52[$r0.1] = $r0.2
	c0	mov $r0.2 = 1
;;
	c0	stw 56[$r0.1] = $r0.2
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 84[$r0.1] = $r0.2
;;
	c0	stw 24[$r0.1] = $r0.4
;;
	c0	stw 20[$r0.1] = $r0.3
	c0	mov $r0.57 = $r0.61
	c0	goto LBB7_14
;;
LBB7_15:                                ## %fat.exit.thread.i.121
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	ldw $r0.5 = 84[$r0.1]
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.3 = $r0.63
;;
	c0	ldw $r0.6 = 88[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	mov $r0.62 = $r0.4
	c0	mov $r0.63 = $r0.3
	c0	ldw $r0.57 = 56[$r0.1]
;;
LBB7_14:                                ## %for.body.i.119
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_18 Depth 2
                                        ##     Child Loop BB7_21 Depth 2
                                        ##     Child Loop BB7_24 Depth 2
	c0	cmpne $b0.0 = $r0.57, 0
;;
;;
	c0	brf $b0.0, LBB7_15
;;
## BB#16:                               ## %for.cond.preheader.i.i.123
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	stw 68[$r0.1] = $r0.63
;;
	c0	stw 72[$r0.1] = $r0.62
	c0	cmplt $b0.0 = $r0.57, 2
;;
	c0	ldw $r0.61 = 52[$r0.1]
;;
	c0	br $b0.0, LBB7_19
;;
## BB#17:                               ## %for.body.i.i.129.preheader
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	add $r0.2 = $r0.57, -1
	c0	ldw $r0.61 = 52[$r0.1]
;;
LBB7_18:                                ## %for.body.i.i.129
                                        ##   Parent Loop BB7_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, -1
	c0	xor $r0.61 = $r0.61, -2147483648
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB7_18
;;
LBB7_19:                                ## %for.cond.preheader.i.18.i.133
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	ldw $r0.2 = 56[$r0.1]
;;
;;
	c0	shl $r0.63 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.2 = $r0.60
;;
	c0	cmplt $b0.0 = $r0.63, 2
;;
;;
	c0	br $b0.0, LBB7_22
;;
## BB#20:                               ## %for.body.i.24.i.139.preheader
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	mov $r0.3 = $r0.59
	c0	ldw $r0.2 = 48[$r0.1]
;;
;;
	c0	sh1add $r0.62 = $r0.57, $r0.2
	c0	mov $r0.2 = $r0.60
;;
LBB7_21:                                ## %for.body.i.24.i.139
                                        ##   Parent Loop BB7_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.59
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.62 = $r0.62, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.62, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_21
;;
LBB7_22:                                ## %poww.exit26.i.143
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.62 = 88[$r0.1]
;;
;;
	c0	stw 88[$r0.1] = $r0.62
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmplt $b0.0 = $r0.57, 1
	c0	ldw $r0.61 = 84[$r0.1]
;;
	c0	stw 60[$r0.1] = $r0.4
;;
	c0	stw 64[$r0.1] = $r0.3
	c0	br $b0.0, LBB7_25
;;
## BB#23:                               ## %for.body.i.15.i.151.preheader
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	ldw $r0.61 = 84[$r0.1]
;;
	c0	ldw $r0.62 = 88[$r0.1]
;;
LBB7_24:                                ## %for.body.i.15.i.151
                                        ##   Parent Loop BB7_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.63
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.63 = $r0.63, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.63, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_24
;;
LBB7_25:                                ## %fat.exit.i.157
                                        ##   in Loop: Header=BB7_14 Depth=1
	c0	mov $r0.5 = $r0.61
	c0	ldw $r0.4 = 60[$r0.1]
;;
	c0	ldw $r0.3 = 64[$r0.1]
	c0	mov $r0.6 = $r0.62
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 72[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 68[$r0.1]
	c0	add $r0.57 = $r0.57, 1
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
	c0	mov $r0.63 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_14
;;
## BB#26:                               ## %cosx.exit158
	c0	ldw $r0.3 = 28[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.5 = $r0.63
	c0	mov $r0.6 = $r0.62
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
	c0	ldw $r0.5 = 76[$r0.1]
;;
	c0	ldw $r0.6 = 80[$r0.1]
;;
	c0	ldw $r0.3 = 20[$r0.1]
;;
	c0	ldw $r0.4 = 24[$r0.1]
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.6 = $r0.62
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
	c0	mov $r0.57 = 0
;;
	c0	stw 64[$r0.1] = $r0.57
;;
	c0	ldw $r0.2 = 40[$r0.1]
;;
;;
	c0	stw 8[$r0.2] = $r0.3
	c0	mov $r0.2 = 1
;;
	c0	stw 84[$r0.1] = $r0.2
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 60[$r0.1] = $r0.2
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 56[$r0.1] = $r0.2
;;
	c0	stw 88[$r0.1] = $r0.57
;;
	c0	stw 76[$r0.1] = $r0.57
;;
	c0	stw 80[$r0.1] = $r0.57
;;
	c0	ldw $r0.2 = 36[$r0.1]
;;
;;
	c0	ldw $r0.2 = 0[$r0.2]
;;
;;
	c0	stw 52[$r0.1] = $r0.2
;;
LBB7_27:                                ## %for.body.i.71
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_29 Depth 2
                                        ##     Child Loop BB7_31 Depth 2
                                        ##     Child Loop BB7_34 Depth 2
	c0	cmpeq $b0.0 = $r0.57, 0
	c0	ldw $r0.4 = 92[$r0.1]
	c0	mov $r0.3 = $r0.58
;;
	c0	ldw $r0.63 = 84[$r0.1]
;;
	c0	br $b0.0, LBB7_33
;;
## BB#28:                               ## %for.cond.preheader.i.i.73
                                        ##   in Loop: Header=BB7_27 Depth=1
	c0	cmplt $b0.0 = $r0.57, 2
	c0	ldw $r0.61 = 56[$r0.1]
;;
	c0	ldw $r0.2 = 84[$r0.1]
;;
	c0	br $b0.0, LBB7_30
;;
LBB7_29:                                ## %for.body.i.i.79
                                        ##   Parent Loop BB7_27 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, 1
	c0	xor $r0.61 = $r0.61, -2147483648
;;
	c0	cmpne $b0.0 = $r0.57, $r0.2
;;
;;
	c0	br $b0.0, LBB7_29
;;
LBB7_30:                                ## %poww.exit.i.84
                                        ##   in Loop: Header=BB7_27 Depth=1
	c0	ldw $r0.2 = 84[$r0.1]
;;
;;
	c0	shl $r0.4 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.58
	c0	ldw $r0.62 = 88[$r0.1]
	c0	mov $r0.59 = $r0.58
;;
	c0	ldw $r0.58 = 92[$r0.1]
;;
;;
	c0	mov $r0.2 = $r0.58
	c0	or $r0.63 = $r0.4, 1
;;
	c0	cmplt $b0.0 = $r0.63, 2
;;
;;
	c0	br $b0.0, LBB7_32
;;
LBB7_31:                                ## %for.body.i.27.i.90
                                        ##   Parent Loop BB7_27 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.3 = $r0.59
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.62 = $r0.62, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.62, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_31
;;
LBB7_32:                                ## %poww.exit29.i.94
                                        ##   in Loop: Header=BB7_27 Depth=1
	c0	stw 92[$r0.1] = $r0.58
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.4 = 64[$r0.1]
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.58 = $r0.59
	c0	ldw $r0.59 = 44[$r0.1]
;;
LBB7_33:                                ## %for.body.i.19.preheader.i.97
                                        ##   in Loop: Header=BB7_27 Depth=1
	c0	stw 68[$r0.1] = $r0.4
;;
	c0	stw 72[$r0.1] = $r0.3
;;
	c0	ldw $r0.61 = 60[$r0.1]
;;
	c0	ldw $r0.62 = 64[$r0.1]
;;
LBB7_34:                                ## %for.body.i.19.i.105
                                        ##   Parent Loop BB7_27 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.63
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.63 = $r0.63, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.63, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_34
;;
## BB#35:                               ## %fat.exit.i.114
                                        ##   in Loop: Header=BB7_27 Depth=1
	c0	mov $r0.5 = $r0.61
	c0	ldw $r0.4 = 68[$r0.1]
;;
	c0	ldw $r0.3 = 72[$r0.1]
	c0	mov $r0.6 = $r0.62
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 76[$r0.1]
;;
	c0	ldw $r0.4 = 80[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	add $r0.57 = $r0.57, 1
	c0	stw 80[$r0.1] = $r0.4
;;
	c0	stw 76[$r0.1] = $r0.3
;;
	c0	ldw $r0.2 = 88[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 2
;;
	c0	stw 88[$r0.1] = $r0.2
	c0	cmpne $b0.0 = $r0.57, 31
;;
;;
	c0	br $b0.0, LBB7_27
;;
## BB#36:                               ## %sinx.exit115
	c0	ldw $r0.3 = 52[$r0.1]
	c0	mov $r0.62 = 0
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	stw 64[$r0.1] = $r0.62
	c0	call $l0.0 = float32_to_float64
;;
	c0	ldw $r0.2 = 32[$r0.1]
;;
;;
	c0	ldw $r0.2 = 0[$r0.2]
;;
;;
	c0	stw 52[$r0.1] = $r0.2
	c0	mov $r0.58 = $r0.62
	c0	mov $r0.61 = $r0.62
	c0	mov $r0.63 = $r0.62
;;
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 56[$r0.1] = $r0.2
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 60[$r0.1] = $r0.2
	c0	mov $r0.2 = 1
;;
	c0	stw 92[$r0.1] = $r0.2
;;
	c0	stw 48[$r0.1] = $r0.4
;;
	c0	stw 36[$r0.1] = $r0.3
;;
LBB7_37:                                ## %for.body.i.45
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_39 Depth 2
                                        ##     Child Loop BB7_41 Depth 2
                                        ##     Child Loop BB7_44 Depth 2
	c0	stw 72[$r0.1] = $r0.61
;;
	c0	stw 84[$r0.1] = $r0.58
	c0	cmpeq $b0.0 = $r0.62, 0
	c0	mov $r0.61 = $r0.60
	c0	mov $r0.3 = $r0.59
;;
	c0	ldw $r0.57 = 92[$r0.1]
;;
	c0	br $b0.0, LBB7_43
;;
## BB#38:                               ## %for.cond.preheader.i.i.47
                                        ##   in Loop: Header=BB7_37 Depth=1
	c0	cmplt $b0.0 = $r0.62, 2
	c0	ldw $r0.61 = 56[$r0.1]
;;
	c0	ldw $r0.2 = 92[$r0.1]
;;
	c0	br $b0.0, LBB7_40
;;
LBB7_39:                                ## %for.body.i.i.53
                                        ##   Parent Loop BB7_37 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, 1
	c0	xor $r0.61 = $r0.61, -2147483648
;;
	c0	cmpne $b0.0 = $r0.62, $r0.2
;;
;;
	c0	br $b0.0, LBB7_39
;;
LBB7_40:                                ## %poww.exit.i
                                        ##   in Loop: Header=BB7_37 Depth=1
	c0	ldw $r0.2 = 92[$r0.1]
;;
;;
	c0	shl $r0.4 = $r0.62, $r0.2
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.58 = $r0.63
	c0	mov $r0.2 = $r0.60
;;
	c0	or $r0.57 = $r0.4, 1
;;
	c0	cmplt $b0.0 = $r0.57, 2
;;
;;
	c0	br $b0.0, LBB7_42
;;
LBB7_41:                                ## %for.body.i.27.i
                                        ##   Parent Loop BB7_37 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.59
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_41
;;
LBB7_42:                                ## %poww.exit29.i
                                        ##   in Loop: Header=BB7_37 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.4 = 64[$r0.1]
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.61 = $r0.4
;;
LBB7_43:                                ## %for.body.i.19.preheader.i
                                        ##   in Loop: Header=BB7_37 Depth=1
	c0	stw 68[$r0.1] = $r0.3
;;
	c0	stw 88[$r0.1] = $r0.63
;;
	c0	ldw $r0.63 = 60[$r0.1]
;;
	c0	ldw $r0.58 = 64[$r0.1]
;;
LBB7_44:                                ## %for.body.i.19.i
                                        ##   Parent Loop BB7_37 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.57
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.63
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.63 = $r0.3
	c0	mov $r0.58 = $r0.4
;;
;;
	c0	br $b0.0, LBB7_44
;;
## BB#45:                               ## %fat.exit.i.67
                                        ##   in Loop: Header=BB7_37 Depth=1
	c0	mov $r0.5 = $r0.63
	c0	mov $r0.4 = $r0.61
	c0	ldw $r0.3 = 68[$r0.1]
	c0	mov $r0.6 = $r0.58
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 72[$r0.1]
;;
	c0	ldw $r0.4 = 84[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	add $r0.62 = $r0.62, 1
	c0	mov $r0.58 = $r0.4
	c0	mov $r0.61 = $r0.3
	c0	ldw $r0.63 = 88[$r0.1]
;;
;;
	c0	add $r0.63 = $r0.63, 2
	c0	cmpne $b0.0 = $r0.62, 31
;;
;;
	c0	br $b0.0, LBB7_37
;;
## BB#46:                               ## %sinx.exit
	c0	ldw $r0.3 = 52[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.6 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.58 = $r0.4
	c0	ldw $r0.5 = 76[$r0.1]
;;
	c0	ldw $r0.6 = 80[$r0.1]
;;
	c0	ldw $r0.3 = 36[$r0.1]
;;
	c0	ldw $r0.4 = 48[$r0.1]
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.5 = $r0.57
	c0	mov $r0.6 = $r0.58
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
	c0	ldw $r0.2 = 40[$r0.1]
;;
;;
	c0	stw 12[$r0.2] = $r0.3
;;
	c0	ldw $l0.0 = 96[$r0.1]
;;
	c0	ldw $r0.63 = 100[$r0.1]
;;
	c0	ldw $r0.62 = 104[$r0.1]
;;
	c0	ldw $r0.61 = 108[$r0.1]
;;
	c0	ldw $r0.60 = 112[$r0.1]
;;
	c0	ldw $r0.59 = 116[$r0.1]
;;
	c0	ldw $r0.58 = 120[$r0.1]
;;
.return ret()
	c0	ldw $r0.57 = 124[$r0.1]
	c0	return $r0.1 = $r0.1, 128, $l0.0
;;
.endp

#.globl inversek2j
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-128, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @inversek2j
inversek2j::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -128
;;
	c0	stw 124[$r0.1] = $r0.57
;;
	c0	stw 120[$r0.1] = $r0.58
;;
	c0	stw 116[$r0.1] = $r0.59
;;
	c0	stw 112[$r0.1] = $r0.60
;;
	c0	stw 108[$r0.1] = $r0.61
;;
	c0	stw 104[$r0.1] = $r0.62
;;
	c0	stw 100[$r0.1] = $r0.63
;;
	c0	stw 96[$r0.1] = $l0.0
;;
	c0	stw 32[$r0.1] = $r0.4
	c0	mov $r0.58 = $r0.3
;;
	c0	stw 48[$r0.1] = $r0.58
;;
	c0	stw 40[$r0.1] = $r0.5
;;
	c0	stw 36[$r0.1] = $r0.6
	c0	mov $r0.59 = l1
;;
	c0	stw 28[$r0.1] = $r0.59
	c0	mov $r0.3 = $r0.4
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.3 = $r0.58
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	ldw $r0.58 = 0[$r0.59]
	c0	mov $r0.4 = $r0.57
;;
.call float32_add, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_add
;;
	c0	mov $r0.57 = $r0.3
;;
	c0	stw 52[$r0.1] = $r0.57
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.3 = $r0.58
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	mov $r0.4 = $r0.3
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.57 = l2
;;
.call float32_sub, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	stw 24[$r0.1] = $r0.57
	c0	call $l0.0 = float32_sub
;;
	c0	ldw $r0.57 = 0[$r0.57]
	c0	mov $r0.59 = $r0.3
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.3 = $r0.58
;;
.call float32_add, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_add
;;
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.57
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.58
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.59
;;
.call float32_sub, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_sub
;;
	c0	mov $r0.4 = $r0.57
;;
.call float32_div, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_div
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.58 = 0
;;
	c0	stw 60[$r0.1] = $r0.58
	c0	mov $r0.2 = -1
;;
	c0	stw 56[$r0.1] = $r0.2
	c0	mov $r0.57 = 1
	c0	mov $r0.63 = $r0.3
;;
	c0	mov $r0.3 = 1072693248
;;
	c0	stw 88[$r0.1] = $r0.3
	c0	mov $r0.3 = 1071644672
;;
	c0	stw 64[$r0.1] = $r0.3
	c0	mov $r0.59 = $r0.4
	c0	mov $r0.61 = $r0.58
;;
	c0	stw 84[$r0.1] = $r0.58
	c0	mov $r0.5 = $r0.58
	c0	mov $r0.6 = $r0.58
;;
	c0	stw 80[$r0.1] = $r0.2
;;
LBB8_1:                                 ## %for.body.i
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB8_3 Depth 2
                                        ##     Child Loop BB8_6 Depth 2
                                        ##     Child Loop BB8_8 Depth 2
	c0	stw 68[$r0.1] = $r0.6
;;
	c0	stw 72[$r0.1] = $r0.5
;;
	c0	stw 76[$r0.1] = $r0.61
;;
	c0	stw 92[$r0.1] = $r0.57
	c0	add $r0.2 = $r0.57, -1
;;
	c0	ldw $r0.3 = 88[$r0.1]
;;
;;
	c0	stw 88[$r0.1] = $r0.3
	c0	mov $r0.62 = $r0.3
	c0	mov $r0.61 = $r0.58
	c0	mov $r0.60 = $r0.3
;;
	c0	mov $r0.57 = $r0.58
	c0	cmpeq $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB8_7
;;
## BB#2:                                ## %for.cond.preheader.i.i
                                        ##   in Loop: Header=BB8_1 Depth=1
	c0	cmplt $b0.0 = $r0.2, 2
	c0	ldw $r0.62 = 64[$r0.1]
;;
;;
	c0	mov $r0.60 = $r0.62
	c0	ldw $r0.57 = 80[$r0.1]
	c0	mov $r0.61 = $r0.58
	c0	br $b0.0, LBB8_4
;;
LBB8_3:                                 ## %for.body.i.i
                                        ##   Parent Loop BB8_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.58
	c0	mov $r0.5 = $r0.62
	c0	mov $r0.4 = $r0.61
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.61 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_3
;;
LBB8_4:                                 ## %poww.exit.i
                                        ##   in Loop: Header=BB8_1 Depth=1
	c0	stw 64[$r0.1] = $r0.62
;;
	c0	ldw $r0.2 = 92[$r0.1]
;;
;;
	c0	cmplt $b0.0 = $r0.2, 2
	c0	ldw $r0.62 = 88[$r0.1]
	c0	mov $r0.2 = $r0.58
;;
	c0	ldw $r0.58 = 84[$r0.1]
	c0	mov $r0.57 = $r0.2
;;
	c0	br $b0.0, LBB8_5
;;
LBB8_6:                                 ## %for.body.i.32.i
                                        ##   Parent Loop BB8_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.58
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.62
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.62 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_6
;;
	c0	goto LBB8_7
;;
LBB8_5:                                 ##   in Loop: Header=BB8_1 Depth=1
	c0	ldw $r0.62 = 88[$r0.1]
	c0	mov $r0.57 = $r0.2
;;
LBB8_7:                                 ## %fat.exit.i
                                        ##   in Loop: Header=BB8_1 Depth=1
	c0	ldw $r0.2 = 56[$r0.1]
;;
	c0	ldw $r0.3 = 92[$r0.1]
;;
;;
	c0	sh1add $r0.58 = $r0.3, $r0.2
;;
	c0	mov $r0.3 = $r0.58
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.5 = $r0.62
	c0	mov $r0.6 = $r0.57
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.60
	c0	mov $r0.4 = $r0.61
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	cmplt $b0.0 = $r0.58, 2
	c0	mov $r0.2 = $r0.63
	c0	ldw $r0.61 = 76[$r0.1]
;;
;;
	c0	mov $r0.58 = $r0.61
	c0	mov $r0.57 = $r0.4
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.6 = $r0.59
;;
	c0	br $b0.0, LBB8_9
;;
LBB8_8:                                 ## %for.body.i.26.i
                                        ##   Parent Loop BB8_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.5 = $r0.2
	c0	mov $r0.4 = $r0.59
	c0	mov $r0.3 = $r0.63
	c0	add $r0.58 = $r0.58, -1
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.6 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_8
;;
LBB8_9:                                 ## %poww.exit28.i
                                        ##   in Loop: Header=BB8_1 Depth=1
	c0	mov $r0.5 = $r0.2
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 68[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 72[$r0.1]
;;
	c0	ldw $r0.57 = 92[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, 1
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
	c0	ldw $r0.2 = 80[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 1
;;
	c0	stw 80[$r0.1] = $r0.2
	c0	add $r0.61 = $r0.61, 2
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.2 = 84[$r0.1]
;;
;;
	c0	add $r0.2 = $r0.2, 1
;;
	c0	stw 84[$r0.1] = $r0.2
;;
	c0	ldw $r0.58 = 60[$r0.1]
	c0	br $b0.0, LBB8_1
;;
## BB#10:                               ## %acosx.exit
	c0	mov $r0.4 = 1413754602
	c0	mov $r0.3 = 1073291771
;;
.call float64_sub, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_sub
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
	c0	mov $r0.57 = $r0.3
;;
	c0	stw 44[$r0.1] = $r0.57
;;
	c0	ldw $r0.2 = 40[$r0.1]
;;
	c0	ldw $r0.3 = 36[$r0.1]
;;
;;
	c0	sh2add $r0.58 = $r0.3, $r0.2
;;
	c0	stw 40[$r0.1] = $r0.58
	c0	mov $r0.3 = $r0.57
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	stw 4[$r0.58] = $r0.57
	c0	mov $r0.57 = 0
;;
	c0	stw 92[$r0.1] = $r0.57
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.62 = $r0.4
	c0	mov $r0.2 = -1
;;
	c0	stw 64[$r0.1] = $r0.2
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 68[$r0.1] = $r0.2
	c0	mov $r0.2 = 1
;;
	c0	stw 72[$r0.1] = $r0.2
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 88[$r0.1] = $r0.2
	c0	add $r0.2 = $r0.58, 4
;;
	c0	stw 36[$r0.1] = $r0.2
;;
	c0	ldw $r0.2 = 24[$r0.1]
;;
;;
	c0	ldw $r0.2 = 0[$r0.2]
;;
;;
	c0	stw 60[$r0.1] = $r0.2
	c0	mov $r0.58 = $r0.57
	c0	mov $r0.60 = $r0.57
;;
	c0	ldw $r0.2 = 28[$r0.1]
;;
;;
	c0	ldw $r0.2 = 0[$r0.2]
;;
;;
	c0	stw 56[$r0.1] = $r0.2
	c0	goto LBB8_11
;;
LBB8_12:                                ## %fat.exit.thread.i
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	ldw $r0.5 = 88[$r0.1]
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.58
;;
	c0	ldw $r0.6 = 92[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	mov $r0.60 = $r0.4
	c0	mov $r0.58 = $r0.3
	c0	ldw $r0.57 = 72[$r0.1]
;;
LBB8_11:                                ## %for.body.i.133
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB8_15 Depth 2
                                        ##     Child Loop BB8_18 Depth 2
                                        ##     Child Loop BB8_21 Depth 2
	c0	cmpne $b0.0 = $r0.57, 0
;;
;;
	c0	brf $b0.0, LBB8_12
;;
## BB#13:                               ## %for.cond.preheader.i.i.135
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	stw 84[$r0.1] = $r0.58
	c0	cmplt $b0.0 = $r0.57, 2
;;
	c0	ldw $r0.59 = 68[$r0.1]
;;
	c0	br $b0.0, LBB8_16
;;
## BB#14:                               ## %for.body.i.i.141.preheader
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	add $r0.2 = $r0.57, -1
	c0	ldw $r0.59 = 68[$r0.1]
;;
LBB8_15:                                ## %for.body.i.i.141
                                        ##   Parent Loop BB8_11 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, -1
	c0	xor $r0.59 = $r0.59, -2147483648
;;
	c0	cmpne $b0.0 = $r0.2, 0
;;
;;
	c0	br $b0.0, LBB8_15
;;
LBB8_16:                                ## %for.cond.preheader.i.18.i
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	stw 80[$r0.1] = $r0.60
;;
	c0	ldw $r0.2 = 72[$r0.1]
;;
;;
	c0	shl $r0.63 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.2 = $r0.62
;;
	c0	cmplt $b0.0 = $r0.63, 2
;;
;;
	c0	br $b0.0, LBB8_19
;;
## BB#17:                               ## %for.body.i.24.i.preheader
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	mov $r0.3 = $r0.61
	c0	ldw $r0.2 = 64[$r0.1]
;;
;;
	c0	sh1add $r0.58 = $r0.57, $r0.2
	c0	mov $r0.2 = $r0.62
;;
LBB8_18:                                ## %for.body.i.24.i
                                        ##   Parent Loop BB8_11 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_18
;;
LBB8_19:                                ## %poww.exit26.i
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.58 = 92[$r0.1]
;;
;;
	c0	stw 92[$r0.1] = $r0.58
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	cmplt $b0.0 = $r0.57, 1
	c0	ldw $r0.60 = 88[$r0.1]
;;
	c0	stw 76[$r0.1] = $r0.4
	c0	mov $r0.59 = $r0.3
;;
	c0	br $b0.0, LBB8_22
;;
## BB#20:                               ## %for.body.i.15.i.preheader
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	ldw $r0.60 = 88[$r0.1]
;;
	c0	ldw $r0.58 = 92[$r0.1]
;;
LBB8_21:                                ## %for.body.i.15.i
                                        ##   Parent Loop BB8_11 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.63
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.58
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.63 = $r0.63, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.63, 0
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.58 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_21
;;
LBB8_22:                                ## %fat.exit.i.155
                                        ##   in Loop: Header=BB8_11 Depth=1
	c0	mov $r0.5 = $r0.60
	c0	ldw $r0.4 = 76[$r0.1]
	c0	mov $r0.3 = $r0.59
	c0	mov $r0.6 = $r0.58
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 80[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 84[$r0.1]
	c0	add $r0.57 = $r0.57, 1
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.57, 31
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.60 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_11
;;
## BB#23:                               ## %cosx.exit
	c0	ldw $r0.59 = 60[$r0.1]
;;
;;
	c0	mov $r0.3 = $r0.59
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.5 = $r0.58
	c0	mov $r0.6 = $r0.60
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.58 = $r0.4
	c0	ldw $r0.3 = 56[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.5 = $r0.57
	c0	mov $r0.6 = $r0.58
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	stw 56[$r0.1] = $r0.3
;;
	c0	stw 28[$r0.1] = $r0.4
	c0	mov $r0.57 = 0
;;
	c0	stw 72[$r0.1] = $r0.57
;;
	c0	ldw $r0.3 = 32[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	stw 32[$r0.1] = $r0.3
;;
	c0	stw 24[$r0.1] = $r0.4
	c0	mov $r0.3 = $r0.59
;;
	c0	ldw $r0.4 = 48[$r0.1]
;;
;;
.call float32_mul, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
	c0	mov $r0.58 = $r0.57
	c0	mov $r0.59 = $r0.57
	c0	mov $r0.60 = $r0.57
;;
	c0	mov $r0.2 = -1074790400
;;
	c0	stw 64[$r0.1] = $r0.2
	c0	mov $r0.2 = 1072693248
;;
	c0	stw 68[$r0.1] = $r0.2
	c0	mov $r0.2 = 1
;;
	c0	stw 92[$r0.1] = $r0.2
;;
	c0	stw 60[$r0.1] = $r0.3
;;
LBB8_24:                                ## %for.body.i.108
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB8_26 Depth 2
                                        ##     Child Loop BB8_28 Depth 2
                                        ##     Child Loop BB8_31 Depth 2
	c0	stw 80[$r0.1] = $r0.59
;;
	c0	stw 84[$r0.1] = $r0.58
	c0	cmpeq $b0.0 = $r0.57, 0
	c0	mov $r0.63 = $r0.62
	c0	mov $r0.3 = $r0.61
;;
	c0	ldw $r0.59 = 92[$r0.1]
;;
	c0	br $b0.0, LBB8_30
;;
## BB#25:                               ## %for.cond.preheader.i.i.110
                                        ##   in Loop: Header=BB8_24 Depth=1
	c0	cmplt $b0.0 = $r0.57, 2
	c0	ldw $r0.63 = 64[$r0.1]
;;
	c0	ldw $r0.2 = 92[$r0.1]
;;
	c0	br $b0.0, LBB8_27
;;
LBB8_26:                                ## %for.body.i.i.116
                                        ##   Parent Loop BB8_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	add $r0.2 = $r0.2, 1
	c0	xor $r0.63 = $r0.63, -2147483648
;;
	c0	cmpne $b0.0 = $r0.57, $r0.2
;;
;;
	c0	br $b0.0, LBB8_26
;;
LBB8_27:                                ## %poww.exit.i.120
                                        ##   in Loop: Header=BB8_24 Depth=1
	c0	ldw $r0.2 = 92[$r0.1]
;;
;;
	c0	shl $r0.4 = $r0.57, $r0.2
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.58 = $r0.60
	c0	mov $r0.2 = $r0.62
;;
	c0	or $r0.59 = $r0.4, 1
;;
	c0	cmplt $b0.0 = $r0.59, 2
;;
;;
	c0	br $b0.0, LBB8_29
;;
LBB8_28:                                ## %for.body.i.27.i
                                        ##   Parent Loop BB8_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.2
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.58 = $r0.58, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.58, 0
	c0	mov $r0.2 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_28
;;
LBB8_29:                                ## %poww.exit29.i
                                        ##   in Loop: Header=BB8_24 Depth=1
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.4 = 72[$r0.1]
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.63 = $r0.4
;;
LBB8_30:                                ## %for.body.i.19.preheader.i
                                        ##   in Loop: Header=BB8_24 Depth=1
	c0	stw 76[$r0.1] = $r0.3
;;
	c0	stw 88[$r0.1] = $r0.60
;;
	c0	ldw $r0.58 = 68[$r0.1]
;;
	c0	ldw $r0.60 = 72[$r0.1]
;;
LBB8_31:                                ## %for.body.i.19.i
                                        ##   Parent Loop BB8_24 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.59
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.59, 0
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.60 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_31
;;
## BB#32:                               ## %fat.exit.i.131
                                        ##   in Loop: Header=BB8_24 Depth=1
	c0	mov $r0.5 = $r0.58
	c0	mov $r0.4 = $r0.63
	c0	ldw $r0.3 = 76[$r0.1]
	c0	mov $r0.6 = $r0.60
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 80[$r0.1]
;;
	c0	ldw $r0.4 = 84[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	add $r0.57 = $r0.57, 1
	c0	mov $r0.58 = $r0.4
	c0	mov $r0.59 = $r0.3
	c0	ldw $r0.60 = 88[$r0.1]
;;
;;
	c0	add $r0.60 = $r0.60, 2
	c0	cmpne $b0.0 = $r0.57, 31
;;
;;
	c0	br $b0.0, LBB8_24
;;
## BB#33:                               ## %sinx.exit
	c0	ldw $r0.3 = 60[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.5 = $r0.59
	c0	mov $r0.6 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.58 = $r0.4
	c0	ldw $r0.5 = 56[$r0.1]
;;
	c0	ldw $r0.6 = 28[$r0.1]
;;
	c0	ldw $r0.3 = 32[$r0.1]
;;
	c0	ldw $r0.4 = 24[$r0.1]
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.5 = $r0.57
	c0	mov $r0.6 = $r0.58
;;
.call float64_sub, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_sub
;;
	c0	mov $r0.57 = $r0.3
	c0	mov $r0.58 = $r0.4
	c0	ldw $r0.3 = 52[$r0.1]
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float32_to_float64
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.4 = $r0.58
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = 0
;;
	c0	stw 92[$r0.1] = $r0.2
;;
	c0	stw 56[$r0.1] = $r0.4
	c0	mov $r0.4 = 1
;;
	c0	stw 60[$r0.1] = $r0.4
	c0	mov $r0.59 = 1072693248
;;
	c0	stw 52[$r0.1] = $r0.59
	c0	mov $r0.4 = 1073741824
;;
	c0	stw 48[$r0.1] = $r0.4
;;
	c0	stw 80[$r0.1] = $r0.3
	c0	mov $r0.61 = $r0.2
	c0	mov $r0.3 = $r0.2
	c0	mov $r0.4 = $r0.2
;;
	c0	mov $r0.63 = $r0.2
;;
LBB8_34:                                ## %for.body.i.83
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB8_35 Depth 2
                                        ##     Child Loop BB8_38 Depth 2
                                        ##     Child Loop BB8_40 Depth 2
                                        ##     Child Loop BB8_42 Depth 2
	c0	stw 68[$r0.1] = $r0.4
;;
	c0	stw 72[$r0.1] = $r0.3
	c0	cmplt $b0.0 = $r0.63, 1
	c0	mov $r0.58 = $r0.59
	c0	mov $r0.57 = $r0.61
;;
	c0	ldw $r0.62 = 92[$r0.1]
;;
	c0	mfb $r0.2 = $b0.0
;;
	c0	stw 64[$r0.1] = $r0.2
	c0	br $b0.0, LBB8_36
;;
LBB8_35:                                ## %for.body.i.i.91
                                        ##   Parent Loop BB8_34 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.57
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.57 = $r0.57, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.57, 0
	c0	mov $r0.58 = $r0.3
	c0	mov $r0.62 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_35
;;
LBB8_36:                                ## %fat.exit.i.94
                                        ##   in Loop: Header=BB8_34 Depth=1
	c0	cmpeq $b0.0 = $r0.63, 0
	c0	mov $r0.3 = $r0.63
;;
	c0	stw 88[$r0.1] = $r0.3
	c0	mov $r0.63 = $r0.59
;;
	c0	ldw $r0.2 = 60[$r0.1]
;;
;;
	c0	shl $r0.2 = $r0.3, $r0.2
;;
	c0	stw 84[$r0.1] = $r0.2
;;
	c0	ldw $r0.60 = 92[$r0.1]
	c0	br $b0.0, LBB8_39
;;
## BB#37:                               ## %for.cond.preheader.i.i.95
                                        ##   in Loop: Header=BB8_34 Depth=1
	c0	ldw $r0.2 = 84[$r0.1]
;;
;;
	c0	cmplt $b0.0 = $r0.2, 2
	c0	ldw $r0.60 = 92[$r0.1]
;;
	c0	ldw $r0.63 = 48[$r0.1]
;;
	c0	ldw $r0.57 = 60[$r0.1]
	c0	br $b0.0, LBB8_39
;;
LBB8_38:                                ## %for.body.i.51.i
                                        ##   Parent Loop BB8_34 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.5 = $r0.63
	c0	mov $r0.4 = $r0.60
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.6 = $r0.60
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_add
;;
	c0	add $r0.57 = $r0.57, 1
	c0	mov $r0.63 = $r0.3
	c0	mov $r0.60 = $r0.4
;;
	c0	cmpne $b0.0 = $r0.61, $r0.57
;;
;;
	c0	br $b0.0, LBB8_38
;;
LBB8_39:                                ## %poww.exit53.i
                                        ##   in Loop: Header=BB8_34 Depth=1
	c0	stw 76[$r0.1] = $r0.61
	c0	mov $r0.61 = $r0.59
;;
	c0	ldw $r0.59 = 88[$r0.1]
;;
	c0	ldw $r0.57 = 92[$r0.1]
;;
	c0	ldw $r0.2 = 64[$r0.1]
;;
;;
	c0	mtb $b0.0 = $r0.2
;;
;;
	c0	br $b0.0, LBB8_41
;;
LBB8_40:                                ## %for.body.i.42.i
                                        ##   Parent Loop BB8_34 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.3 = $r0.59
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, -1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.59, 0
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_40
;;
LBB8_41:                                ## %fat.exit44.i
                                        ##   in Loop: Header=BB8_34 Depth=1
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.4 = $r0.57
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.6 = $r0.57
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.63
	c0	mov $r0.4 = $r0.60
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.4 = $r0.62
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.58
;;
	c0	ldw $r0.2 = 84[$r0.1]
;;
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	or $r0.62 = $r0.2, 1
	c0	call $l0.0 = float64_div
;;
	c0	cmplt $b0.0 = $r0.62, 2
	c0	ldw $r0.58 = 80[$r0.1]
;;
;;
	c0	mov $r0.61 = $r0.58
	c0	ldw $r0.59 = 92[$r0.1]
;;
	c0	stw 84[$r0.1] = $r0.4
;;
	c0	stw 64[$r0.1] = $r0.3
;;
	c0	ldw $r0.63 = 56[$r0.1]
;;
;;
	c0	mov $r0.57 = $r0.63
	c0	ldw $r0.60 = 76[$r0.1]
	c0	br $b0.0, LBB8_43
;;
LBB8_42:                                ## %for.body.i.25.i
                                        ##   Parent Loop BB8_34 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	c0	mov $r0.6 = $r0.57
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.4 = $r0.63
	c0	mov $r0.3 = $r0.58
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.59 = $r0.59, 1
	c0	call $l0.0 = float64_mul
;;
	c0	cmpne $b0.0 = $r0.60, $r0.59
	c0	mov $r0.61 = $r0.3
	c0	mov $r0.57 = $r0.4
;;
;;
	c0	br $b0.0, LBB8_42
;;
LBB8_43:                                ## %poww.exit.i.105
                                        ##   in Loop: Header=BB8_34 Depth=1
	c0	stw 80[$r0.1] = $r0.58
	c0	mov $r0.3 = $r0.62
;;
.call int32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = int32_to_float64
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	mov $r0.3 = $r0.61
	c0	mov $r0.4 = $r0.57
;;
	c0	mov $r0.6 = $r0.2
;;
.call float64_div, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_div
;;
	c0	mov $r0.2 = $r0.4
	c0	mov $r0.5 = $r0.3
	c0	ldw $r0.3 = 64[$r0.1]
;;
	c0	ldw $r0.4 = 84[$r0.1]
	c0	mov $r0.6 = $r0.2
;;
.call float64_mul, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	call $l0.0 = float64_mul
;;
	c0	mov $r0.6 = $r0.4
	c0	ldw $r0.4 = 68[$r0.1]
	c0	mov $r0.5 = $r0.3
;;
	c0	ldw $r0.3 = 72[$r0.1]
;;
	c0	ldw $r0.63 = 88[$r0.1]
;;
;;
.call float64_add, caller, arg($r0.3:u32,$r0.4:u32,$r0.5:u32,$r0.6:u32), ret($r0.3:u32,$r0.4:u32)
	c0	add $r0.63 = $r0.63, 1
	c0	call $l0.0 = float64_add
;;
	c0	cmpne $b0.0 = $r0.63, 31
	c0	add $r0.60 = $r0.60, 2
	c0	ldw $r0.59 = 52[$r0.1]
;;
	c0	mov $r0.61 = $r0.60
;;
	c0	br $b0.0, LBB8_34
;;
## BB#44:                               ## %asinx.exit
.call float64_to_float32, caller, arg($r0.3:u32,$r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float64_to_float32
;;
	c0	ldw $r0.2 = 40[$r0.1]
;;
;;
	c0	stw 0[$r0.2] = $r0.3
;;
	c0	ldw $r0.2 = 44[$r0.1]
;;
	c0	ldw $r0.3 = 36[$r0.1]
;;
;;
	c0	stw 0[$r0.3] = $r0.2
;;
	c0	ldw $l0.0 = 96[$r0.1]
;;
	c0	ldw $r0.63 = 100[$r0.1]
;;
	c0	ldw $r0.62 = 104[$r0.1]
;;
	c0	ldw $r0.61 = 108[$r0.1]
;;
	c0	ldw $r0.60 = 112[$r0.1]
;;
	c0	ldw $r0.59 = 116[$r0.1]
;;
	c0	ldw $r0.58 = 120[$r0.1]
;;
.return ret()
	c0	ldw $r0.57 = 124[$r0.1]
	c0	return $r0.1 = $r0.1, 128, $l0.0
;;
.endp

.section .data
#.globl entry_number                    ## @entry_number
	.align	4
entry_number:
	.data4	9                       ## 0x9

#.globl theta1                          ## @theta1
	.align	4
theta1:
	.data4	1063731430              ## float 9.033340e-01
	.data4	1068609892              ## float 1.388226e+00
	.data4	1046457440              ## float 2.184310e-01
	.data4	1060479502              ## float 7.095040e-01
	.data4	1042196766              ## float 1.549420e-01
	.data4	1046316445              ## float 2.163300e-01
	.data4	1053766300              ## float 4.046830e-01
	.data4	1068678192              ## float 1.396368e+00
	.data4	1063828704              ## float 9.091320e-01

#.globl theta2                          ## @theta2
	.align	4
theta2:
	.data4	1062811417              ## float 8.484970e-01
	.data4	1053615909              ## float 4.002010e-01
	.data4	1065818834              ## float 1.055506e+00
	.data4	1067112274              ## float 1.209696e+00
	.data4	1066920711              ## float 1.186860e+00
	.data4	1057831554              ## float 5.516740e-01
	.data4	1068396116              ## float 1.362742e+00
	.data4	1051123721              ## float 3.259280e-01
	.data4	1068086292              ## float 1.325808e+00

	.section .data  .comm 	outputFileName,32,1     ## @outputFileName
	.section .data  .comm 	t1t2xy,144,4            ## @t1t2xy
	.section .data  .comm 	inputFileName,32,1      ## @inputFileName
	.section .data  .comm 	string,64,1             ## @string
	.section	.data 
.str:                                   ## @.str
	.data1 119
	.data1 0
.skip 6

.str.1:                                 ## @.str.1
	.data1 37
	.data1 102
	.data1 10
	.data1 0
.skip 4

.section .data
#.globl l1                              ## @l1
	.align	4
l1:
	.data4	1056964608              ## float 0.5

#.globl l2                              ## @l2
	.align	4
l2:
	.data4	1056964608              ## float 0.5


.import fclose
.type fclose, @function
.import float32_add
.type float32_add, @function
.import float32_div
.type float32_div, @function
.import float32_mul
.type float32_mul, @function
.import float32_sub
.type float32_sub, @function
.import float32_to_float64
.type float32_to_float64, @function
.import float64_add
.type float64_add, @function
.import float64_div
.type float64_div, @function
.import float64_mul
.type float64_mul, @function
.import float64_sub
.type float64_sub, @function
.import float64_to_float32
.type float64_to_float32, @function
.import fopen
.type fopen, @function
.import forwardk2j
.type forwardk2j, @function
.import fprintf
.type fprintf, @function
.import int32_to_float64
.type int32_to_float64, @function
.import inversek2j
.type inversek2j, @function
.import strcpy
.type strcpy, @function
