;
; DoubleDabblePOV.asm
;
; Created: 2018-01-09 8:41:35 AM
; Author : Ethan McAuliffe
;
#define VALUE 80

start:
	clr r17
	clr r18
	clr r19
	clr r20
	clr r25
	clr r21
	ldi r16,0x0F
	out DDRC,r16
	ldi r16,0x07
	out DDRB,r16
    ldi r16,VALUE
	ldi r22,8
	ldi r23,3
	ldi r24,48
loop:
	lsl r16
	adc r17,r25
	dec r22
	breq pov
	mov r21,r17
	andi r21,0x0F
	cpi r21,4
	brsh addThreeOnes
part1:
	cpi r17,80
	brsh testTens
part2:
	lsl r18
	lsl r17
	adc r18,r25
rjmp loop
addThreeOnes:
	add r17,r23
rjmp part1
addThreeTens:
	add r17,r24
rjmp part2
testTens:
	mov r20,r17
	andi r20,0xF0
	cpi r20,80
	brsh addThreeTens
rjmp part2

pov:	
	out PORTC,r18
	sbi PORTB,2
	rcall delay
	cbi PORTB,2

	swap r17
	out PORTC,r17
	swap r17
	sbi PORTB,1
	rcall delay
	cbi PORTB,1

	out PORTC,r17
	sbi PORTB,0
	rcall delay
	cbi PORTB,0
rjmp pov

delay:
; Generated by delay loop calculator
; at http://www.bretmulvey.com/avrdelay.html
;
; Delay 160 000 cycles
; 10ms at 16 MHz

    ldi  r20, 208
    ldi  r19, 202
L1: dec  r19
    brne L1
    dec  r20
    brne L1
    nop
ret