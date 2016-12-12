	#.text
#.globl main
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-32, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @main
main::
## BB#0:                                ## %entry
	c0	add $r0.1 = $r0.1, -32
;;
	c0	stw 28[$r0.1] = $r0.57
;;
	c0	stw 24[$r0.1] = $r0.58
;;
	c0	stw 20[$r0.1] = $r0.59
	c0	mov $r0.2 = b
	c0	mov $r0.3 = a
;;
	c0	ldw $r0.4 = 0[$r0.2]
;;
	c0	ldw $r0.3 = 0[$r0.3]
	c0	mov $r0.57 = .str
	c0	mov $r0.59 = c
	c0	mov $r0.58 = .str1
;;
.call float32_mul, caller, arg($r0.3:u32, $r0.4:u32), ret($r0.3:u32)
	c0	call $l0.0 = float32_mul
;;
.call printf, caller, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32), ret($r0.3:s32)
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.4 = $r0.3
	c0	call $l0.0 = printf
;;
.call float32_to_float64, caller, arg($r0.3:u32), ret($r0.3:u32, $r0.4:u32)
	c0	mov $r0.3 = $r0.60
	c0	stw 0[$r0.59] = $r0.60
	c0	call $l0.0 = float32_to_float64
;;
.call printf, caller, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32), ret($r0.3:s32)
	c0	mov $r0.60 = $r0.3
	c0	mov $r0.61 = $r0.4
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.4 = $r0.3
	c0	call $l0.0 = printf
;;
.call printf, caller, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32), ret($r0.3:s32)
	c0	mov $r0.3 = $r0.57
	c0	mov $r0.4 = $r0.61
	c0	call $l0.0 = printf
;;
	c0	mov $r0.2 = $r0.3
	c0	mov $r0.6 = $r0.4
	c0	mov $r0.3 = $r0.58
	c0	mov $r0.4 = $r0.0
	c0	mov $r0.5 = $r0.3
;;
.call printf, caller, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32), ret($r0.3:s32)
	c0	mov $r0.5 = $r0.61
	c0	mov $r0.6 = $r0.60
	c0	call $l0.0 = printf
;;
	c0	mov $r0.3 = $r0.0
	c0	ldw $r0.59 = 20[$r0.1]
;;
	c0	ldw $r0.58 = 24[$r0.1]
;;
.return ret($r0.3:s32)
	c0	ldw $r0.57 = 28[$r0.1]
	c0	return $r0.1 = $r0.1, 32, $l0.0
;;
.endp

.section	.data
#.globl a                               ## @a
	.align	4
a:
	.data4	1067030938              ## float 1.20000005

#.globl b                               ## @b
	.align	4
b:
	.data4	1075419546              ## float 2.4000001

	.comm	c,4,4                   ## @c
	.section	.data
.str:                                   ## @.str
	.data1 37
	.data1 100
	.data1 10
	.data1 0
.skip 4
.str1:                                   ## @.str
	.data1 37
	.data1 102
	.data1 10
	.data1 0
.skip 4


.import float32_mul
.type float32_mul, @function
.import float32_to_float64
.type float32_to_float64, @function
.import printf
.type printf, @function
.import _d_r
.type _d_r, @function
