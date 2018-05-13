;
; TimerInterruptBlink.asm
;
; Created: 2018-01-31 9:12:27 AM
; Author : Ethan McAuliffe
;
#include "prescalers.h"
;.def toggleReg,r17

.org TIM1_OVF
	

.org 0x0040
start:
	;ldi toggleReg,toggle
	ldi r16,(1<<PB5)
	out DDRB,r16
	clr r16

	ldi T1psNone,r16

toggle:

