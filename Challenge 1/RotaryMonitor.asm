;
; Challenge 1.asm
;
; Created: 2017-12-01 1:58:44 PM
; Author : Ethan McAuliffe
;

#define TEST_BIT 0b00001111
; Replace with your application code
start:
    ldi r16,0x18
	out 0x17,r16
	clr r16

load:
	clr r16
	in r16,0x16

again:
	andi r16,0x0F
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
	rjmp load

isEven:
	rcall green
	rjmp load

green:
	ldi r16,0x10
	out 0x18,r16
	ret

red:
	ldi r16,0x08
	out 0x18,r16
	ret