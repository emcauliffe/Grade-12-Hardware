;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
;


; Replace with your application code
ldi r16, 1<<5|1<<4
out 0x04, r16 ; enable output for PB5 and PB4

ldi r16, 0x32	;input value
mov r17,r16		;copy to r17
swap r17		;flip nibbles
cp r16,r17		;subtracts registers, keeps register values, sets flags
breq sameNibble	
rcall red
rjmp wait

sameNibble:
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