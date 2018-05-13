;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
;


; Replace with your application code
ldi r16, 1<<5|1<<4
out 0x04, r16		;enable output for PB5 and PB4

ldi r16, 65			;input value
ldi r17,7			;mask
and r17,r16			;test by ANDing input and mask
breq isDivisible	;value passes test
rcall red

rjmp wait

isDivisible:
	rcall green
	rjmp wait

green:
	ldi r16, 1<<5
	out 0x05, r16
	ret

red:
	ldi r16, 1<<4
	out 0x05, r16
	ret

wait:
	rjmp wait