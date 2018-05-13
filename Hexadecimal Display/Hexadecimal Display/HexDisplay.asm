;
; Hexadecimal Display.asm
;
; Created: 2017-12-15 8:57:15 AM
; Author : Ethan McAuliffe
;

.cseg						;load into Program Memory
 .org	0x0000				;start of Interrupt Vector (Jump) Table
	rjmp	reset				;address  of start of code
 startTable:					;data tables can be loaded into Program Memory, too!
	.DB	0b0011_1111, 0b0000_0110, 0b0101_1011, 0b0100_1111, 0b0110_0110, 0b0110_1101, 0b0111_1101, 0b0000_0111, 0b0111_1111, 0b0110_1111, 0b0111_0111, 0b0111_1100, 0b0011_1001, 0b0101_1110, 0b0111_1001, 0b1111_0001	;byte values for segment animation

 endTable:
.org	0x100					;abitrary address for start of code 
 reset:
	ldi		r16, low(RAMEND)	;ALL assembly code should start by
	out		spl,r16			; setting the Stack Pointer to 
	ldi		r16, high(RAMEND)	; the end of SRAM to support
	out		sph,r16			; function calls, etc.

	rcall	initPorts		;set I/O Direction

	ldi		xl,low(startTable<<1)	;position X and Y pointers to the
	ldi		xh,high(startTable<<1)	; start and end addresses of 
	ldi		yl,low(endTable<<1)	; our data table, respectively
	ldi		yh,high(endTable<<1)	;
	movw	z,x						;start Z pointer off at the start address of the table.

more:
	lpm		r19,z+				;Load the first instance of the test data from Program Memory
	out		PORTD,r19
	rcall	myDelay				;admire...
	cp		zl,yl				;have we reached the end of the table?  (Z==Y?)
	brne	more						; if not, repeat with next byte...
	movw	z,x						; if so, reset Z pointer to start address of table and repeat  
	rjmp more

initPorts:
	ser r16
	out DDRD,r16					;declare PORTD for output
	clr r16
	ret

myDelay:
; Generated by delay loop calculator
; at http://www.bretmulvey.com/avrdelay.html
; Delay 4 000 000 cycles
; 250ms at 16 MHz

    ldi  r20, 21
    ldi  r21, 75
    ldi  r22, 191
L1: dec  r22
    brne L1
    dec  r21
    brne L1
    dec  r20
    brne L1
    nop
ret
