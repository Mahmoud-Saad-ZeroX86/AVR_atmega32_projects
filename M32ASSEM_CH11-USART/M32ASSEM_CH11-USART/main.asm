;
; M32ASSEM_CH11-USART.asm
;
; Created: 21/04/2018 12:48:52
; Author : Mahmoud Saad Zerox
;


// USART RECEIVING TRANSMITING,ASYNCH,NO PARITY AND ONE STOP BIT AT 9600 BR
/*
.INCLUDE "M32DEF.INC"
.ORG 0X00

LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

.DEF B2A_A2B=R19	;USED TO CONVERT BINARY DATA TO ASCII
LDI B2A_A2B,48
MAIN :
			LDI R16,(1<<RXEN)|(1<<TXEN)
			OUT UCSRB,R16
			LDI R16,(1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1)
			OUT UCSRC,R16
			LDI R16,0X33
			OUT UBRRL,R16
			
			LDI R16,0X00
			OUT DDRB,R16
			COM R16
			OUT DDRA,R16

			LDI R17,'H'
			CALL SEND_DATA
			LDI R17,'E'
			CALL SEND_DATA
			LDI R17,'L'
			CALL SEND_DATA
			LDI R17,'L'
			CALL SEND_DATA
			LDI R17,'O'
			CALL SEND_DATA
			LDI R17,' '
			CALL SEND_DATA
	WHILE_ONE :
			SBIS UCSRA,RXC
			RJMP DNT_RECVE
			IN R16,UDR
			SUB R16,B2A_A2B
			OUT PORTA,R16
	DNT_RECVE :
			SBIS UCSRA,UDRE
			RJMP DNT_SEND
			IN R16,PINB
			;ADD R16,B2A_A2B
			OUT UDR,R16
	DNT_SEND :
			RJMP WHILE_ONE
			

RJMP MAIN

SEND_DATA :
			SBIS UCSRA,UDRE
			RJMP SEND_DATA
			OUT UDR,R17
RET
*/
//USART RECEIVING,ASYNCHRONOUS NO PARITY AND ONE STOP BIT AT 9600 BAUDRATE
/*
.INCLUDE "M32DEF.INC"
.ORG 0X00

LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

MAIN :
			LDI R16,0XFF
			OUT DDRA,R16
			LDI R16,(1<<RXEN)
			OUT UCSRB,R16
			LDI R16,(1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1)
			OUT UCSRC,R16
			LDI R16,0X33
			OUT UBRRL,R16
		LOOP :
			SBIS UCSRA,RXC
			RJMP LOOP
			IN R16,UDR
			SUBI R16,48
			OUT PORTA,R16 
			RJMP LOOP
RJMP MAIN
*/

//USART TRANSMITTING,ASYNCHRONOUS NO PARITY AND ONE STOP BIT AT 9600 BAUDRATE
/*
.INCLUDE "M32DEF.INC"
.ORG 0X00

LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

LDI R16,(1<<TXEN)
OUT UCSRB,R16
LDI R16,(1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0) 
LDI R16,0X33
OUT UBRRL,R16
MAIN :
LDI R17,'Y'
CALL TRANSMIT
LDI R17,'E'
CALL TRANSMIT
LDI R17,'S'
CALL TRANSMIT
LDI R17,' '
CALL TRANSMIT
RJMP MAIN

TRANSMIT :
SBIS UCSRA,UDRE
RJMP TRANSMIT
OUT UDR,R17
RET
*/