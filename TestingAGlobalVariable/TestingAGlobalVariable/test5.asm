;
; TestingAGlobalVariable.asm
;
; Created: 2017-11-15 1:42:02 PM
; Author : Ethan McAuliffe
; not functional


; Replace with your application code
start:
	ldi		r16,0b00001100
	out		0x04,r16
	ldi		r16,128
	clc
	sbci	r16,127
	brpl	greater
	rcall	red
	rjmp wait

greater:
	rcall green
	rjmp wait

green:
  ldi r16, 1<<3
  out 0x05, r16 ;/*digitalWrite(13,HIGH);*/
ret

red:
  ldi r16, 1<<2
  out 0x05, r16 ;/*digitalWrite(13,HIGH);*/
ret

wait:
	rjmp wait