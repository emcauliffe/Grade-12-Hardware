;
; ShiftBar.asm
;
; Created: 2017-12-11 8:49:29 AM
; Author : Ethan McAuliffe
;
start:
	ldi r16,0x07	;enable output for first 3 pins of portD
	out DDRD,r16
	ldi r16,0x01	;animaiton begins with one light on
loop:
	rcall pause		;half second pause between each light turning on
	mov r18,r16		;copy register 16 to 18
	mov r17,r16		;copy register 16 to 17
	ldi r19,0x08	;load register at 8 (one for each light)
increment:
	sbrc r17,0		;if bit zero of r17 is a one
	rcall one		;pulse data and clock
	sbrs r17,0		;if bit zero is a zero
	rcall zero		;pulse clock
	lsr r17			;shift register one bit right
	dec r19			;subtract one from number of bits to complete
	brne increment	;loop back if there are still bits to send
	rcall latch		;otherwise send data
	com r18			;if register 16 is full
	breq start		;restart program
	sec				;otherwise shift in a one
	rol r16			;at the end of r16
rjmp loop			;repeat until r16 is full

one:
	sbi PORTD,0		;Data pin high
	sbi PORTD,2		;clock pin high
	cbi PORTD,2		;clock pin low
	cbi PORTD,0		;data pin low
ret
zero:
	sbi PORTD,2
	cbi PORTD,2		;toggle clock
ret
latch:
	sbi PORTD,1
	cbi PORTD,1		;toggle latch
ret
pause:
	ldi  r18, 41
    ldi  r19, 150
    ldi  r20, 128
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
ret