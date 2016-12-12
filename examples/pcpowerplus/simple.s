	.text
#.globl main
.section .text 
.proc 
.entry caller, sp=$r0.1, rl=$l0.0, asize=-0, arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32) ## @main
main::
## BB#0:                                ## %entry
	c0	mov $r0.2 = a
	c0	mov $r0.3 = b
;;
	c0	ldwvec256 $hmcreg0 = 192[$r0.2]
	c0	ldwvec256 $hmcreg1 = 192[$r0.3]
	c0	ldwvec256 $hmcreg2 = 0[$r0.3]
	c0	ldwvec256 $hmcreg3 = 0[$r0.2]
	c0	ldwvec256 $hmcreg4 = 64[$r0.3]
	c0	ldwvec256 $hmcreg7 = 64[$r0.2]
	c0	ldwvec256 $hmcreg8 = 128[$r0.3]
	c0	ldwvec256 $hmcreg9 = 128[$r0.2]
	c0	ldwvec256 $hmcreg10 = 32[$r0.3]
	c0	ldwvec256 $hmcreg11 = 32[$r0.2]
	c0	ldwvec256 $hmcreg12 = 160[$r0.2]
	c0	ldwvec256 $hmcreg13 = 160[$r0.3]
	c0	ldwvec256 $hmcreg14 = 96[$r0.2]
	c0	ldwvec256 $hmcreg15 = 96[$r0.3]
	c0	ldwvec256 $hmcreg16 = 224[$r0.3]
	c0	ldwvec256 $hmcreg17 = 224[$r0.2]
;;
	c0	mov $r0.2 = c
	c0	mov $r0.3 = 0
	c0	add256 $hmcreg2 = $hmcreg2, $hmcreg3
	c0	add256 $hmcreg3 = $hmcreg10, $hmcreg11
	c0	add256 $hmcreg4 = $hmcreg4, $hmcreg7
	c0	add256 $hmcreg7 = $hmcreg15, $hmcreg14
	c0	add256 $hmcreg8 = $hmcreg8, $hmcreg9
	c0	add256 $hmcreg9 = $hmcreg13, $hmcreg12
	c0	add256 $hmcreg0 = $hmcreg1, $hmcreg0
	c0	add256 $hmcreg1 = $hmcreg16, $hmcreg17
;;
.return ret($r0.3:u32)
	c0	stwvec256 0[$r0.2] = $hmcreg2
	c0	stwvec256 32[$r0.2] = $hmcreg3
	c0	stwvec256 64[$r0.2] = $hmcreg4
	c0	stwvec256 96[$r0.2] = $hmcreg7
	c0	stwvec256 128[$r0.2] = $hmcreg8
	c0	stwvec256 160[$r0.2] = $hmcreg9
	c0	stwvec256 192[$r0.2] = $hmcreg0
	c0	stwvec256 224[$r0.2] = $hmcreg1
	c0	return $r0.1 = $r0.1, 0, $l0.0
;;
.endp

	.comm	a,256,4                 ## @a
	.comm	b,256,4                 ## @b
	.comm	c,256,4                 ## @c

