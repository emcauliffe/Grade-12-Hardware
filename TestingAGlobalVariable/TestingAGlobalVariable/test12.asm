;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
;

/*

Count the number of set bits in rIn
The output is an integer and is placed into rOut

*/
#define rIn 5

ldi r16,1<<5|1<<4
out 0x04,r16	;enable output for PB5 and PB4

ldi r16,rIn		;input value
clr r19			;zero 'set bit' count

again:
	mov r18,r16		;copy
	ldi r17,11		;mask
	and r18,r17		;test
	sbrc r18,0
	inc r19
	asr r16
	brne again

sbrc r19, 0
rjmp isOdd
rjmp isEven

isOdd:
	rcall red
	rjmp wait

isEven:
	rcall green
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