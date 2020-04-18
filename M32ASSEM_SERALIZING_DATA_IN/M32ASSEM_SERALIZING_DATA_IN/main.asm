;
; M32ASSEM_SERALIZING_DATA_IN.asm
;
; Created: 22-Nov-17 01:08:28 AM
; Author : Mahmoud
;

		.ORG 0X00
		LDI R16,HIGH(RAMEND)
		OUT SPH,R16
		LDI R16,LOW(RAMEND)
		OUT SPL,R16
	  
MAIN  :	
		CBI DDRC,7
		LDI R16,0XFF
		OUT DDRB,R16
		LDI R16,8
		
LOOP :	
		SBIC PINC,7
		RJMP HIN
		CLC
		RJMP CONT
HIN  :	SEC
CONT :	ROL R20
		DEC R16
		BRNE LOOP
		OUT PORTB,R20
HERE :	RJMP HERE