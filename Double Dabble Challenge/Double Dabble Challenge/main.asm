;
; Double Dabble Challenge.asm
;
; Created: 2017-12-21 7:00:27 PM
; Author : Ethan McAuliffe
;
#define VALUE 243
start:
    ldi r16,VALUE
	ldi r22,8
	ldi r23,3
	ldi r24,48

loop:
	lsl r16
	adc r17,r25
	dec r22
	breq wait
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
wait:
	rjmp wait