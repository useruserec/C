;CodeVisionAVR C Compiler V1.24.4 Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;e-mail:office@hpinfotech.com

;Chip type           : ATtiny2313
;Clock frequency     : 4,000000 MHz
;Memory model        : Tiny
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : int, width
;External SRAM size  : 0
;Data Stack size     : 32 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU WDTCR=0x21
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SREG=0x3F
	.EQU GPIOR0=0x13
	.EQU GPIOR1=0x14
	.EQU GPIOR2=0x15

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM


	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM


	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM


	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "Prog11.vec"
	.INCLUDE "Prog11.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x80)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0xDF)
	OUT  SPL,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x80)
	LDI  R29,HIGH(0x80)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x80
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.4 Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 e-mail:office@hpinfotech.com
;       8 
;       9 Project : Пример 11
;      10 Version : 1
;      11 Date    : 07.03.2006
;      12 Author  : Belov                           
;      13 Company : Home                            
;      14 Comments: 
;      15 Кодовый замок с музыкальным дверным звонком
;      16 
;      17 
;      18 Chip type           : ATtiny2313
;      19 Clock frequency     : 4,000000 MHz
;      20 Memory model        : Tiny
;      21 External SRAM size  : 0
;      22 Data Stack size     : 32
;      23 *****************************************************/
;      24 
;      25 #include <tiny2313.h>
;      26 #include <delay.h>
;      27 
;      28 #define klfree 0x77F  // Код состояния при полностью отпущеных кнопках
;      29 #define zad 3000      // Код задержки при сканировании
;      30 #define kandr 20      // Константа антидребезга
;      31 #define bsize 30      // Размер буфера для хранения кода
;      32 
;      33 unsigned char flz;   // Флаг задержки
;      34 unsigned int bufr[bsize];   // Буфер в ОЗУ для хранения кода
_bufr:
	.BYTE 0x3C
;      35 unsigned char melod;  // Текущий номер мелодии
;      36 
;      37 //#pragma warn-
;      38 eeprom unsigned char klen = 0xFF;          // Ячейка для хранения длины кода

	.ESEG
_klen:
	.DB  0xFF
;      39 eeprom unsigned int bufe[bsize]={0xFF};   // Буфер в EEPROM для хранения кода
_bufe:
	.DW  0xFF
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;      40 //#pragma warn+
;      41 
;      42 // Таблица задержек
;      43 flash unsigned int tabz[] =  {32,64,128,256,512,1024,2048};

	.CSEG
;      44 
;      45 // Таблица коэффициентов деления
;      46 flash unsigned int tabkd[] = {0,4748,4480,4228,3992,3768,3556,3356,3168,2990,2822,
;      47         2664,2514,2374,2240,2114,1996,1884,1778,1678,1584,1495,1411,1332,1257,
;      48         1187,1120,1057, 998,942,889,839,792};
;      49 // Таблицы мелодий
;      50 // В траве сидел кузнечик
;      51 flash unsigned char mel1[] = {109,104,109,104,109,108,108,96,108,104,108,104,108,
;      52         109,109,96,109,104,109,104,109,108,108,96,108,104,108,104,108,141,96,109,
;      53         111, 79, 79,111,111,112,80,80,112,112,112,111,109,108,109,109, 96,109,111,
;      54         79,79,111,111,112,80,80,112,112,112,111,109,108,141,128,96,255};
;      55 // Песенка крокодила Гены
;      56 flash unsigned char mel2[] = {109,110,141,102,104,105,102,109,110,141,104,105,107, 
;      57         104,109,110,141,104,105,139,109,110,173,96,114,115,146,109,110,112,109, 
;      58         114,115,146,107,109,110,114,112,110,146,109,105,136,107,105,134,128,128,102,
;      59         105,137,136,128,104,107,139,137,128,105,109,141,139,128,110,109,176,112,108,
;      60         109,112,144,142,128,107,110,142,141,128,105,109,139,128,173,134,128,128,109,
;      61        112,144,142,128,107,110,142,141,128,105,109,139,128,173,146,128,255};  
;      62 // В лесу родилась елочка
;      63 flash unsigned char mel3[] = {132,141,141,139,141,137,132,132,132,141,141,142,139,
;      64         176,128,144,146,146,154,154,153,151,149,144,153,153,151,153,181,128,96,255};
;      65 // Happy births day to you
;      66 flash unsigned char mel4[] = {107,107,141,139,144,143,128,107,107,141,139,146,144,
;      67         128,107,107,151,148,146,112,111,149,117,117,148,144,146,144,128,255};
;      68 // С чего начинается родина
;      69 flash unsigned char mel5[] = {99,175,109,107,106,102,99,144,111,175,96,99,107,107,
;      70         107,107,102,104,170,96,99,109,109,109,109,107,106,143,109,141,99,109,109,109,
;      71         109,104,106,171,96,99,111,109,107,106,102,99,144,111,143,104,114,114,114,114,
;      72         109,111,176, 96,104,116,112,109,107,106,64,73,143,107,131,99,144,80,80,112,
;      73         111,64,75,173,128,255};
;      74 // Из кинофильма "Веселые ребята"
;      75 flash unsigned char mel6[] = {105,109,112,149,116,64,80,148,114,64,78,146,112,96,105,
;      76         105,109,144,111,64,80,145,112,64,81,178,96,117,117,117,149,116,64,82,146,112,
;      77         64,79,146,144,96,105,105,107,141,108,109,112,110,102,104,137,128,96,105,105,
;      78         105,137,102,64,73,142,105,107,109,64,75,137,96,105,105,105,137,102,105,142,112,
;      79         64,82,180,96,116,116,116,148,114,112,142,109,64,78,146,144,96,105,105,107,141,
;      80         108,109,112,110,102,104,169,96,96,255};
;      81 // Улыбка
;      82 flash unsigned char mel7[] = {107,104,141,139,102,105,104,102,164,128,104,107,109,109,
;      83         109,111,114,112,111,109,144,139,128,109,111,144, 96,111,109,104,107,105,173,128,
;      84         111,109,112,107,111,109,109,107,102,104,134,132,128,100,103,107,107,107,107,139,
;      85         112,100,103,102,102,102,134,102,103,107,105,107,108,108,108,108,107,105,107,108,
;      86         144,142,128,112,107,110,140,112,105,108,107,107,107,105,140,139,139,112,103,102,
;      87         103,105,108,107,105,103,128,112,107,110,108,108,108,140,112,105,108,107,107,107,
;      88         139,112,103,102,103,105,108,107,105,103,105,139,132,128,96,96,96,255};		 
;      89 // Огонек
;      90 flash unsigned char mel8[] = {102,105,141,107,105,141, 96,107,171,96,104,105,139,104,105,
;      91         166,128,160,109,110,144,110,109,144,96,110,174,128,110,112,146,112,114,205,117,
;      92         117,149,116,114,149,96,116,174,128,110,112,146,112,114,205,128,102,105,141,107,
;      93         105,141,96,107,171,128,104,105,139,104,105,166,128,128,117,117,149,116,114,149,
;      94         96,116,174,128,110,112,146,112,114,205,128,102,105,141,107,105,141,96,107,171,
;      95         128,104,105,139,104,105,166,128,128,96,255};
;      96 
;      97 // Таблица начал всех мелодий
;      98 flash unsigned char *tabm[] = {mel1, mel2, mel3, mel4, mel5, mel6, mel7, mel8};

	.DSEG
_tabm:
	.BYTE 0x10
;      99 
;     100 
;     101 
;     102 
;     103 
;     104 // Прерывание по переполнению Таймера 1
;     105 interrupt [TIM1_OVF] void timer1_ovf_isr(void)
;     106 {

	.CSEG
_timer1_ovf_isr:
	RCALL SUBOPT_0x0
;     107    flz=1;
;     108 }
	RETI
;     109 
;     110 // Прерывание по совпадению в канале A Таймера 1
;     111 interrupt [TIM1_COMPA] void timer1_compa_isr(void)
;     112 {
_timer1_compa_isr:
	RCALL SUBOPT_0x0
;     113    flz=1;
;     114 }
	RETI
;     115 
;     116 // Функция опроса клавиатуры и антидребезга
;     117 unsigned int incod (void)
;     118 {
_incod:
;     119    unsigned int cod0=0;
;     120    unsigned int cod1;
;     121    unsigned char k;
;     122    
;     123    for (k=0; k<kandr; k++)
	RCALL __SAVELOCR5
;	cod0 -> R16,R17
;	cod1 -> R18,R19
;	k -> R20
	LDI  R16,0
	LDI  R17,0
	LDI  R20,LOW(0)
_0x5:
	CPI  R20,20
	BRSH _0x6
;     124      {
;     125        cod1=PINB&0x7;
	IN   R30,0x16
	ANDI R30,LOW(0x7)
	LDI  R31,0
	__PUTW1R 18,19
;     126        cod1=(cod1<<8)+(PIND&0x7F);
	__GETW1R 18,19
	MOV  R31,R30
	LDI  R30,0
	PUSH R31
	PUSH R30
	IN   R30,0x10
	ANDI R30,0x7F
	POP  R26
	POP  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1R 18,19
;     127        if (cod0!=cod1) 
	__CPWRR 18,19,16,17
	BREQ _0x7
;     128        {
;     129           k=0;
	LDI  R20,LOW(0)
;     130           cod0=cod1;
	__MOVEWRR 16,17,18,19
;     131        }
;     132      }
_0x7:
	SUBI R20,-1
	RJMP _0x5
_0x6:
;     133    return cod1;
	__GETW1R 18,19
	RCALL __LOADLOCR5
	ADIW R28,5
	RET
;     134 }
;     135 
;     136 
;     137 // Процедура формирования задержки
;     138 void wait (unsigned char kodz)
;     139 {
_wait:
;     140    if (kodz==1) TIMSK=0x40;     // Выбор маски прерываний по таймеру
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x8
	LDI  R30,LOW(64)
	RJMP _0x33
;     141    else TIMSK=0x80;
_0x8:
	LDI  R30,LOW(128)
_0x33:
	OUT  0x39,R30
;     142    TCNT1=0;                    // Обнуление таймера
	RCALL SUBOPT_0x1
;     143    flz=0;                      // Сброс флага задержки
	CLR  R2
;     144    #asm("sei");                // Разрешаем прерывания
	sei
;     145    if (kodz!=2) while(flz==0); // Цикл задержки
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BREQ _0xA
_0xB:
	TST  R2
	BREQ _0xB
;     146 }
_0xA:
	ADIW R28,1
	RET
;     147 
;     148 // Музыкальная программа
;     149 void muz (void)
;     150 {
_muz:
;     151       unsigned char fnota;    // Код тона ноты
;     152       unsigned char dnota;    // Код длительности ноты
;     153       flash unsigned char *nota;  // Ссылка на текущую ноту
;     154       
;     155       TCCR1B=0x09;                  // Программирование таймера
	RCALL __SAVELOCR4
;	fnota -> R16
;	dnota -> R17
;	*nota -> R18,R19
	LDI  R30,LOW(9)
	OUT  0x2E,R30
;     156       // Воспроизведение мелодии
;     157 m3:   nota = tabm[melod];           // Устанавливаем указатель на первую ноту
_0xE:
	MOV  R30,R3
	LDI  R26,LOW(_tabm)
	RCALL SUBOPT_0x2
	LD   R18,X+
	LD   R19,X
;     158 m4:   if (PINB.6!=0) goto m2;       // Если ни одна кнопка не нажата, закончить
_0xF:
	SBIC 0x16,6
	RJMP _0x11
;     159       if (*nota==0xFF) goto m3;     // Проверка на конец мелодии
	RCALL SUBOPT_0x3
	CPI  R30,LOW(0xFF)
	BREQ _0xE
;     160       fnota = (*nota)&0x1F;         // Определяем код тона
	RCALL SUBOPT_0x3
	ANDI R30,LOW(0x1F)
	MOV  R16,R30
;     161       dnota = ((*nota)>>5)&0x07;    // Определяем код длительности
	RCALL SUBOPT_0x3
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	ANDI R30,LOW(0x7)
	MOV  R17,R30
;     162       if (fnota==0) goto m5;        // Если пауза не воспроизводим звук
	CPI  R16,0
	BREQ _0x14
;     163       OCR1A=tabkd[fnota];           // Программируем частоту звука
	LDI  R26,LOW(_tabkd*2)
	LDI  R27,HIGH(_tabkd*2)
	MOV  R30,R16
	RCALL SUBOPT_0x4
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;     164       TCCR1A=0x40;                  // Включаем звук
	LDI  R30,LOW(64)
	OUT  0x2F,R30
;     165 m5:   delay_ms (tabz[dnota]);       // Формируем задержку
_0x14:
	LDI  R26,LOW(_tabz*2)
	LDI  R27,HIGH(_tabz*2)
	MOV  R30,R17
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
;     166       TCCR1A=0x00;                  // Выключаем звук
	RCALL SUBOPT_0x6
;     167       delay_ms (tabz[0]);           // Задержка между нотами
	LDI  R30,LOW(_tabz*2)
	LDI  R31,HIGH(_tabz*2)
	RCALL __GETW1PF
	RCALL SUBOPT_0x5
;     168       nota++;                       // Перемещаем указатель на следующую ноту
	__ADDWRN 18,19,1
;     169       goto m4;                      // К началу цикла
	RJMP _0xF
;     170 m2:   TCCR1A=0x00;                  // Выключаем звук
_0x11:
	RCALL SUBOPT_0x6
;     171       if (++melod>=8) melod=0;       // Увеличиваем счетчик мелодий
	INC  R3
	LDI  R30,LOW(8)
	CP   R3,R30
	BRLO _0x15
	CLR  R3
;     172 }
_0x15:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
;     173 
;     174 
;     175 // Основная функция
;     176 void main(void)
;     177 {
_main:
;     178 unsigned char ii;  // Указатель массива
;     179 unsigned char i;   // Вспомогательный указатель
;     180 unsigned int codS; // Старый код
;     181 
;     182 PORTB=0xE7;  // Порт B
;	ii -> R16
;	i -> R17
;	codS -> R18,R19
	LDI  R30,LOW(231)
	OUT  0x18,R30
;     183 DDRB=0x18;
	LDI  R30,LOW(24)
	OUT  0x17,R30
;     184 PORTD=0x7F;  // Порт D
	LDI  R30,LOW(127)
	OUT  0x12,R30
;     185 DDRD=0x00;
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     186 TCCR1A=0x00;  // Таймер/Счетчик 1
	RCALL SUBOPT_0x6
;     187 TCNT1=0;
	RCALL SUBOPT_0x1
;     188 OCR1A=zad;
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;     189 ACSR=0x80;    // Аналоговый компаратор
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     190 melod=0;      // Сбрасываем счетчик мелодий
	CLR  R3
;     191 
;     192 while (1)
_0x16:
;     193       {
;     194 m1:     while (incod() != klfree); // Ожидание отпускания кнопок
_0x19:
_0x1A:
	RCALL SUBOPT_0x7
	BRNE _0x1A
;     195         while (incod() == klfree)  // Ожидание нажатия кнопок
_0x1D:
	RCALL SUBOPT_0x7
	BRNE _0x1F
;     196            if (PINB.6==0) muz();   // К музыкальному звонку
	SBIS 0x16,6
	RCALL _muz
;     197         TCCR1B=0x03;               // Настройка таймера
	RJMP _0x1D
_0x1F:
	LDI  R30,LOW(3)
	OUT  0x2E,R30
;     198         ii=0;                      // Сброс счетчика байтов
	LDI  R16,LOW(0)
;     199 m2:     #asm("cli");               // Запрещаем прерывания
_0x21:
	cli
;     200         wait(1);                   // Задержка 1-го типа
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x8
;     201         codS=incod();              // Ввод кода и запись, как старого
	RCALL _incod
	__PUTW1R 18,19
;     202         bufr[ii++]=codS;           // Запись очередного кода в буфер
	MOV  R30,R16
	SUBI R16,-1
	LDI  R26,LOW(_bufr)
	LSL  R30
	ADD  R26,R30
	ST   X+,R18
	ST   X,R19
;     203         if (ii>=bsize) goto m4;    // Проверка конца буфера
	CPI  R16,30
	BRSH _0x23
;     204         
;     205         wait(2);                        // Задержка 2-го типа
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x8
;     206 m3:     if (incod() != codS) goto m2;   // Проверка не изменилось ли состояние
_0x24:
	RCALL _incod
	CP   R18,R30
	CPC  R19,R31
	BRNE _0x21
;     207         if (flz==0) goto m3;         // Проверка окончания контрольного промежутка времени
	TST  R2
	BREQ _0x24
;     208         
;     209 m4:     if (PINB.7==1) goto comp;       // Проверка переключателя режимов
_0x23:
	SBIC 0x16,7
	RJMP _0x28
;     210 
;     211 //------------------------------ Запись кода в EEPROM
;     212         klen=ii;                                // Запись длины кода
	MOV  R30,R16
	LDI  R26,LOW(_klen)
	LDI  R27,HIGH(_klen)
	RCALL __EEPROMWRB
;     213         for (i=0; i<ii; i++)  bufe[i]=bufr[i];  // Запись всех байтов кода
	LDI  R17,LOW(0)
_0x2A:
	CP   R17,R16
	BRSH _0x2B
	RCALL SUBOPT_0x9
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0xA
	RCALL __GETW1P
	POP  R26
	POP  R27
	RCALL __EEPROMWRW
;     214         goto zamok;
	SUBI R17,-1
	RJMP _0x2A
_0x2B:
	RJMP _0x2C
;     215 
;     216 //------------------------------ Проверка кода
;     217 comp:   if (klen!=ii) goto m1;              // Проверка длины кода
_0x28:
	LDI  R26,LOW(_klen)
	LDI  R27,HIGH(_klen)
	RCALL __EEPROMRDB
	CP   R16,R30
	BRNE _0x19
;     218         for (i=0; i<ii; i++)  if (bufe[i]!=bufr[i]) goto m1;  // Проверка самого кода
	LDI  R17,LOW(0)
_0x2F:
	CP   R17,R16
	BRSH _0x30
	RCALL SUBOPT_0x9
	ADD  R26,R30
	ADC  R27,R31
	RCALL __EEPROMRDW
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0xA
	RCALL __GETW1P
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x31
	RJMP _0x19
;     219 
;     220 
;     221 //------------------------------ Открывание замка
;     222 zamok:  PORTB.4=1;        // Открываем замок
_0x31:
	SUBI R17,-1
	RJMP _0x2F
_0x30:
_0x2C:
	SBI  0x18,4
;     223         wait(3);          // Задержка 3-го типа
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x8
;     224         PORTB.4=0;        // Закрываем замок
	CBI  0x18,4
;     225       };
	RJMP _0x16
;     226 }
_0x32:
	RJMP _0x32


;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x0:
	ST   -Y,R30
	LDI  R30,LOW(1)
	MOV  R2,R30
	LD   R30,Y+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x2:
	LSL  R30
	ADD  R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3:
	__GETW1R 18,19
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RCALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x6:
	LDI  R30,LOW(0)
	OUT  0x2F,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	RCALL _incod
	CPI  R30,LOW(0x77F)
	LDI  R26,HIGH(0x77F)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x8:
	ST   -Y,R30
	RJMP _wait

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x9:
	MOV  R30,R17
	LDI  R26,LOW(_bufe)
	LDI  R27,HIGH(_bufe)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA:
	MOV  R30,R17
	LDI  R26,LOW(_bufr)
	RJMP SUBOPT_0x2

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x3E8
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__GETW1P:
	LD   R30,X+
	LD   R31,X
	DEC  R26
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIC EECR,EEWE
	RJMP __EEPROMWRB
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
