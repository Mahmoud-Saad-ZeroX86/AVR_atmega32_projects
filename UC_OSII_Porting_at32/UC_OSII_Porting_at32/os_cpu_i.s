/*
 * os_cpu_i.s
 *
 * Created: 02/11/2018 12:55:41
 *  Author: Mahmoud
 */ 
;********************************************************************************************************
;                                               uC/OS-II
;                                         The Real-Time Kernel
;
;                                       ATmega128  Specific code
;
;                                             INCLUDE FILE
;
; File     : OS_CPU_I.S90
; By       : Jean J. Labrosse
;********************************************************************************************************
;
;********************************************************************************************************
;                                            BIT DEFINITIONS
;********************************************************************************************************

BIT00   = 0x01
BIT01   = 0x02
BIT02   = 0x04
BIT03   = 0x08
BIT04   = 0x10
BIT05   = 0x20
BIT06   = 0x40
BIT07   = 0x80

;********************************************************************************************************
;                                           I/O PORT ADDRESSES
;********************************************************************************************************

SREG    = 0x3F
SPH     = 0x3E
SPL     = 0x3D
;RAMPZ   = 0x3B		//no RAMPZ in at32	//chk_later MSA_ZEROX86

;********************************************************************************************************
;                                                MACROS
;********************************************************************************************************

PUSH_ALL        MACRO                               ; Save all registers
                ST      -Y,R0
                ST      -Y,R1
                ST      -Y,R2
                ST      -Y,R3
                ST      -Y,R4
                ST      -Y,R5
                ST      -Y,R6
                ST      -Y,R7
                ST      -Y,R8
                ST      -Y,R9
                ST      -Y,R10
                ST      -Y,R11
                ST      -Y,R12
                ST      -Y,R13
                ST      -Y,R14
                ST      -Y,R15
                ST      -Y,R16
                ST      -Y,R17
                ST      -Y,R18
                ST      -Y,R19
                ST      -Y,R20
                ST      -Y,R21
                ST      -Y,R22
                ST      -Y,R23
                ST      -Y,R24
                ST      -Y,R25
                ST      -Y,R26
                ST      -Y,R27
                ST      -Y,R30
                ST      -Y,R31
                ;IN      R16,RAMPZ	//no RAMPZ in at32	//chk_later MSA_ZEROX86
                ;ST      -Y,R16		//no RAMPZ in at32	//chk_later MSA_ZEROX86
                ENDM

POP_ALL         MACRO                               ; Restore all registers
                ;LD      R16,Y+		//no RAMPZ in at32	//chk_later MSA_ZEROX86
                ;OUT     RAMPZ,R16	//no RAMPZ in at32	//chk_later MSA_ZEROX86
                LD      R31,Y+
                LD      R30,Y+
                LD      R27,Y+
                LD      R26,Y+
                LD      R25,Y+
                LD      R24,Y+
                LD      R23,Y+
                LD      R22,Y+
                LD      R21,Y+
                LD      R20,Y+
                LD      R19,Y+
                LD      R18,Y+
                LD      R17,Y+
                LD      R16,Y+
                LD      R15,Y+
                LD      R14,Y+
                LD      R13,Y+
                LD      R12,Y+
                LD      R11,Y+
                LD      R10,Y+
                LD      R9,Y+
                LD      R8,Y+
                LD      R7,Y+
                LD      R6,Y+
                LD      R5,Y+
                LD      R4,Y+
                LD      R3,Y+
                LD      R2,Y+
                LD      R1,Y+
                LD      R0,Y+
                ENDM

PUSH_SP         MACRO                               ; Save stack pointer
                IN      R16,SPH
                ST      -Y,R16
                IN      R16,SPL
                ST      -Y,R16
                ENDM

POP_SP          MACRO                               ; Restore stack pointer
                LD      R16,Y+
                OUT     SPL,R16
                LD      R16,Y+
                OUT     SPH,R16
                ENDM

PUSH_SREG       MACRO                               ; Save status register
                IN      R16,SREG
                ST      -Y,R16
                ENDM

POP_SREG        MACRO                               ; Restore status registers
                LD      R16,Y+
                OUT     SREG,R16
                ENDM

PUSH_SREG_INT   MACRO                               ; Save status register with interrupts ENABLED
                IN      R16,SREG
                SBR     R16,BIT07
                ST      -Y,R16
                ENDM

POP_SREG_INT    MACRO                               ; Restore status registers but DISABLE interrupts
                LD      R16,Y+
                CBR     R16,BIT07
                OUT     SREG,R16
                ENDM
