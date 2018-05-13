;
; DCfan.asm
;
; Created: 2018-04-11 1:39:45 PM
; Author : Ethan McAuliffe
; 
#include "prescalers.h"

#define F_CPU 16000000; cpu freq 16 Mhz
#define PRESCALE 8
#define F_FAN 25000
#define FREQ F_CPU/PRESCALE/F_FAN ; (OCR2A) = 80
#define DUTY 40 ; start with a 40% duty cycle
.def duty =r19;

.dseg
RPMStart:
.db	900,900,900,900,1200,2000
RPMEnd:
.cseg

.org 0x0000
	rjmp reset
.org 0x0020
	rjmp TIM0_OVF	
.org 0x002A
	rjmp ADC_Complete

.org 0x0040

reset:
	cli					;
	
	rcall RPMInit		;
	rcall PWMInit		;
	rcall ADCInit		;
	rcall TM0Init		;
;	rcall UARTInit		;
;	rcall PIDInit		;
	sei
wait:
	rjmp wait

RPMInit:
	ldi xl,low(RPMStart << 1)
	ldi xh,low(RPMStart << 1)
	ldi yl,low(RPMEnd << 1)
	ldi yh,low(RPMEnd << 1)
	movw z,x
ret

PWMInit:
	ldi r16,1 << PORTD3
	out DDRD,r16
	ldi r16,(1 << COM2B1) | (1 << WGM21) | (1 << WGM20) ; OC2A disconnected, OC2B connected, MODE 7 (OCR2A as TOP)
	sts TCCR2A,r16
	ldi r16,(1 << WGM22) | (1 << T2ps8) ; complete WGM definition and prescaler
	sts TCCR2B,r16
	ldi r16,FREQ
	sts OCR2A,r16
	ldi r16,DUTY
	sts OCR2B,r16
ret

ADCInit:
	ser r16
	sts DIDR0,r16	;disable pins to reduce power consumption
	ldi r16,(1<<REFS0)|(1<<ADLAR)	;
	sts	ADMUX,r16					;
	;Enable, start dummy conversion, enable timer as trigger, , prescaler...
	ldi	r16,(1<<ADEN)|(1<<ADSC)|(1<<ADATE)|(1<<ADIE)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)	;
	sts ADCSRA,r16					;
	ldi r16,(1<<ADTS2)				;
	sts ADCSRB,r16					;
dummy:
	;first read is not accurate - start conversion, check for data, throw away
	lds	r16,ADCSRA	;load ADCSRA register to check dummy flag
	andi	r16,1<<ADIF
	breq	dummy
ret

TM0Init:
	clr r16				;
	out TCCR0A,r16		;
	ldi r16,T0ps1024	;2^24/2^10/2^8 = 2^6 = 64 ADC/sec
	out TCCR0B,r16			;
	ldi r16,(1<<TOIE0)
	sts TIMSK0,r16		;
ret

TIM0_OVF:
reti

ADC_Complete:
	lds	duty,ADCH		;
	sts OCR2B,duty		;
reti