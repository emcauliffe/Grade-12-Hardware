;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
; not functional

ldi r16, 1<<5|1<<4
out 0x04, r16 ; enable output for PB5 and PB4

ldi r16, 1
clc
sbci r16, 12
brpl greater
rcall red

rjmp wait

greater:
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