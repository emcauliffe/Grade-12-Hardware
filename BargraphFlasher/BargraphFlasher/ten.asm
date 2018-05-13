;
; BargraphFlasher.asm
;
; Created: 2017-12-05 3:13:26 PM
; Author : Ethan McAuliffe
;


; Replace with your application code
start:
    ldi r16,0xFF
	out 0x0A,r16
	ldi r16,0x03
	out 0x04,r16
	ldi r16,0xAA
cycle:
	com r16
	out 0x0B,r16
	out 0x05,r16
	rcall wait
    rjmp cycle

wait:
; Generated by delay loop calculator
; at http://www.bretmulvey.com/avrdelay.html
;
; Delay 16 000 000 cycles
; 1s at 16.0 MHz
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
ret