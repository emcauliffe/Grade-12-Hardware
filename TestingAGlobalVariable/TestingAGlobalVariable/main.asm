;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
;

/*

Count the number of set bits in rIn

*/

#define rIn 4

ldi r16,1<<5|1<<4
out 0x04,r16	;enable output for PB5 and PB4

ldi r16,rIn		;input value
tst r16			;test if loaded value is zero (only exception)
breq isNot		;zero is not a power
mov r17,r16		;copy to new register
dec r17			;subtract one
and r17,r16		;and with original input
brne isNot		;if value is not zero, input is not a power
rcall green
rjmp wait

isNot:
	rcall red
	rjmp wait

green:
	ldi r16,1<<5
	out 0x05,r16
	ret

red:
	ldi r16,1<<4
	out 0x05,r16
	ret

wait:
	rjmp wait