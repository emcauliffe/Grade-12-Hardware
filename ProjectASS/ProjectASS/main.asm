;
; ProjectASS.asm
;
; Created: 2017-11-14 2:40:40 PM
; Author : Ethan McAuliffe
;


; Replace with your application code
start:
    ldi r16,1<<5
    out 0x04,r16
	out 0x05,r16
	clr r17 
loop:
	eor  r17,r16
	out  0x05,r17	
    ldi  r18, 82
    ldi  r19, 43
    ldi  r20, 0
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    lpm
    nop
	rjmp loop