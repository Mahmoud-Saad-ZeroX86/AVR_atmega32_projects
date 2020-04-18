;
; M32ASSEM_COND-BRANCHING.asm
;
; Created: 20-Nov-17 06:39:03 PM
; Author : Mahmoud
;


.ORG 0X00

;STACK INITIALIZATION
		LDI R16,HIGH (RAMEND)
		OUT SPH,R16
		LDI R16,LOW (RAMEND)
		OUT SPL,R16

;THE MAIN PROGRAM
		
		LDI R16,0XFF
		OUT DDRC,R16
		LDI R16,0X00 
		OUT DDRB,R16
		LDI R17,0X45
MAIN  :	CLR R16
		OUT PORTC,R16
AGAIN : 
		IN R16,PINB
		EOR R16,R17
		BRNE AGAIN	;BRANCH IF NOT EQUAL I.E WHEN Z=0
		LDI R16,0X99
		OUT PORTC,R16
		RJMP MAIN
