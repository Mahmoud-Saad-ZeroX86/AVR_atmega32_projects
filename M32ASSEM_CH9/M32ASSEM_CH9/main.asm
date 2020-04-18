;
; M32ASSEM_CH9.asm
;
; Created: 03/04/2018 03:54:14
; Author : Mahmoud Saad ZeroX86 
;
;INCLUDING THE ATMEG32 HEADER FILE
.INCLUDE "M32DEF.INC"

.ORG 0X00

;STACK INITIALIZATION 
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16



;TIMER-1,PRESCALER=256 TO GENERATE 1 SEC DELAY ON THE CTC MODE WHILE XTL=8MHZ
;NO OF CLOCKS NEEDED=31250=0X7A12
;SO WILL SET TCNT1=85EF
/*
.MACRO DELAY_T1_1SEC_PSC256
			LDI R16,0X00
			OUT TCNT1H,R16
			LDI R16,0X00
			OUT TCNT1L,R16
			LDI R16,HIGH(34285)
			OUT OCR1AH,R16
			LDI R16,LOW(34285)
			OUT OCR1AL,R16
			LDI R16,0X00
			OUT TCCR1A,R16
			LDI R16,0X0C ;CTC & PRESCALE OF 256
			OUT TCCR1B,R16
CHECK_OCF1A :IN  R16,TIFR
			SBRS R16,OCF1A
			RJMP CHECK_OCF1A
			LDI R16,0X00
			OUT TCCR1B,R16
			LDI R16,(1<<OCF1A)
			OUT TIFR,R16
.ENDMACRO
LDI R16,0XFF
OUT DDRA,R16

LDI R17,0X0F
MAIN :
		
		OUT PORTA,R17
		COM R17
		DELAY_T1_1SEC_PSC256
RJMP MAIN
*/





/*
.MACRO DELAYMS

		LDI R19,2
LOOP :	LDI R16,00 
		OUT OCR1AH,R16
		LDI R16,99 
		OUT OCR1AL,R16
		LDI R16,0X00
		OUT TCCR1A,R16
		LDI R16,0X04
		OUT TCCR1B,R16

CHECK_MATCHING :
		IN R16,TIFR
		SBRS R16,OCF1A
		RJMP CHECK_MATCHING
		LDI R16,1<<OCF1A
		OUT TIFR,R16
		DEC R19
		BRNE LOOP
.ENDMACRO


		LDI R16,0X01
		OUT DDRC,R16
MAIN :
		
		SBI PORTC,0
		DELAYMS
		CBI PORTC,0
		DELAYMS

RJMP MAIN

*/






//BUZZING EVERY 100 COUNTS USING MACRO :D 
/*
.MACRO DELAY 
		LDI @0,@1
LOOP :	LDI R16,0X00
		OUT TCCR1A,R16
		LDI R16,0X04
		OUT TCCR1B,R16
		LDI R16,00 
		OUT OCR1AH,R16
		LDI R16,99 
		OUT OCR1AL,R16
CHECK_MATCHING :
		IN R16,TIFR
		SBRS R16,OCF1A
		RJMP CHECK_MATCHING
		LDI R16,1<<OCF1A
		OUT TIFR,R16
		DEC @0
		BRNE LOOP
.ENDMACRO
		LDI R16,0X01
		OUT DDRC,R16
MAIN :
		
		SBI PORTC,0
		DELAY R19,1
		CBI PORTC,0
		DELAY R19,1

RJMP MAIN
*/

//16BIT TIMER1
/*
MAIN :
CBI DDRB,1

COM R16
OUT DDRC,R16
OUT DDRD,R16

LDI R16,0X00
OUT TCCR1A,R16
LDI R16,0X06
OUT TCCR1B,R16
LOOP : IN R16,TCNT1L
	   IN R17,TCNT1H
	   OUT PORTC,R16
	   OUT PORTD,R17
	   IN R16,TIFR
	   SBRS R16,TOV1
	   RJMP LOOP
	   LDI R16,1<<TOV1
	   OUT TIFR,R16
	  
	   RJMP LOOP


RJMP MAIN
*/


//WITH AN 8 BIT COUNTER,WORK WITH 16BIT REGISTERS
/*
MAIN :
		LDI R16,0XFF
		OUT DDRC,R16
		OUT DDRD,R16
		CLR R17
		CBI DDRB,0
		LDI R16,0X07  ;DEFINEING THE TIMER TO WORK AS COUNTER ON FALLING EDGE
		OUT TCCR0,R16
cHECKaGAIN :
		IN R16,TCNT0
		OUT PORTC,R16
		IN R16,TIFR
		SBRS R16,TOV0
		RJMP cHECKaGAIN
		LDI R16,1<<TOV0
		OUT TIFR,R16
		INC R17
		OUT PORTD,R17
		RJMP cHECKaGAIN
*/

;DELAY USING MACROS :D
/*
LDI R16,0XFF
OUT DDRA,R16


.MACRO DELAYMICROS
LDI @0,@1
AGAIN :
LDI R16,0X00
OUT TCNT0,R16
LDI R16,0X01
OUT TCCR0,R16
LOOP_DELAY:
		IN R16,TIFR
		SBRS R16,TOV0
		RJMP LOOP_DELAY			
DEC @0
BRNE AGAIN
.ENDMACRO
MAIN :	
		LDI R16,0XFF
		OUT PORTA,R16
		DELAYMICROS R17,10
		LDI R16,0X00
		OUT PORTA,R16
 		DELAYMICROS R17,20

RJMP MAIN
*/

;TIMER0 USING TOV0 FLAG BIT
/*
DELAY :
		LDI COUNTER,10
		AGAIN :	
		LDI R16,0X00
		OUT TCNT0,R16
		LDI R16,0X01
		OUT TCCR0,R16
CHECK_TOV0_AGAIN : 
		IN R16,TIFR				
		SBRS R16,TOV0
		RJMP CHECK_TOV0_AGAIN
		LDI R16,0X00
		OUT TCCR0,R16
		LDI R16,0X01
		OUT TIFR,R16
		DEC COUNTER
		BRNE AGAIN
		RET
*/

;TIMER0 USING OCF0 FLAG BIT
/*
.DEF COUNTER=R19
DELAY :
		LDI COUNTER,10
AGAIN :	
		LDI R16,0X00
		OUT TCNT0,R16
		LDI R16,10
		OUT OCR0,R16
		LDI R16,0X01
		OUT TCCR0,R16
CHECK_OCF0_AGAIN : 
		IN R16,TIFR				
		SBRS R16,OCF0
		RJMP CHECK_OCF0_AGAIN
		LDI R16,0X00
		OUT TCCR0,R16
		LDI R16,(1<<OCF0)
		OUT TIFR,R16
		DEC COUNTER
		BRNE AGAIN
		RET
*/