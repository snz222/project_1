
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATxmega256A3B
;Program type           : Application
;Clock frequency        : 32.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : float, width, precision
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 4096 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATxmega256A3B
	#pragma AVRPART MEMORY PROG_FLASH 270336
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 16384
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x2000

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU CCP=0x34
	.EQU RAMPD=0x38
	.EQU RAMPX=0x39
	.EQU RAMPY=0x3A
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU WDT_CTRL=0x80
	.EQU PMIC_CTRL=0xA2
	.EQU NVM_ADDR0=0X01C0
	.EQU NVM_ADDR1=NVM_ADDR0+1
	.EQU NVM_ADDR2=NVM_ADDR1+1
	.EQU NVM_DATA0=NVM_ADDR0+4
	.EQU NVM_CMD=NVM_ADDR0+0xA
	.EQU NVM_CTRLA=NVM_ADDR0+0xB
	.EQU NVM_CTRLB=NVM_ADDR0+0xC
	.EQU NVM_STATUS=NVM_ADDR0+0xF
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIO0=0x00
	.EQU GPIO1=0x01
	.EQU GPIO2=0x02
	.EQU GPIO3=0x03
	.EQU GPIO4=0x04
	.EQU GPIO5=0x05
	.EQU GPIO6=0x06
	.EQU GPIO7=0x07
	.EQU GPIO8=0x08
	.EQU GPIO9=0x09
	.EQU GPIO10=0x0A
	.EQU GPIO11=0x0B
	.EQU GPIO12=0x0C
	.EQU GPIO13=0x0D
	.EQU GPIO14=0x0E
	.EQU GPIO15=0x0F

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

	.EQU __SRAM_START=0x2000
	.EQU __SRAM_END=0x5FFF
	.EQU __DSTACK_SIZE=0x1000
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

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

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
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

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
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

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
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

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
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

	.MACRO __PUTBSR
	STD  Y+@1,R@0
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
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
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
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
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

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
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
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
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

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
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

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _izm=R3
	.DEF _T_analog=R4
	.DEF _T_analog_msb=R5
	.DEF _Tempf_K=R6
	.DEF _Tempf_K_msb=R7
	.DEF _CLBR=R2
	.DEF _KALC_PULS=R8
	.DEF _KALC_PULS_msb=R9
	.DEF _RX_BUFFER_SIZE_USARTC0=R11
	.DEF _rx_wr_index_usartc0=R10
	.DEF _rx_rd_index_usartc0=R13
	.DEF _rx_counter_usartc0=R12

;GPIO0-GPIO15 INITIALIZATION VALUES
	.EQU __GPIO0_INIT=0x00
	.EQU __GPIO1_INIT=0x00
	.EQU __GPIO2_INIT=0x00
	.EQU __GPIO3_INIT=0x00
	.EQU __GPIO4_INIT=0x00
	.EQU __GPIO5_INIT=0x00
	.EQU __GPIO6_INIT=0x00
	.EQU __GPIO7_INIT=0x00
	.EQU __GPIO8_INIT=0x00
	.EQU __GPIO9_INIT=0x00
	.EQU __GPIO10_INIT=0x00
	.EQU __GPIO11_INIT=0x00
	.EQU __GPIO12_INIT=0x00
	.EQU __GPIO13_INIT=0x00
	.EQU __GPIO14_INIT=0x00
	.EQU __GPIO15_INIT=0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION VALUES
	.EQU __R2_INIT=0x00
	.EQU __R3_INIT=0x00
	.EQU __R4_INIT=0x00
	.EQU __R5_INIT=0x00
	.EQU __R6_INIT=0x00
	.EQU __R7_INIT=0x00
	.EQU __R8_INIT=0x00
	.EQU __R9_INIT=0x00
	.EQU __R10_INIT=0x00
	.EQU __R11_INIT=0x01
	.EQU __R12_INIT=0x00
	.EQU __R13_INIT=0x00
	.EQU __R14_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _tcc0_overflow_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _tcc1_overflow_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usartc0_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _twie_master_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _tcd0_overflow_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _tcf0_overflow_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_error_msg:
	.DB  LOW(_0x0*2),HIGH(_0x0*2),LOW(_0x0*2+1),HIGH(_0x0*2+1),LOW(_0x0*2+13),HIGH(_0x0*2+13),LOW(_0x0*2+13),HIGH(_0x0*2+13)
	.DB  LOW(_0x0*2+24),HIGH(_0x0*2+24),LOW(_0x0*2+37),HIGH(_0x0*2+37),LOW(_0x0*2+48),HIGH(_0x0*2+48),LOW(_0x0*2+59),HIGH(_0x0*2+59)
	.DB  LOW(_0x0*2+75),HIGH(_0x0*2+75),LOW(_0x0*2+85),HIGH(_0x0*2+85),LOW(_0x0*2+94),HIGH(_0x0*2+94),LOW(_0x0*2+112),HIGH(_0x0*2+112)
	.DB  LOW(_0x0*2+131),HIGH(_0x0*2+131),LOW(_0x0*2+148),HIGH(_0x0*2+148),LOW(_0x0*2+163),HIGH(_0x0*2+163),LOW(_0x0*2+180),HIGH(_0x0*2+180)
	.DB  LOW(_0x0*2+196),HIGH(_0x0*2+196)
_k1:
	.DB  0x20,0x22,0x2A,0x2B,0x2C,0x5B,0x3D,0x5D
	.DB  0x7C,0x7F,0x0
_vst_G101:
	.DB  0x0,0x4,0x0,0x2,0x0,0x1,0x80,0x0
	.DB  0x40,0x0,0x20,0x0,0x10,0x0,0x8,0x0
	.DB  0x4,0x0,0x2,0x0,0x0,0x0
_cst_G101:
	.DB  0x0,0x80,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x4,0x0,0x2

_0x1B:
	.DB  0xFF
_0x69:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x1,0x0,0x0,0x0
	.DB  0x1,0x0,0x0,0x0,0xB2,0x7,0x0,0x0
	.DB  0x80,0xDE,0x28,0x0,0x80,0x33,0xE1,0x1
	.DB  0x0,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1C,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1E,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1E,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0,0x1E,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0,0x1E,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0
_0x88:
	.DB  0x0,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1C,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1E,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1E,0x0,0x0,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0,0x1E,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0,0x1E,0x0,0x0,0x0
	.DB  0x1F,0x0,0x0,0x0
_0x18B:
	.DB  0x30,0x3A,0x2F,0x74,0x65,0x73,0x74,0x2E
	.DB  0x74,0x78,0x74
_0x18C:
	.DB  0x1
_0x193:
	.DB  0x3
_0x196:
	.DB  0x1
_0x0:
	.DB  0x0,0x46,0x52,0x5F,0x44,0x49,0x53,0x4B
	.DB  0x5F,0x45,0x52,0x52,0x0,0x46,0x52,0x5F
	.DB  0x49,0x4E,0x54,0x5F,0x45,0x52,0x52,0x0
	.DB  0x46,0x52,0x5F,0x4E,0x4F,0x54,0x5F,0x52
	.DB  0x45,0x41,0x44,0x59,0x0,0x46,0x52,0x5F
	.DB  0x4E,0x4F,0x5F,0x46,0x49,0x4C,0x45,0x0
	.DB  0x46,0x52,0x5F,0x4E,0x4F,0x5F,0x50,0x41
	.DB  0x54,0x48,0x0,0x46,0x52,0x5F,0x49,0x4E
	.DB  0x56,0x41,0x4C,0x49,0x44,0x5F,0x4E,0x41
	.DB  0x4D,0x45,0x0,0x46,0x52,0x5F,0x44,0x45
	.DB  0x4E,0x49,0x45,0x44,0x0,0x46,0x52,0x5F
	.DB  0x45,0x58,0x49,0x53,0x54,0x0,0x46,0x52
	.DB  0x5F,0x49,0x4E,0x56,0x41,0x4C,0x49,0x44
	.DB  0x5F,0x4F,0x42,0x4A,0x45,0x43,0x54,0x0
	.DB  0x46,0x52,0x5F,0x57,0x52,0x49,0x54,0x45
	.DB  0x5F,0x50,0x52,0x4F,0x54,0x45,0x43,0x54
	.DB  0x45,0x44,0x0,0x46,0x52,0x5F,0x49,0x4E
	.DB  0x56,0x41,0x4C,0x49,0x44,0x5F,0x44,0x52
	.DB  0x49,0x56,0x45,0x0,0x46,0x52,0x5F,0x4E
	.DB  0x4F,0x54,0x5F,0x45,0x4E,0x41,0x42,0x4C
	.DB  0x45,0x44,0x0,0x46,0x52,0x5F,0x4E,0x4F
	.DB  0x5F,0x46,0x49,0x4C,0x45,0x53,0x59,0x53
	.DB  0x54,0x45,0x4D,0x0,0x46,0x52,0x5F,0x4D
	.DB  0x4B,0x46,0x53,0x5F,0x41,0x42,0x4F,0x52
	.DB  0x54,0x45,0x44,0x0,0x46,0x52,0x5F,0x54
	.DB  0x49,0x4D,0x45,0x4F,0x55,0x54,0x0,0x45
	.DB  0x52,0x52,0x4F,0x52,0x3A,0x20,0x25,0x70
	.DB  0xD,0xA,0x0,0x30,0x3A,0x2F,0x25,0x6C
	.DB  0x64,0x2E,0x62,0x69,0x6E,0x0,0x25,0x36
	.DB  0x6C,0x64,0x0,0x4C,0x6F,0x67,0x69,0x63
	.DB  0x61,0x6C,0x20,0x64,0x72,0x69,0x76,0x65
	.DB  0x20,0x30,0x3A,0x20,0x6D,0x6F,0x75,0x6E
	.DB  0x74,0x65,0x64,0x20,0x4F,0x4B,0xD,0xA
	.DB  0x0,0x46,0x69,0x6C,0x65,0x20,0x25,0x73
	.DB  0x20,0x63,0x72,0x65,0x61,0x74,0x65,0x64
	.DB  0x20,0x4F,0x4B,0xD,0xA,0x0,0x74,0x68
	.DB  0x69,0x73,0x20,0x69,0x73,0x20,0x74,0x65
	.DB  0x73,0x74,0x0,0x25,0x75,0x20,0x62,0x79
	.DB  0x74,0x65,0x73,0x20,0x77,0x72,0x69,0x74
	.DB  0x74,0x65,0x6E,0x20,0x6F,0x66,0x20,0x25
	.DB  0x75,0xD,0xA,0x0,0x66,0x69,0x6C,0x65
	.DB  0x20,0x73,0x64,0x20,0x63,0x61,0x72,0x64
	.DB  0x0,0x46,0x69,0x6C,0x65,0x20,0x25,0x73
	.DB  0x20,0x63,0x6C,0x6F,0x73,0x65,0x64,0x20
	.DB  0x4F,0x4B,0xD,0xA,0x0,0x46,0x69,0x6C
	.DB  0x65,0x20,0x65,0x73,0x74,0x20,0x79,0x7A
	.DB  0x65,0x0,0x73,0x74,0x61,0x72,0x74,0x20
	.DB  0x69,0x32,0x63,0x0,0x62,0x75,0x66,0x20
	.DB  0x69,0x32,0x63,0x20,0x73,0x74,0x61,0x72
	.DB  0x74,0x20,0x6F,0x6B,0x0,0x62,0x6D,0x70
	.DB  0x20,0x69,0x32,0x63,0x20,0x73,0x74,0x61
	.DB  0x72,0x74,0x20,0x6F,0x6B,0x0,0x53,0x50
	.DB  0x49,0x20,0x53,0x54,0x41,0x52,0x54,0x0
	.DB  0x61,0x64,0x37,0x37,0x30,0x35,0x20,0x73
	.DB  0x74,0x61,0x72,0x74,0x20,0x6F,0x6B,0x0
	.DB  0x73,0x74,0x61,0x72,0x74,0x20,0x64,0x65
	.DB  0x76,0x69,0x63,0x65,0x0,0x53,0x54,0x41
	.DB  0x52,0x54,0x20,0x57,0x48,0x49,0x4C,0x45
	.DB  0x0
_0x2000003:
	.DB  0x1
_0x2020000:
	.DB  0xEB,0xFE,0x90,0x4D,0x53,0x44,0x4F,0x53
	.DB  0x35,0x2E,0x30,0x0,0x4E,0x4F,0x20,0x4E
	.DB  0x41,0x4D,0x45,0x20,0x20,0x20,0x20,0x46
	.DB  0x41,0x54,0x33,0x32,0x20,0x20,0x20,0x0
	.DB  0x4E,0x4F,0x20,0x4E,0x41,0x4D,0x45,0x20
	.DB  0x20,0x20,0x20,0x46,0x41,0x54,0x20,0x20
	.DB  0x20,0x20,0x20,0x0
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x2080060:
	.DB  0x1
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _Mx
	.DW  _0x1B*2

	.DW  0x0B
	.DW  _path
	.DW  _0x18B*2

	.DW  0x01
	.DW  _SD_IN
	.DW  _0x18C*2

	.DW  0x01
	.DW  _oss
	.DW  _0x193*2

	.DW  0x01
	.DW  _chan
	.DW  _0x196*2

	.DW  0x01
	.DW  _status_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G104
	.DW  _0x2080060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30

;MEMORY MAPPED EEPROM ACCESS IS USED
	LDS  R31,NVM_CTRLB
	ORI  R31,0x08
	STS  NVM_CTRLB,R31

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,0xD8
	OUT  CCP,R31
	STS  PMIC_CTRL,R30

;DISABLE WATCHDOG
	LDS  R26,WDT_CTRL
	CBR  R26,2
	SBR  R26,1
	OUT  CCP,R31
	STS  WDT_CTRL,R26

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
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

	OUT  RAMPZ,R24

	OUT  EIND,R24

;GPIO0-GPIO15 INITIALIZATION
	LDI  R30,__GPIO0_INIT
	OUT  GPIO0,R30
	;__GPIO1_INIT = __GPIO0_INIT
	OUT  GPIO1,R30
	;__GPIO2_INIT = __GPIO0_INIT
	OUT  GPIO2,R30
	;__GPIO3_INIT = __GPIO0_INIT
	OUT  GPIO3,R30
	;__GPIO4_INIT = __GPIO0_INIT
	OUT  GPIO4,R30
	;__GPIO5_INIT = __GPIO0_INIT
	OUT  GPIO5,R30
	;__GPIO6_INIT = __GPIO0_INIT
	OUT  GPIO6,R30
	;__GPIO7_INIT = __GPIO0_INIT
	OUT  GPIO7,R30
	;__GPIO8_INIT = __GPIO0_INIT
	OUT  GPIO8,R30
	;__GPIO9_INIT = __GPIO0_INIT
	OUT  GPIO9,R30
	;__GPIO10_INIT = __GPIO0_INIT
	OUT  GPIO10,R30
	;__GPIO11_INIT = __GPIO0_INIT
	OUT  GPIO11,R30
	;__GPIO12_INIT = __GPIO0_INIT
	OUT  GPIO12,R30
	;__GPIO13_INIT = __GPIO0_INIT
	OUT  GPIO13,R30
	;__GPIO14_INIT = __GPIO0_INIT
	OUT  GPIO14,R30
	;__GPIO15_INIT = __GPIO0_INIT
	OUT  GPIO15,R30

;GLOBAL REGISTER VARIABLES INITIALIZATION
	;__R3_INIT = __GPIO0_INIT
	MOV  R3,R30
	;__R4_INIT = __GPIO0_INIT
	MOV  R4,R30
	;__R5_INIT = __GPIO0_INIT
	MOV  R5,R30
	;__R6_INIT = __GPIO0_INIT
	MOV  R6,R30
	;__R7_INIT = __GPIO0_INIT
	MOV  R7,R30
	;__R8_INIT = __GPIO0_INIT
	MOV  R8,R30
	;__R9_INIT = __GPIO0_INIT
	MOV  R9,R30
	;__R10_INIT = __GPIO0_INIT
	MOV  R10,R30
	LDI  R30,__R11_INIT
	MOV  R11,R30
	LDI  R30,__R12_INIT
	MOV  R12,R30
	;__R13_INIT = __R12_INIT
	MOV  R13,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 1

	.DSEG
	.ORG 0x3000

	.CSEG
;/*****************************************************
;Chip type               : ATxmega256A3B
;Program type            : Application
;AVR Core Clock frequency: 32,000000 MHz
;Memory model            : Small
;Data Stack size         : 4096
;*****************************************************/
;// I/O Registers definitions
;#include <io.h>
;#include <delay.h>
;#include <stdio.h>
;#include <string.h>
;#include <stdlib.h>
;#include <twix.h>
;#include "ADC_vn.c"
;// Function used to read the calibration byte from the
;// signature row, specified by 'index'
;#pragma optsize-
;unsigned char read_calibration_byte(unsigned char index)
; 0000 000F {

	.CSEG
_read_calibration_byte:
; .FSTART _read_calibration_byte
;unsigned char r;
;NVM.CMD=NVM_CMD_READ_CALIB_ROW_gc;
	ST   -Y,R26
	ST   -Y,R17
;	index -> Y+1
;	r -> R17
	LDI  R30,LOW(2)
	STS  458,R30
;r=*((flash unsigned char*) index);
	LDD  R30,Y+1
	LDI  R31,0
	LPM  R17,Z
;// Clean up NVM command register
;NVM.CMD=NVM_CMD_NO_OPERATION_gc;
	LDI  R30,LOW(0)
	STS  458,R30
;return r;
	MOV  R30,R17
	LDD  R17,Y+0
	RJMP _0x210002C
;}
; .FEND
;#pragma optsize_default
;
;// ADCA initialization
;void adca_init(void)
;{
_adca_init:
; .FSTART _adca_init
;// ADCA is enabled
;// Resolution: 12 Bits
;// Load the calibration value for 12 Bit resolution
;// from the signature row
;ADCA.CALL=read_calibration_byte(PROD_SIGNATURES_START+ADCACAL0_offset);
	LDI  R26,LOW(32)
	RCALL _read_calibration_byte
	STS  524,R30
;ADCA.CALH=read_calibration_byte(PROD_SIGNATURES_START+ADCACAL1_offset);
	LDI  R26,LOW(33)
	RCALL _read_calibration_byte
	STS  525,R30
;
;// Free Running mode: Off
;// Conversion mode: Unsigned
;ADCA.CTRLB=(0<<ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc;
	LDI  R30,LOW(0)
	STS  513,R30
;
;// Clock frequency: 1000,000 kHz
;ADCA.PRESCALER=ADC_PRESCALER_DIV32_gc;
	LDI  R30,LOW(3)
	STS  516,R30
;
;// Reference: Internal Vcc/1.6
;// Temperature reference: On
;ADCA.REFCTRL=ADC_REFSEL_VCC_gc | (1<<ADC_TEMPREF_bp) | (0<<ADC_BANDGAP_bp);
	LDI  R30,LOW(17)
	STS  514,R30
;
;// Initialize the ADC Compare register
;ADCA.CMPL=0x00;
	LDI  R30,LOW(0)
	STS  536,R30
;ADCA.CMPH=0x00;
	STS  537,R30
;
;// ADC channel 0 gain: 1
;// ADC channel 0 input mode: Single-ended positive input signal
;ADCA.CH0.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  544,R30
;
;// ADC channel 0 positive input: ADC4 pin
;// ADC channel 0 negative input: GND
;ADCA.CH0.MUXCTRL=ADC_CH_MUXPOS_PIN4_gc;
	LDI  R30,LOW(32)
	STS  545,R30
;
;// ADC channel 1 gain: 1
;// ADC channel 1 input mode: Single-ended positive input signal
;ADCA.CH1.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  552,R30
;
;// ADC channel 1 positive input: ADC5 pin
;// ADC channel 1 negative input: GND
;ADCA.CH1.MUXCTRL=ADC_CH_MUXPOS_PIN5_gc;
	LDI  R30,LOW(40)
	STS  553,R30
;
;// ADC channel 2 gain: 1
;// ADC channel 2 input mode: Single-ended positive input signal
;ADCA.CH2.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  560,R30
;
;// ADC channel 2 positive input: ADC6 pin
;// ADC channel 2 negative input: GND
;ADCA.CH2.MUXCTRL=ADC_CH_MUXPOS_PIN6_gc;
	LDI  R30,LOW(48)
	STS  561,R30
;
;// ADC channel 3 gain: 1
;// ADC channel 3 input mode: Single-ended positive input signal
;ADCA.CH3.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  568,R30
;
;// ADC channel 3 positive input: ADC7 pin
;// ADC channel 3 negative input: GND
;ADCA.CH3.MUXCTRL=ADC_CH_MUXPOS_PIN7_gc;
	LDI  R30,LOW(56)
	STS  569,R30
;
;// AD conversion is started by software
;ADCA.EVCTRL=ADC_EVACT_NONE_gc;
	LDI  R30,LOW(0)
	STS  515,R30
;
;// Channel 0 interrupt: Disabled
;ADCA.CH0.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  546,R30
;// Channel 1 interrupt: Disabled
;ADCA.CH1.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  554,R30
;// Channel 2 interrupt: Disabled
;ADCA.CH2.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  562,R30
;// Channel 3 interrupt: Disabled
;ADCA.CH3.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  570,R30
;
;// Enable the ADC
;ADCA.CTRLA|=ADC_ENABLE_bm;
	LDS  R30,512
	ORI  R30,1
	STS  512,R30
;// Insert a delay to allow the ADC common mode voltage to stabilize
;delay_us(2);
	RJMP _0x210002E
;}
; .FEND
;
;// ADCA channel data read function using polled mode
;unsigned int adca_read(unsigned char channel)
;{
_adca_read:
; .FSTART _adca_read
;ADC_CH_t *pch=&ADCA.CH0+channel;
;unsigned int data;
;
;// Start the AD conversion
;pch->CTRL|= 1<<ADC_CH_START_bp;
	ST   -Y,R26
	CALL __SAVELOCR4
;	channel -> Y+4
;	*pch -> R16,R17
;	data -> R18,R19
	LDD  R30,Y+4
	LDI  R31,0
	LDI  R26,LOW(544)
	LDI  R27,HIGH(544)
	CALL SUBOPT_0x0
;// Wait for the AD conversion to complete
;while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
_0x3:
	MOVW R30,R16
	LDD  R26,Z+3
	ANDI R26,LOW(0x1)
	BREQ _0x3
;// Clear the interrupt flag
;pch->INTFLAGS=ADC_CH_CHIF_bm;
	RJMP _0x210002D
;// Read the AD conversion result
;((unsigned char *) &data)[0]=pch->RESL;
;((unsigned char *) &data)[1]=pch->RESH;
;return data;
;}
; .FEND
;
;// ADCA sweeped channel(s) data read function
;// for software triggered mode
;void adca_sweep_read(unsigned char nch, unsigned int *pdata)
;{
;ADC_CH_t *pch=&ADCA.CH0;
;unsigned char i,j,m;
;
;// Sweep starts with channel 0
;j=ADC_CH0START_bm;
;	nch -> Y+8
;	*pdata -> Y+6
;	*pch -> R16,R17
;	i -> R19
;	j -> R18
;	m -> R21
;// Prepare the AD conversion start mask for the sweeped channel(s)
;m=0;
;i=0;
;do
;  {
;  m|=j;
;  j<<=1;
;  }
;while (++i<nch);
;// Ensure the interrupt flags are cleared
;ADCA.INTFLAGS=ADCA.INTFLAGS;
;// Start the AD conversion for the sweeped channel(s)
;ADCA.CTRLA=(ADCA.CTRLA & (ADC_DMASEL_gm | ADC_FLUSH_bm | ADC_ENABLE_bm)) | m;
;// Read and store the AD conversion results for all the sweeped channels
;for (i=0; i<nch; i++)
;    {
;    // Wait for the AD conversion to complete
;    while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
;    // Clear the interrupt flag
;    pch->INTFLAGS=ADC_CH_CHIF_bm;
;    // Read the AD conversion result
;    ((unsigned char *) pdata)[0]=pch->RESL;
;    ((unsigned char *) pdata)[1]=pch->RESH;
;    pdata++;
;    pch++;
;    }
;}
;
;// ADCB initialization
;void adcb_init(void)
;{
_adcb_init:
; .FSTART _adcb_init
;// ADCB is enabled
;// Resolution: 12 Bits
;// Load the calibration value for 12 Bit resolution
;// from the signature row
;ADCB.CALL=read_calibration_byte(PROD_SIGNATURES_START+ADCBCAL0_offset);
	LDI  R26,LOW(36)
	RCALL _read_calibration_byte
	STS  588,R30
;ADCB.CALH=read_calibration_byte(PROD_SIGNATURES_START+ADCBCAL1_offset);
	LDI  R26,LOW(37)
	RCALL _read_calibration_byte
	STS  589,R30
;
;// Free Running mode: Off
;// Conversion mode: Unsigned
;ADCB.CTRLB=(0<<ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc;
	LDI  R30,LOW(0)
	STS  577,R30
;
;// Clock frequency: 1000,000 kHz
;ADCB.PRESCALER=ADC_PRESCALER_DIV32_gc;
	LDI  R30,LOW(3)
	STS  580,R30
;
;// Reference: Internal Vcc/1.6
;// Temperature reference: Off
;ADCB.REFCTRL=ADC_REFSEL_VCC_gc | (0<<ADC_TEMPREF_bp) | (0<<ADC_BANDGAP_bp);
	LDI  R30,LOW(16)
	STS  578,R30
;
;// Initialize the ADC Compare register
;ADCB.CMPL=0x00;
	LDI  R30,LOW(0)
	STS  600,R30
;ADCB.CMPH=0x00;
	STS  601,R30
;
;// ADC channel 0 gain: 1
;// ADC channel 0 input mode: Single-ended positive input signal
;ADCB.CH0.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  608,R30
;
;// ADC channel 0 positive input: ADC0 pin
;// ADC channel 0 negative input: GND
;ADCB.CH0.MUXCTRL=ADC_CH_MUXPOS_PIN0_gc;
	LDI  R30,LOW(0)
	STS  609,R30
;
;// ADC channel 1 gain: 1
;// ADC channel 1 input mode: Single-ended positive input signal
;ADCB.CH1.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  616,R30
;
;// ADC channel 1 positive input: ADC1 pin
;// ADC channel 1 negative input: GND
;ADCB.CH1.MUXCTRL=ADC_CH_MUXPOS_PIN1_gc;
	LDI  R30,LOW(8)
	STS  617,R30
;
;// ADC channel 2 gain: 1
;// ADC channel 2 input mode: Single-ended positive input signal
;ADCB.CH2.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  624,R30
;
;// ADC channel 2 positive input: ADC2 pin
;// ADC channel 2 negative input: GND
;ADCB.CH2.MUXCTRL=ADC_CH_MUXPOS_PIN2_gc;
	LDI  R30,LOW(16)
	STS  625,R30
;
;// ADC channel 3 gain: 1
;// ADC channel 3 input mode: Single-ended positive input signal
;ADCB.CH3.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;
	LDI  R30,LOW(1)
	STS  632,R30
;
;// ADC channel 3 positive input: ADC3 pin
;// ADC channel 3 negative input: GND
;ADCB.CH3.MUXCTRL=ADC_CH_MUXPOS_PIN3_gc;
	LDI  R30,LOW(24)
	STS  633,R30
;
;// AD conversion is started by software
;ADCB.EVCTRL=ADC_EVACT_NONE_gc;
	LDI  R30,LOW(0)
	STS  579,R30
;
;// Channel 0 interrupt: Disabled
;ADCB.CH0.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  610,R30
;// Channel 1 interrupt: Disabled
;ADCB.CH1.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  618,R30
;// Channel 2 interrupt: Disabled
;ADCB.CH2.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  626,R30
;// Channel 3 interrupt: Disabled
;ADCB.CH3.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
	STS  634,R30
;
;// Enable the ADC
;ADCB.CTRLA|=ADC_ENABLE_bm;
	LDS  R30,576
	ORI  R30,1
	STS  576,R30
;// Insert a delay to allow the ADC common mode voltage to stabilize
;delay_us(2);
_0x210002E:
	__DELAY_USB 21
;}
	RET
; .FEND
;
;// ADCB channel data read function using polled mode
;unsigned int adcb_read(unsigned char channel)
;{
_adcb_read:
; .FSTART _adcb_read
;ADC_CH_t *pch=&ADCB.CH0+channel;
;unsigned int data;
;
;// Start the AD conversion
;pch->CTRL|= 1<<ADC_CH_START_bp;
	ST   -Y,R26
	CALL __SAVELOCR4
;	channel -> Y+4
;	*pch -> R16,R17
;	data -> R18,R19
	LDD  R30,Y+4
	LDI  R31,0
	LDI  R26,LOW(608)
	LDI  R27,HIGH(608)
	CALL SUBOPT_0x0
;// Wait for the AD conversion to complete
;while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
_0xF:
	MOVW R30,R16
	LDD  R26,Z+3
	ANDI R26,LOW(0x1)
	BREQ _0xF
;// Clear the interrupt flag
;pch->INTFLAGS=ADC_CH_CHIF_bm;
_0x210002D:
	MOVW R26,R16
	ADIW R26,3
	LDI  R30,LOW(1)
	ST   X,R30
;// Read the AD conversion result
;((unsigned char *) &data)[0]=pch->RESL;
	MOVW R30,R16
	LDD  R18,Z+4
;((unsigned char *) &data)[1]=pch->RESH;
	LDD  R19,Z+5
;return data;
	MOVW R30,R18
	CALL __LOADLOCR4
	ADIW R28,5
	RET
;}
; .FEND
;
;// ADCB sweeped channel(s) data read function
;// for software triggered mode
;void adcb_sweep_read(unsigned char nch, unsigned int *pdata)
;{
;ADC_CH_t *pch=&ADCB.CH0;
;unsigned char i,j,m;
;
;// Sweep starts with channel 0
;j=ADC_CH0START_bm;
;	nch -> Y+8
;	*pdata -> Y+6
;	*pch -> R16,R17
;	i -> R19
;	j -> R18
;	m -> R21
;// Prepare the AD conversion start mask for the sweeped channel(s)
;m=0;
;i=0;
;do
;  {
;  m|=j;
;  j<<=1;
;  }
;while (++i<nch);
;// Ensure the interrupt flags are cleared
;ADCB.INTFLAGS=ADCB.INTFLAGS;
;// Start the AD conversion for the sweeped channel(s)
;ADCB.CTRLA=(ADCB.CTRLA & (ADC_DMASEL_gm | ADC_FLUSH_bm | ADC_ENABLE_bm)) | m;
;// Read and store the AD conversion results for all the sweeped channels
;for (i=0; i<nch; i++)
;    {
;    // Wait for the AD conversion to complete
;    while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
;    // Clear the interrupt flag
;    pch->INTFLAGS=ADC_CH_CHIF_bm;
;    // Read the AD conversion result
;    ((unsigned char *) pdata)[0]=pch->RESL;
;    ((unsigned char *) pdata)[1]=pch->RESH;
;    pdata++;
;    pch++;
;    }
;}
;#include "datafile.c"
;//файл для протокола общения с ПК
;/*Байт  //
;1    Маркер (А5)
;2    Ток ФЭУ
;2    Расход помпы.
;2    Напряжение ФЭУ.
;2    Сигнал  усилителя
;2    Доп АЦП 3
;2    Температура воздуха в аналитической кювете.
;2    Температура контрольной кюветы
;2     Давление воздуха в аналитической кювете.
;1    Доп АЦП 1 младший байт
;1    Доп АЦП 1 старший байт
;1    Доп АЦП 2 младший байт
;1    Доп АЦП 2 старший байт
;1	Статус
;1	Контрольная сумма
;*/
;//#include "usart_init.c"
;
;// USARTC0 Receiver buffer
;//char RX_BUFFER_SIZE_USARTC0=30;
;//char rx_counter_usartc0=0;
;//char rx_wr_index_usartc0=0,rx_rd_index_usartc0=0,rx_counter_usartc0=0;
;//char rx_buffer_usartc0[RX_BUFFER_SIZE_USARTC0];
;
;/* NAME file */
;char fNAME[15];
;bit flag_sd=0;
;char tSDACARD[45];
;bool izm=0;
;char potok1[36];
;unsigned int T_analog,Tempf_K;
;bool CLBR=0;
;unsigned int KALC_PULS;
;
;char RX_BUFFER_SIZE_USARTC0=1;
;char rx_buffer_usartc0[30];
;unsigned char rx_wr_index_usartc0=0,rx_rd_index_usartc0=0,rx_counter_usartc0=0;
;
;
;#define VREF 2050.0 // ADC reference voltage [mV]
;#define CHANNELS 4
;unsigned char nn,xx;
;
;// Store ADC result
;unsigned int adcb_store[4];//0,1,2,3
;unsigned int adca_store[4];//4,5,6,7
;
;unsigned int adcb_SD[4];//0,1,2,3
;unsigned int adca_SD[4];//4,5,6,7
;
;unsigned char B5upr;
;
;////////////////////////////////////////////
;char A0[6];//данные пакета A0
;char AF[18];//данные пакета AF
;char AA[4];//данные пакета AA
;char A1[27];//данные пакета A1
;///////////////////////////////////////////
;char AD[6];//данные пакета AD
;char A7[3];//данные пакета A7
;char p77[4];//данные пакета 77
;char p76[4];//данные пакета 76
;char ch,l;//переменная перебора для контольного байта
;char AB[12];//данные пакета AB
;char A2[4];//данные пакета A2
;char AE[10];//данные пакета AE
;char p6A[6];//данные пакета 6a
;////////////////////////////////////////////////////
;char A4[6];//данные пакета A4
;char p58[6];//данные пакета 58
;char A6[6];//данные пакета A6
;//////////////////////////////////////////////////
;unsigned char check_sum=0;
;char info[30];
;//перебор s1
;//usart функции в этом файле!!
;unsigned char status;
;char data;
;//////////usart функции в этом файле!!
;
;//bit mb=0;//0-малый 1-большой пакет
;//отправка
;char S0[23];
;//прием
;char S1[30];
;
;char send=0;
;char indexs1=0;
;char s1suml;
;char Mx=0xFF,markerok=0,dl=0;

	.DSEG
;
;char B5buf[4];
;
;void topk(void)
; 0000 0010 {

	.CSEG
_topk:
; .FSTART _topk
;
;unsigned char x,SUM;
;PORTR.OUT=PORTR.OUT&0b11111110;
	ST   -Y,R17
	ST   -Y,R16
;	x -> R17
;	SUM -> R16
	LDS  R30,2020
	ANDI R30,0xFE
	STS  2020,R30
;
;for (x=0,SUM=0;x<22;x++)
	LDI  R17,LOW(0)
	LDI  R16,LOW(0)
_0x1D:
	CPI  R17,22
	BRSH _0x1E
;{
;if (x!=0) SUM=SUM+S0[x];
	CPI  R17,0
	BREQ _0x1F
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_S0)
	SBCI R31,HIGH(-_S0)
	LD   R30,Z
	ADD  R16,R30
;putchar(S0[x]);
_0x1F:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_S0)
	SBCI R31,HIGH(-_S0)
	LD   R26,Z
	CALL _putchar
;}
	SUBI R17,-1
	RJMP _0x1D
_0x1E:
;S0[22]=SUM;
	__PUTBMRN _S0,22,16
;putchar(S0[22]);
	__GETB2MN _S0,22
	CALL _putchar
;PORTR.OUT=PORTR.OUT|0b00000001;
	LDS  R30,2020
	ORI  R30,1
	STS  2020,R30
;}
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;//при первом включении прописать данные
;void initzavod (void)
;{
_initzavod:
; .FSTART _initzavod
;//заводская инициализация A0
;A0[0]=0xA0;
	LDI  R30,LOW(160)
	STS  _A0,R30
;A0[1]=0x30;
	LDI  R30,LOW(48)
	__PUTB1MN _A0,1
;A0[2]=0x33;
	LDI  R30,LOW(51)
	__PUTB1MN _A0,2
;A0[3]=0x35;
	LDI  R30,LOW(53)
	__PUTB1MN _A0,3
;A0[4]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A0,4
;l=sizeof(A0);
	CALL SUBOPT_0x1
;//checksum2(A0);
;for(ch=1,A0[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A0)
	SBCI R31,HIGH(-_A0)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x21:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x22
;{
;A0[l-1]=A0[l-1]+A0[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x4
;}
	CALL SUBOPT_0x5
	RJMP _0x21
_0x22:
;l=0;
	LDI  R30,LOW(0)
	STS  _l,R30
;
;AF[0]=0xAF;
	LDI  R30,LOW(175)
	STS  _AF,R30
;AF[1]=0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _AF,1
;AF[2]=0x63;
	LDI  R30,LOW(99)
	__PUTB1MN _AF,2
;AF[3]=0x60;
	LDI  R30,LOW(96)
	__PUTB1MN _AF,3
;AF[4]=0x64;
	LDI  R30,LOW(100)
	__PUTB1MN _AF,4
;AF[5]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _AF,5
;AF[6]=0x00;
	__PUTB1MN _AF,6
;AF[7]=0x00;
	__PUTB1MN _AF,7
;AF[8]=0x00;
	__PUTB1MN _AF,8
;AF[9]=0x00;
	__PUTB1MN _AF,9
;AF[10]=0x00;
	__PUTB1MN _AF,10
;AF[11]=0x00;
	__PUTB1MN _AF,11
;AF[12]=0x98;
	LDI  R30,LOW(152)
	__PUTB1MN _AF,12
;AF[13]=0x3A;
	LDI  R30,LOW(58)
	__PUTB1MN _AF,13
;AF[14]=0xDC;
	LDI  R30,LOW(220)
	__PUTB1MN _AF,14
;AF[15]=0x05;
	LDI  R30,LOW(5)
	__PUTB1MN _AF,15
;AF[16]=0x05;
	__PUTB1MN _AF,16
;l=sizeof(AF);
	CALL SUBOPT_0x6
;for(ch=1,AF[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_AF)
	SBCI R31,HIGH(-_AF)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x24:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x25
;AF[l-1]=AF[l-1]+AF[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x7
	CALL SUBOPT_0x5
	RJMP _0x24
_0x25:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;AA[0]=0xAA;
	LDI  R30,LOW(170)
	STS  _AA,R30
;AA[1]=0x60;
	LDI  R30,LOW(96)
	__PUTB1MN _AA,1
;AA[2]=0xEA;
	LDI  R30,LOW(234)
	__PUTB1MN _AA,2
;l=sizeof(AA);
	CALL SUBOPT_0x8
;for(ch=1,AA[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_AA)
	SBCI R31,HIGH(-_AA)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x27:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x28
;AA[l-1]=AA[l-1]+AA[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x9
	CALL SUBOPT_0x5
	RJMP _0x27
_0x28:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;A2[0]=0xA2;
	LDI  R30,LOW(162)
	STS  _A2,R30
;A2[1]=0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _A2,1
;A2[2]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A2,2
;l=sizeof(A2);
	CALL SUBOPT_0x8
;for(ch=1,A2[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A2)
	SBCI R31,HIGH(-_A2)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x2A:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x2B
;A2[l-1]=A2[l-1]+A2[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0xA
	CALL SUBOPT_0x5
	RJMP _0x2A
_0x2B:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;AD[0]=0xAD;
	LDI  R30,LOW(173)
	STS  _AD,R30
;AD[1]=0x5A;
	LDI  R30,LOW(90)
	__PUTB1MN _AD,1
;AD[2]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _AD,2
;AD[3]=0x5A;
	LDI  R30,LOW(90)
	__PUTB1MN _AD,3
;AD[4]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _AD,4
;l=sizeof(AD);
	CALL SUBOPT_0x1
;for(ch=1,AD[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_AD)
	SBCI R31,HIGH(-_AD)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x2D:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x2E
;AD[l-1]=AD[l-1]+AD[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0xB
	CALL SUBOPT_0x5
	RJMP _0x2D
_0x2E:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;
;A6[0]=0xA6;
	LDI  R30,LOW(166)
	STS  _A6,R30
;A6[1]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A6,1
;A6[2]=0x00;
	__PUTB1MN _A6,2
;A6[3]=0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _A6,3
;A6[4]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A6,4
;l=sizeof(A6);
	CALL SUBOPT_0x1
;for(ch=1,A6[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A6)
	SBCI R31,HIGH(-_A6)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x30:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x31
;A6[l-1]=A6[l-1]+A6[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0xC
	CALL SUBOPT_0x5
	RJMP _0x30
_0x31:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;A1[0]=0xA1;
	LDI  R30,LOW(161)
	STS  _A1,R30
;A1[1]=0x53;
	LDI  R30,LOW(83)
	__PUTB1MN _A1,1
;A1[2]=0x75;
	LDI  R30,LOW(117)
	__PUTB1MN _A1,2
;A1[3]=0x6E;
	LDI  R30,LOW(110)
	__PUTB1MN _A1,3
;A1[4]=0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _A1,4
;///////////////
;A1[5]=0x53;
	LDI  R30,LOW(83)
	__PUTB1MN _A1,5
;A1[6]=0x65;
	LDI  R30,LOW(101)
	__PUTB1MN _A1,6
;A1[7]=0x70;
	LDI  R30,LOW(112)
	__PUTB1MN _A1,7
;A1[8]=0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _A1,8
;A1[9]=0x32;
	LDI  R30,LOW(50)
	__PUTB1MN _A1,9
;///////////////
;A1[10]=0x31;
	LDI  R30,LOW(49)
	__PUTB1MN _A1,10
;A1[11]=0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _A1,11
;A1[12]=0x32;
	LDI  R30,LOW(50)
	__PUTB1MN _A1,12
;A1[13]=0x33;
	LDI  R30,LOW(51)
	__PUTB1MN _A1,13
;A1[14]=0x3A;
	LDI  R30,LOW(58)
	__PUTB1MN _A1,14
;/////////////
;A1[15]=0x33;
	LDI  R30,LOW(51)
	__PUTB1MN _A1,15
;A1[16]=0x36;
	LDI  R30,LOW(54)
	__PUTB1MN _A1,16
;A1[17]=0x3A;
	LDI  R30,LOW(58)
	__PUTB1MN _A1,17
;A1[18]=0x32;
	LDI  R30,LOW(50)
	__PUTB1MN _A1,18
;A1[19]=0x34;
	LDI  R30,LOW(52)
	__PUTB1MN _A1,19
;////////////
;A1[20]=0x20;
	LDI  R30,LOW(32)
	__PUTB1MN _A1,20
;A1[21]=0x32;
	LDI  R30,LOW(50)
	__PUTB1MN _A1,21
;A1[22]=0x30;
	LDI  R30,LOW(48)
	__PUTB1MN _A1,22
;A1[23]=0x31;
	LDI  R30,LOW(49)
	__PUTB1MN _A1,23
;A1[24]=0x34;
	LDI  R30,LOW(52)
	__PUTB1MN _A1,24
;A1[25]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A1,25
;//B0
;//////////////
;l=sizeof(A1);
	CALL SUBOPT_0xD
;for(ch=1,A1[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A1)
	SBCI R31,HIGH(-_A1)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x33:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x34
;A1[l-1]=A1[l-1]+A1[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0xE
	CALL SUBOPT_0x5
	RJMP _0x33
_0x34:
	LDI  R30,LOW(0)
	STS  _l,R30
;A7[0]=0xA7;
	LDI  R30,LOW(167)
	STS  _A7,R30
;A7[1]=0x42;
	LDI  R30,LOW(66)
	__PUTB1MN _A7,1
;l=sizeof(A7);
	CALL SUBOPT_0xF
;for(ch=1,A7[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A7)
	SBCI R31,HIGH(-_A7)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x36:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x37
;A7[l-1]=A7[l-1]+A7[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x10
	CALL SUBOPT_0x5
	RJMP _0x36
_0x37:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;p77[0]=0x77;
	LDI  R30,LOW(119)
	STS  _p77,R30
;p77[1]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _p77,1
;p77[2]=0xFC;
	LDI  R30,LOW(252)
	__PUTB1MN _p77,2
;//p77[3]=0xFC;
;l=sizeof(p77);
	CALL SUBOPT_0x8
;for(ch=1,p77[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_p77)
	SBCI R31,HIGH(-_p77)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x39:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x3A
;p77[l-1]=p77[l-1]+p77[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x11
	CALL SUBOPT_0x5
	RJMP _0x39
_0x3A:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;AB[0]=0xAB;
	LDI  R30,LOW(171)
	STS  _AB,R30
;AB[1]=0x75;
	LDI  R30,LOW(117)
	__PUTB1MN _AB,1
;AB[2]=0x6E;
	LDI  R30,LOW(110)
	__PUTB1MN _AB,2
;AB[3]=0x37;
	LDI  R30,LOW(55)
	__PUTB1MN _AB,3
;AB[4]=0x30;
	LDI  R30,LOW(48)
	__PUTB1MN _AB,4
;AB[5]=0x32;
	LDI  R30,LOW(50)
	__PUTB1MN _AB,5
;AB[6]=0x62;
	LDI  R30,LOW(98)
	__PUTB1MN _AB,6
;AB[7]=0x0E;
	LDI  R30,LOW(14)
	__PUTB1MN _AB,7
;AB[8]=0x04;
	LDI  R30,LOW(4)
	__PUTB1MN _AB,8
;AB[9]=0x14;
	LDI  R30,LOW(20)
	__PUTB1MN _AB,9
;AB[10]=0x0E;
	LDI  R30,LOW(14)
	__PUTB1MN _AB,10
;//
;l=sizeof(AB);
	CALL SUBOPT_0x12
;for(ch=1,AB[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_AB)
	SBCI R31,HIGH(-_AB)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x3C:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x3D
;AB[l-1]=AB[l-1]+AB[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x13
	CALL SUBOPT_0x5
	RJMP _0x3C
_0x3D:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;AE[0]=0xAE;
	LDI  R30,LOW(174)
	STS  _AE,R30
;AE[1]=0xFF;
	LDI  R30,LOW(255)
	__PUTB1MN _AE,1
;AE[2]=0xFF;
	__PUTB1MN _AE,2
;AE[3]=0xFF;
	__PUTB1MN _AE,3
;AE[4]=0xFF;
	__PUTB1MN _AE,4
;AE[5]=0xFF;
	__PUTB1MN _AE,5
;AE[6]=0xFF;
	__PUTB1MN _AE,6
;AE[7]=0xFF;
	__PUTB1MN _AE,7
;AE[8]=0xFF;
	__PUTB1MN _AE,8
;//AE[9]=0x14;
;l=sizeof(AE);
	CALL SUBOPT_0x14
;for(ch=1,AE[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_AE)
	SBCI R31,HIGH(-_AE)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x3F:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x40
;AE[l-1]=AE[l-1]+AE[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x15
	CALL SUBOPT_0x5
	RJMP _0x3F
_0x40:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;
;
;
;A4[0]=0xA4;
	LDI  R30,LOW(164)
	STS  _A4,R30
;A4[1]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _A4,1
;A4[2]=0xFC;
	LDI  R30,LOW(252)
	__PUTB1MN _A4,2
;A4[3]=0x68;
	LDI  R30,LOW(104)
	__PUTB1MN _A4,3
;A4[4]=0xF7;
	LDI  R30,LOW(247)
	__PUTB1MN _A4,4
;//
;l=sizeof(A4);
	CALL SUBOPT_0x1
;for(ch=1,A4[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_A4)
	SBCI R31,HIGH(-_A4)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x42:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x43
;A4[l-1]=A4[l-1]+A4[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x16
	CALL SUBOPT_0x5
	RJMP _0x42
_0x43:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;p58[0]=0x58;
	LDI  R30,LOW(88)
	STS  _p58,R30
;p58[1]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _p58,1
;p58[2]=0x00;
	__PUTB1MN _p58,2
;p58[3]=0x01;
	LDI  R30,LOW(1)
	__PUTB1MN _p58,3
;p58[4]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _p58,4
;//
;l=sizeof(p58);
	CALL SUBOPT_0x1
;for(ch=1,p58[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_p58)
	SBCI R31,HIGH(-_p58)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x45:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x46
;p58[l-1]=p58[l-1]+p58[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x17
	CALL SUBOPT_0x5
	RJMP _0x45
_0x46:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;p76[0]=0x76;
	LDI  R30,LOW(118)
	STS  _p76,R30
;p76[1]=0xFF;
	LDI  R30,LOW(255)
	__PUTB1MN _p76,1
;p76[2]=0xFF;
	__PUTB1MN _p76,2
;//p77[3]=0xFE;
;l=sizeof(p76);
	CALL SUBOPT_0x8
;for(ch=1,p76[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_p76)
	SBCI R31,HIGH(-_p76)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x48:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x49
;p76[l-1]=p76[l-1]+p76[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x18
	CALL SUBOPT_0x5
	RJMP _0x48
_0x49:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;
;
;p6A[0]=0x6A;
	LDI  R30,LOW(106)
	STS  _p6A,R30
;p6A[1]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _p6A,1
;p6A[2]=0x00;
	__PUTB1MN _p6A,2
;p6A[3]=0x00;
	__PUTB1MN _p6A,3
;p6A[4]=0x00;
	__PUTB1MN _p6A,4
;//p77[3]=0xFE;
;l=sizeof(p6A);
	CALL SUBOPT_0x1
;for(ch=1,p6A[l-1]=0;ch<l-1;ch++)
	SUBI R30,LOW(-_p6A)
	SBCI R31,HIGH(-_p6A)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x4B:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x4C
;p6A[l-1]=p6A[l-1]+p6A[ch];
	CALL SUBOPT_0x2
	CALL SUBOPT_0x19
	CALL SUBOPT_0x5
	RJMP _0x4B
_0x4C:
	LDI  R30,LOW(0)
	STS  _l,R30
;
;}
	RET
; .FEND
;
;
;//инициализация массива для передачи %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;void reginit (void)
;{
_reginit:
; .FSTART _reginit
;S0[0]=0xA5;// Маркер (А5)
	LDI  R30,LOW(165)
	STS  _S0,R30
;//тест
;S0[1]=0x40;// Ток ФЭУ
	LDI  R30,LOW(64)
	__PUTB1MN _S0,1
;S0[2]=0x1F;// Ток ФЭУ
	LDI  R30,LOW(31)
	__PUTB1MN _S0,2
;
;//S0[1]=0x98;// Ток ФЭУ
;//S0[2]=0x3A;// Ток ФЭУ
;
;//S0[3]=0x30;// Расход помпы
;//S0[4]=0x75;// Расход помпы.
;
;S0[3]=0x78;// Расход помпы.
	LDI  R30,LOW(120)
	__PUTB1MN _S0,3
;S0[4]=0x00; // Расход помпы.
	LDI  R30,LOW(0)
	__PUTB1MN _S0,4
;
;S0[5]=0xBB;// Напряжение ФЭУ
	LDI  R30,LOW(187)
	__PUTB1MN _S0,5
;S0[6]=0x0B; // Напряжение ФЭУ
	LDI  R30,LOW(11)
	__PUTB1MN _S0,6
;
;//S0[7]=0x00;// Сигнал  усилителя
;//S0[8]=0xFF; //Сигнал  усилителя
;
;
;S0[9]=0x00;// Доп АЦП 3
	LDI  R30,LOW(0)
	__PUTB1MN _S0,9
;S0[10]=0x08; //Доп АЦП 3
	LDI  R30,LOW(8)
	__PUTB1MN _S0,10
;
;S0[11]=0xAD;// Температура воздуха в аналитической кювете.
	LDI  R30,LOW(173)
	__PUTB1MN _S0,11
;S0[12]=0x0D; //Температура воздуха в аналитической кювете.
	LDI  R30,LOW(13)
	__PUTB1MN _S0,12
;
;S0[13]=0xAC;// Температура контрольной кюветы
	LDI  R30,LOW(172)
	__PUTB1MN _S0,13
;S0[14]=0x0D; //Температура контрольной кюветы
	LDI  R30,LOW(13)
	__PUTB1MN _S0,14
;
;//S0[15]=0x15; //!! // Давление воздуха в аналитической кювете. мл
;//S0[16]=0x0C; //!!//Давление воздуха в аналитической кювете.     ст
;
;S0[15]=0x10;  // Давление воздуха в аналитической кювете. мл
	LDI  R30,LOW(16)
	__PUTB1MN _S0,15
;S0[16]=0x27;
	LDI  R30,LOW(39)
	__PUTB1MN _S0,16
;
;S0[17]=0x00; // Доп АЦП 1 младший байт
	LDI  R30,LOW(0)
	__PUTB1MN _S0,17
;S0[18]=0x04; // Доп АЦП 1 старший байт
	LDI  R30,LOW(4)
	__PUTB1MN _S0,18
;
;S0[19]=0x00; // Доп АЦП 2 младший байт
	LDI  R30,LOW(0)
	__PUTB1MN _S0,19
;S0[20]=0x06; // Доп АЦП 2 старший байт
	LDI  R30,LOW(6)
	__PUTB1MN _S0,20
;
;//S0[21]=0b11111011; // Статус
;S0[21]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _S0,21
;//S0[22]=checksum(); // Контрольная сумма
;}
	RET
; .FEND
;
;/*
;запрос на сброс мк F5,5F,check
;Ответ f5,f5, chek;
;*/
;////////////////////////////////////////////////////////////////////////
;//Программный RESET
;//void (*funcptr)( void ) = 0x0000;
;//unsigned char tmp=RST_SWRST_bm;
;//CCP = CCP_IOREG_gc;
;//RST.CTRL=RST_SWRST_bm;
;//Программный RESET
;////////////////////////////////////////////////////////////////////////
;//очистка строки
;void clrs1(void)
;{
;memset(S1, 0, sizeof(S1));
;}
;#include "port_init.c"
;// Ports initialization
;void ports_init(void)
; 0000 0011 {
_ports_init:
; .FSTART _ports_init
;// PORTA initialization
;PORTA.OUT=0x00;
	LDI  R30,LOW(0)
	STS  1540,R30
;PORTA.DIR=0x00;
	STS  1536,R30
;PORTA.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1552,R30
;PORTA.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1553,R30
;PORTA.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1554,R30
;PORTA.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1555,R30
;PORTA.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1556,R30
;PORTA.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1557,R30
;PORTA.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1558,R30
;PORTA.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1559,R30
;
;PORTA.INTCTRL=(PORTA.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1545
	ANDI R30,LOW(0xF0)
	STS  1545,R30
;PORTA.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1546,R30
;PORTA.INT1MASK=0x00;
	STS  1547,R30
;
;// PORTB initialization
;PORTB.OUT=0x00;
	STS  1572,R30
;PORTB.DIR=0x00;
	STS  1568,R30
;PORTB.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1584,R30
;PORTB.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1585,R30
;PORTB.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1586,R30
;PORTB.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1587,R30
;PORTB.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1588,R30
;PORTB.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1589,R30
;PORTB.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1590,R30
;PORTB.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1591,R30
;PORTB.INTCTRL=(PORTB.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1577
	ANDI R30,LOW(0xF0)
	STS  1577,R30
;
;PORTB.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1578,R30
;PORTB.INT1MASK=0x00;
	STS  1579,R30
;
;// PORTC initialization
;PORTC.OUT=0x18;
	CALL SUBOPT_0x1A
;// Bit0: Output
;// Bit1: Input
;// Bit2: Input
;// Bit3: Output
;// Bit4: Output
;// Bit5: Output
;// Bit6: Input
;// Bit7: Output
;PORTC.DIR=0xB9;
;PORTC.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1616,R30
;//PORTC.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
;PORTC.PIN1CTRL=PORT_OPC_PULLUP_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(24)
	STS  1617,R30
;
;PORTC.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1618,R30
;PORTC.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1619,R30
;PORTC.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1620,R30
;PORTC.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1621,R30
;PORTC.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1622,R30
;PORTC.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1623,R30
;
;PORTC.INTCTRL=(PORTC.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1609
	ANDI R30,LOW(0xF0)
	STS  1609,R30
;PORTC.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1610,R30
;PORTC.INT1MASK=0x00;
	STS  1611,R30
;
;// PORTD initialization
;// OUT register
;PORTD.OUT=0x80;
	LDI  R30,LOW(128)
	STS  1636,R30
;// Bit0: Input
;// Bit1: Input
;// Bit2: Input
;// Bit3: Input
;// Bit4: Input
;// Bit5: Input
;// Bit6: Input
;// Bit7: Output
;PORTD.DIR=0x80;
	STS  1632,R30
;
;PORTD.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1648,R30
;PORTD.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1649,R30
;PORTD.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1650,R30
;PORTD.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1651,R30
;PORTD.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1652,R30
;PORTD.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1653,R30
;PORTD.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1654,R30
;PORTD.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1655,R30
;
;PORTD.INTCTRL=(PORTD.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1641
	ANDI R30,LOW(0xF0)
	STS  1641,R30
;PORTD.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1642,R30
;PORTD.INT1MASK=0x00;
	STS  1643,R30
;
;// PORTE initialization
;// OUT register
;PORTE.OUT=0x00;
	STS  1668,R30
;PORTE.DIR=0x00;
	STS  1664,R30
;PORTE.DIR=PORTE.DIR|0b00010000;
	LDS  R30,1664
	ORI  R30,0x10
	STS  1664,R30
;
;PORTE.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;//PORT_OPC_PULLUP_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1680,R30
;PORTE.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;//PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1681,R30
;PORTE.PIN2CTRL=PORT_OPC_PULLDOWN_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(16)
	STS  1682,R30
;PORTE.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  1683,R30
;PORTE.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1684,R30
;PORTE.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1685,R30
;PORTE.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1686,R30
;PORTE.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1687,R30
;
;PORTE.INTCTRL=(PORTE.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1673
	ANDI R30,LOW(0xF0)
	STS  1673,R30
;PORTE.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1674,R30
;PORTE.INT1MASK=0x00;
	STS  1675,R30
;
;// PORTF initialization
;PORTF.OUT=0x00;
	STS  1700,R30
;PORTF.DIR=0x00;
	STS  1696,R30
;PORTF.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1712,R30
;PORTF.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1713,R30
;PORTF.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1714,R30
;PORTF.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1715,R30
;PORTF.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1716,R30
;PORTF.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1718,R30
;PORTF.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1719,R30
;
;PORTF.INTCTRL=(PORTF.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1705
	ANDI R30,LOW(0xF0)
	STS  1705,R30
;PORTF.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1706,R30
;PORTF.INT1MASK=0x00;
	STS  1707,R30
;
;// PORTR initialization
;PORTR.OUT=0x0F;
	LDI  R30,LOW(15)
	STS  2020,R30
;PORTR.DIR=0x0F;
	STS  2016,R30
;PORTR.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	LDI  R30,LOW(0)
	STS  2032,R30
;PORTR.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2033,R30
;PORTR.INTCTRL=(PORTR.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
;    PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,2025
	ANDI R30,LOW(0xF0)
	STS  2025,R30
;PORTR.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  2026,R30
;PORTR.INT1MASK=0x00;
	STS  2027,R30
;}
	RET
; .FEND
;#include "data_time.c"
;// RTC32 initialization
;
;#define RTC32_XOSC_FAILED 0
;#define RTC32_BATT_FAILED 1
;#define RTC32_COUNT_OK 2
;#define RTC32_DISABLED 3
;long unsigned int X;
;long unsigned int date1;
;bool newdate=0;
;bool newtime=0;
;long unsigned int time1;
;eeprom long unsigned int Xsave;
;unsigned char bufdt[5];
;
;
;void get_CNTRTC(long unsigned int * X)
; 0000 0012 {
_get_CNTRTC:
; .FSTART _get_CNTRTC
;RTC32.SYNCCTRL = RTC32_SYNCCNT_bm;
	ST   -Y,R27
	ST   -Y,R26
;	*X -> Y+0
	LDI  R30,LOW(16)
	STS  1057,R30
;while (RTC32.SYNCCTRL & RTC32_SYNCCNT_bm);
_0x4D:
	LDS  R30,1057
	ANDI R30,LOW(0x10)
	BRNE _0x4D
;*X=RTC32.CNT;
	LDS  R30,1060
	LDS  R31,1060+1
	LDS  R22,1060+2
	LDS  R23,1060+3
	LD   R26,Y
	LDD  R27,Y+1
	CALL __PUTDP1
;}
_0x210002C:
	ADIW R28,2
	RET
; .FEND
;
;
;unsigned char rtc32_battery_backup_init(void)
;{
;unsigned char status,s,n,result=RTC32_COUNT_OK;
;
;// Save the Battery Backup System status
;status=VBAT.STATUS;
;	status -> R17
;	s -> R16
;	n -> R19
;	result -> R18
;// Reset the Battery Backup Power-On Flag if it's not valid
;if (status & VBAT_BBPWR_bm) status&= ~VBAT_BBPORF_bm;
;
;// Optimize for speed
;#pragma optsize-
;// Save interrupts enabled/disabled state
;s=SREG;
;// Disable interrupts
;#asm("cli")
;
;// Check if the Battery Backup System had a failure or is not enabled
;if (status & (VBAT_BBBORF_bm | VBAT_BBPORF_bm))
;   {
;   // Signal that the backup battery had a failure
;   if (status & VBAT_BBBORF_bm) result=RTC32_BATT_FAILED;
;   set_rtc32:
;   // Enable the Battery Backup System access and apply a RESET
;   n=(VBAT.CTRL & (~(VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm))) |
;     VBAT_ACCEN_bm | VBAT_RESET_bm;
;   CCP=CCP_IOREG_gc;
;   VBAT.CTRL=n;
;   // External 32.768 kHz crystal oscillator low power mode: On
;   OSC.XOSCCTRL|=OSC_X32KLPM_bm;
;   // Enable the 32.768 kHz external oscillator
;   // RTC32 clock frequency: 1024 Hz
;   n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm;
;   CCP=CCP_IOREG_gc;
;   VBAT.CTRL=n;
;
;   // Wait for the external 32.768 kHz crystal oscillator to stabilize
;   while ((VBAT.STATUS & VBAT_XOSCRDY_bm)==0);
;
;   // Enable the 32.768 kHz external oscillator failure detector
;   n|=VBAT_XOSCFDEN_bm;
;   CCP=CCP_IOREG_gc;
;   VBAT.CTRL=n;
;
;   // Make sure that the RTC32 is disabled before initializing it
;   RTC32.CTRL=(0<<RTC32_ENABLE_bp);
;
;   // Wait until the RTC32 is not busy or synchronizing
;   while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));
;
;   // Set the RTC32 period register
;   RTC32.PER=0x1400;
;   // Set the RTC32 count register
;   RTC32.CNT=0x0000;
;   // Start the synchronization of the CNT register from
;   // the RTC32 clock to the System Clock domain
;   RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
;   // Set the RTC32 compare register
;   RTC32.COMP=0x0400;
;
;   // Enable the RTC32
;   RTC32.CTRL=(1<<RTC32_ENABLE_bp);
;
;   // RTC32 overflow interrupt: Disabled
;   // RTC32 compare interrupt: Low Level
;   RTC32.INTCTRL=RTC32_OVFINTLVL_OFF_gc | RTC32_COMPINTLVL_LO_gc;
;   }
;else
;   {
;   // The Battery Backup System has not had any power loss
;   n=VBAT.CTRL | VBAT_ACCEN_bm;
;
;   // Ensure that the external 32.768 kHz crystal oscillator
;   // and its failure detection are enabled
;   if ((n & (VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm)) != (VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm))
;      goto set_rtc32;
;
;   // Enable Battery Backup System access
;   CCP=CCP_IOREG_gc;
;   VBAT.CTRL=n;
;
;   // Check for external 32.768 kHz crystal oscillator failure
;   if (status & VBAT_XOSCFAIL_bm)
;      {
;      // Yes, the external 32.768 kHz crystal oscillator has had a failure,
;      // the RTC counter value is invalid, so it must be initialized again
;
;      // Wait until the RTC32 is not busy or synchronizing
;      while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));
;
;      // Set the RTC32 count register
;      RTC32.CNT=0x0000;
;      // Start the synchronization of the CNT register from
;      // the RTC32 clock to the System Clock domain
;      RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
;
;      // Signal that the RTC32 was re-initialized because the
;      // 32.768 kHz external oscillator has had a failure
;      result=RTC32_XOSC_FAILED;
;      }
;   }
;
;// Clear the status bits
;VBAT.STATUS=VBAT.STATUS;
;
;// Disable further Battery Backup System access
;n=VBAT.CTRL & (~VBAT_ACCEN_bm);
;CCP=CCP_IOREG_gc;
;VBAT.CTRL=n;
;
;// Restore interrupts enabled/disabled state
;SREG=s;
;// Restore optimization for size if needed
;#pragma optsize_default
;
;return result;
;}
;
;
;
;void rtc32_init_my(void)
;{
_rtc32_init_my:
; .FSTART _rtc32_init_my
;   unsigned char n;
;  // Enable Battery Backup System access
;   CCP=CCP_IOREG_gc;
	ST   -Y,R17
;	n -> R17
	LDI  R30,LOW(216)
	OUT  0x34,R30
;   VBAT.CTRL=VBAT.CTRL | VBAT_ACCEN_bm;;
	LDS  R30,240
	ORI  R30,2
	STS  240,R30
;
;   // External 32.768 kHz crystal oscillator low power mode: Off
;   OSC.XOSCCTRL&= ~OSC_X32KLPM_bm;
	LDS  R30,82
	ANDI R30,0xDF
	STS  82,R30
;   // Enable the 32.768 kHz external oscillator
;   // RTC32 clock frequency: 1024 Hz
;   //n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm;
;   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;   // RTC32 clock frequency: 1 Hz
;   n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCEN_bm;
	MOV  R30,R17
	ANDI R30,0xFE
	ORI  R30,8
	MOV  R17,R30
;
;
;   CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
;   VBAT.CTRL=n;
	STS  240,R17
;
;   // Wait for the external 32.768 kHz crystal oscillator to stabilize
;   while ((VBAT.STATUS & VBAT_XOSCRDY_bm)==0);
_0x60:
	LDS  R30,241
	ANDI R30,LOW(0x8)
	BREQ _0x60
;
;   // Enable the 32.768 kHz external oscillator failure detector
;   n|=VBAT_XOSCFDEN_bm;
	ORI  R17,LOW(4)
;   CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
;   VBAT.CTRL=n;
	STS  240,R17
;
;   // Make sure that the RTC32 is disabled before initializing it
;   RTC32.CTRL=(0<<RTC32_ENABLE_bp);
	LDI  R30,LOW(0)
	STS  1056,R30
;
;   // Wait until the RTC32 is not busy or synchronizing
;   while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));
_0x63:
	LDS  R30,1057
	ANDI R30,LOW(0x11)
	BRNE _0x63
;
;   // Set the RTC32 period register
;   //!RTC32.PER=0x1400;
;   RTC32.PER=0xFFFFFFFF;
	CALL SUBOPT_0x1B
;   // Set the RTC32 count register
;   //при включении время опять установиться, я закаментил строку
;   //RTC32.CNT=1111111111;    //18 марта 2005 года, 01:58:31
;   // Start the synchronization of the CNT register from
;   // the RTC32 clock to the System Clock domain
;   RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
	LDS  R30,1057
	ORI  R30,0x10
	STS  1057,R30
;   // Set the RTC32 compare register
;   RTC32.COMP=0x0000;
	CALL SUBOPT_0x1C
	STS  1068,R30
	STS  1068+1,R31
	STS  1068+2,R22
	STS  1068+3,R23
;
;   // Enable the RTC32
;   RTC32.CTRL=(1<<RTC32_ENABLE_bp);
	LDI  R30,LOW(1)
	STS  1056,R30
;
;   // RTC32 overflow interrupt: Medium Level _OFF_gc
;   // RTC32 compare interrupt: Disabled _MED_gc
;   RTC32.INTCTRL=RTC32_OVFINTLVL_OFF_gc | RTC32_COMPINTLVL_OFF_gc;
	LDI  R30,LOW(0)
	STS  1058,R30
;}
	LD   R17,Y+
	RET
; .FEND
;
;
;//RTC32.CNT=1111111111;    //18 марта 2005 года, 01:58:31
;void set_CNTRTC(void)
;{
_set_CNTRTC:
; .FSTART _set_CNTRTC
;CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
;//RTC32 is disabled t
;RTC32.CTRL=(0<<RTC32_ENABLE_bp);
	LDI  R30,LOW(0)
	STS  1056,R30
;// Wait until the RTC32 is not busy or synchronizing
;while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));
_0x66:
	LDS  R30,1057
	ANDI R30,LOW(0x11)
	BRNE _0x66
;RTC32.PER=0xFFFFFFFF;
	CALL SUBOPT_0x1B
;RTC32.CNT=X;
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
;// the RTC32 clock to the System Clock domain
;RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
	LDS  R30,1057
	ORI  R30,0x10
	STS  1057,R30
;// Enable the RTC32
;RTC32.CTRL=(1<<RTC32_ENABLE_bp);
	LDI  R30,LOW(1)
	STS  1056,R30
;}
	RET
; .FEND
;
;
;
;
;
;
;
;
;
;
;void calcDateTime(long seconds, long hours_to_gm, long unsigned int * date, long unsigned int * time)
;{
_calcDateTime:
; .FSTART _calcDateTime
;   long daysmonth[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
;   long secs_per_year  = 365 * 24 * 3600;
;   long secs_per_month = 31 * 24 * 3600;
;   long year           = 1970;
;   long month          = 1;
;   long day            = 1;
;   long hours          = 0;
;   long minutes        = 0;
;   long leap           = 0 ;
;
;   // adjust seconds to localtime
;   seconds -= hours_to_gm * 3600;
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,21
	LDI  R24,84
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x69*2)
	LDI  R31,HIGH(_0x69*2)
	CALL __INITLOCB
;	seconds -> Y+92
;	hours_to_gm -> Y+88
;	*date -> Y+86
;	*time -> Y+84
;	daysmonth -> Y+32
;	secs_per_year -> Y+28
;	secs_per_month -> Y+24
;	year -> Y+20
;	month -> Y+16
;	day -> Y+12
;	hours -> Y+8
;	minutes -> Y+4
;	leap -> Y+0
	__GETD1SX 88
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x20
	CALL __SUBD21
	__PUTD2SX 92
;   // year
;   for ( ; seconds > secs_per_year; ++year, seconds -= secs_per_year)
_0x6B:
	__GETD1S 28
	CALL SUBOPT_0x20
	CALL __CPD12
	BRGE _0x6C
;   {
;       leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
	CALL SUBOPT_0x21
	CALL SUBOPT_0x22
	BRNE _0x6D
	CALL SUBOPT_0x23
	CALL SUBOPT_0x24
	BRNE _0x6E
	CALL SUBOPT_0x25
	BRNE _0x6D
_0x6E:
	RJMP _0x70
_0x6D:
	RJMP _0x71
_0x70:
	CALL SUBOPT_0x26
	RJMP _0x72
_0x71:
	CALL SUBOPT_0x1C
_0x72:
	CALL SUBOPT_0x27
;       secs_per_year = (365 + leap) * 24 * 3600;
	CALL SUBOPT_0x28
	__PUTD1S 28
;   }
	CALL SUBOPT_0x21
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2A
	__GETD2S 28
	CALL SUBOPT_0x2B
	RJMP _0x6B
_0x6C:
;   // month
;   leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
	CALL SUBOPT_0x2C
	BRNE _0x74
	CALL SUBOPT_0x2D
	BRNE _0x75
	CALL SUBOPT_0x25
	BRNE _0x74
_0x75:
	RJMP _0x77
_0x74:
	RJMP _0x78
_0x77:
	CALL SUBOPT_0x26
	RJMP _0x79
_0x78:
	CALL SUBOPT_0x1C
_0x79:
	CALL SUBOPT_0x27
;   daysmonth[2] = (leap)? 29 : 28;
	CALL SUBOPT_0x2E
	BREQ _0x7B
	__GETD1N 0x1D
	RJMP _0x7C
_0x7B:
	__GETD1N 0x1C
_0x7C:
	__PUTD1S 40
;   for ( ; seconds >= secs_per_month; ++month, seconds -= secs_per_month)
_0x7F:
	__GETD1S 24
	CALL SUBOPT_0x20
	CALL __CPD21
	BRLT _0x80
;   {
;       secs_per_month = daysmonth[month]*24*3600;
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	MOVW R26,R28
	ADIW R26,32
	CALL SUBOPT_0x2F
	__PUTD1S 24
;   }
	CALL SUBOPT_0x30
	CALL SUBOPT_0x29
	CALL SUBOPT_0x31
	__GETD2S 24
	CALL SUBOPT_0x2B
	RJMP _0x7F
_0x80:
;   // day
;   day = (seconds / (24 * 3600) ) + 1;
	CALL SUBOPT_0x32
	CALL __DIVD21
	__ADDD1N 1
	CALL SUBOPT_0x33
;   seconds = seconds % (24 * 3600) ;
	CALL SUBOPT_0x32
	CALL SUBOPT_0x34
;
;   hours   = seconds / 3600;
	CALL SUBOPT_0x35
	CALL __DIVD21
	CALL SUBOPT_0x36
;   seconds = seconds % 3600;
	CALL SUBOPT_0x20
	CALL SUBOPT_0x35
	CALL SUBOPT_0x34
;
;   minutes = seconds / 60;
	__GETD1N 0x3C
	CALL __DIVD21
	CALL SUBOPT_0x37
;   seconds = seconds % 60;
	CALL SUBOPT_0x20
	__GETD1N 0x3C
	CALL __MODD21
	__PUTD1SX 92
;
;   *date   = year * 10000 + month * 100 + day;
	CALL SUBOPT_0x21
	CALL SUBOPT_0x38
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x30
	CALL SUBOPT_0x39
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	CALL SUBOPT_0x3A
	CALL __ADDD12
	__GETW2SX 86
	CALL __PUTDP1
;   *time   = hours * 10000 + minutes * 100 + seconds;
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x38
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x39
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	CALL SUBOPT_0x20
	CALL __ADDD12
	__GETW2SX 84
	CALL __PUTDP1
;
;}
	ADIW R28,63
	ADIW R28,33
	RET
; .FEND
;
;void calcSeconds(long unsigned int date, long unsigned int time, long unsigned int hours_to_gm, long unsigned int * seco ...
;{
_calcSeconds:
; .FSTART _calcSeconds
;   long daysmonth[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
;   long year           = date/10000;
;   long month          = (date%10000)/100;
;   long day            = date%100;
;   long hours          = time/10000;
;   long minutes        = (time%10000)/100;
;   long leap           = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;;
;
;   *seconds            = time%100 + minutes * 60 + (hours + hours_to_gm) * 3600 + (day - 1) * 24 * 3600;
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,13
	LDI  R24,52
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	LDI  R30,LOW(_0x88*2)
	LDI  R31,HIGH(_0x88*2)
	CALL __INITLOCB
;	date -> Y+86
;	time -> Y+82
;	hours_to_gm -> Y+78
;	*seconds -> Y+76
;	daysmonth -> Y+24
;	year -> Y+20
;	month -> Y+16
;	day -> Y+12
;	hours -> Y+8
;	minutes -> Y+4
;	leap -> Y+0
	CALL SUBOPT_0x3D
	CALL __DIVD21U
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x31
	__GETD2SX 86
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x33
	CALL SUBOPT_0x40
	CALL __DIVD21U
	CALL SUBOPT_0x36
	CALL SUBOPT_0x40
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x37
	CALL SUBOPT_0x2C
	BRNE _0x81
	CALL SUBOPT_0x2D
	BRNE _0x82
	CALL SUBOPT_0x25
	BRNE _0x81
_0x82:
	RJMP _0x84
_0x81:
	RJMP _0x85
_0x84:
	CALL SUBOPT_0x26
	RJMP _0x86
_0x85:
	CALL SUBOPT_0x1C
_0x86:
	CALL SUBOPT_0x27
	__GETD2SX 82
	CALL SUBOPT_0x3F
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x3C
	__GETD2N 0x3C
	CALL __MULD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD1SX 78
	CALL SUBOPT_0x41
	CALL __ADDD21
	CALL SUBOPT_0x35
	CALL __MULD12U
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	__GETD2N 0x18
	CALL __MULD12
	CALL SUBOPT_0x1F
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	CALL SUBOPT_0x44
	CALL __PUTDP1
;
;   // month
;   daysmonth[2] = (leap)? 29 : 28;
	CALL SUBOPT_0x2E
	BREQ _0x89
	__GETD1N 0x1D
	RJMP _0x8A
_0x89:
	__GETD1N 0x1C
_0x8A:
	__PUTD1S 32
;   for ( month = month-1; month > 0; --month)
	CALL SUBOPT_0x30
	CALL SUBOPT_0x43
	CALL SUBOPT_0x31
_0x8D:
	CALL SUBOPT_0x45
	CALL __CPD02
	BRGE _0x8E
;   {
;       *seconds += daysmonth[month] * 24 * 3600;
	CALL SUBOPT_0x44
	PUSH R27
	PUSH R26
	CALL __GETD1P
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	MOVW R26,R28
	ADIW R26,24
	CALL SUBOPT_0x2F
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	POP  R26
	POP  R27
	CALL __PUTDP1
;   }
	CALL SUBOPT_0x30
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL SUBOPT_0x31
	RJMP _0x8D
_0x8E:
;
;   // year
;   for (year = year-1; year >= 1970; --year)
	CALL SUBOPT_0x21
	CALL SUBOPT_0x43
	CALL SUBOPT_0x2A
_0x90:
	CALL SUBOPT_0x23
	__CPD2N 0x7B2
	BRLT _0x91
;   {
;       leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
	CALL SUBOPT_0x2C
	BRNE _0x92
	CALL SUBOPT_0x2D
	BRNE _0x93
	CALL SUBOPT_0x25
	BRNE _0x92
_0x93:
	RJMP _0x95
_0x92:
	RJMP _0x96
_0x95:
	CALL SUBOPT_0x26
	RJMP _0x97
_0x96:
	CALL SUBOPT_0x1C
_0x97:
	CALL SUBOPT_0x27
;       *seconds += (365 + leap) * 24 * 3600;
	CALL SUBOPT_0x44
	PUSH R27
	PUSH R26
	CALL __GETD1P
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x28
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	POP  R26
	POP  R27
	CALL __PUTDP1
;   }
	CALL SUBOPT_0x21
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL SUBOPT_0x2A
	RJMP _0x90
_0x91:
;
;}
	ADIW R28,63
	ADIW R28,27
	RET
; .FEND
;
;
;#include "usart_init.c"
;
;void usartc0_init(void)
; 0000 0013 {
_usartc0_init:
; .FSTART _usartc0_init
;PORTC.OUTSET=0x08;
	LDI  R30,LOW(8)
	STS  1605,R30
;
;// Communication mode: Asynchronous USART
;// Data bits: 8
;// Stop bits: 1
;// Parity: Disabled
;USARTC0.CTRLC=USART_CMODE_ASYNCHRONOUS_gc | USART_PMODE_DISABLED_gc | USART_CHSIZE_8BIT_gc;
	LDI  R30,LOW(3)
	STS  2213,R30
;
;// Receive complete interrupt: High Level
;// Transmit complete interrupt: Disabled
;// Data register empty interrupt: Disabled
;USARTC0.CTRLA=(USARTC0.CTRLA & (~(USART_RXCINTLVL_gm | USART_TXCINTLVL_gm | USART_DREINTLVL_gm))) |
;    USART_RXCINTLVL_HI_gc | USART_TXCINTLVL_OFF_gc | USART_DREINTLVL_OFF_gc;
	LDS  R30,2211
	ANDI R30,LOW(0xC0)
	ORI  R30,LOW(0x30)
	STS  2211,R30
;
;// Required Baud rate: 9600
;// Real Baud Rate: 9601,0 (x1 Mode), Error: 0,0 %
;USARTC0.BAUDCTRLA=0xF5;
	LDI  R30,LOW(245)
	STS  2214,R30
;USARTC0.BAUDCTRLB=((0x0C << USART_BSCALE_bp) & USART_BSCALE_gm) | 0x0C;
	LDI  R30,LOW(204)
	STS  2215,R30
;
;// Receiver: On
;// Transmitter: On
;// Double transmission speed mode: Off
;// Multi-processor communication mode: Off
;USARTC0.CTRLB=(USARTC0.CTRLB & (~(USART_RXEN_bm | USART_TXEN_bm | USART_CLK2X_bm | USART_MPCM_bm | USART_TXB8_bm))) |
;    USART_RXEN_bm | USART_TXEN_bm;
	LDS  R30,2212
	ANDI R30,LOW(0xE0)
	ORI  R30,LOW(0x18)
	STS  2212,R30
;}
	RET
; .FEND
;
;
;
;
;interrupt [USARTC0_RXC_vect] void usartc0_rx_isr(void)
;{
_usartc0_rx_isr:
; .FSTART _usartc0_rx_isr
	CALL SUBOPT_0x46
;
;status=USARTC0.STATUS;
	LDS  R30,2209
	STS  _status,R30
;data=USARTC0.DATA;
	LDS  R30,2208
	STS  _data,R30
;
;if ((status & (USART_FERR_bm | USART_PERR_bm | USART_BUFOVF_bm)) == 0)
	LDS  R30,_status
	ANDI R30,LOW(0x1C)
	BRNE _0x99
;   {
;rx_buffer_usartc0[rx_wr_index_usartc0]=data;
	MOV  R30,R10
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_usartc0)
	SBCI R31,HIGH(-_rx_buffer_usartc0)
	LDS  R26,_data
	STD  Z+0,R26
;rx_wr_index_usartc0++;
	INC  R10
;   }
;
;
;switch(Mx)
_0x99:
	LDS  R30,_Mx
	LDI  R31,0
;{
;case 0xFF:
	CPI  R30,LOW(0xFF)
	LDI  R26,HIGH(0xFF)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x9D
;{
;    //поиск маркера
;    //////////////////////////////////////////////
;    switch (rx_buffer_usartc0[0])
	LDS  R30,_rx_buffer_usartc0
	LDI  R31,0
;    {
;    ///////////////////////////////////////
;    case 0xFF:
	CPI  R30,LOW(0xFF)
	LDI  R26,HIGH(0xFF)
	CPC  R31,R26
	BRNE _0xA1
;    {
;    Mx=0xFF;
	CALL SUBOPT_0x47
;    RX_BUFFER_SIZE_USARTC0=1;
;    rx_buffer_usartc0[0]=0xFF;
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////
;    case 0xCA:
_0xA1:
	CPI  R30,LOW(0xCA)
	LDI  R26,HIGH(0xCA)
	CPC  R31,R26
	BRNE _0xA2
;    {
;    Mx=0xCA;
	LDI  R30,LOW(202)
	CALL SUBOPT_0x48
;    RX_BUFFER_SIZE_USARTC0=2;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////
;    case 0xF5:
_0xA2:
	CPI  R30,LOW(0xF5)
	LDI  R26,HIGH(0xF5)
	CPC  R31,R26
	BRNE _0xA3
;    {
;    Mx=0xF5;
	LDI  R30,LOW(245)
	CALL SUBOPT_0x48
;    RX_BUFFER_SIZE_USARTC0=2;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////
;
;    case 0xB5:
_0xA3:
	CPI  R30,LOW(0xB5)
	LDI  R26,HIGH(0xB5)
	CPC  R31,R26
	BRNE _0xA4
;    {
;    Mx=0xB5;
	LDI  R30,LOW(181)
	CALL SUBOPT_0x49
;    RX_BUFFER_SIZE_USARTC0=4;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////
;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    case 0xEA:
_0xA4:
	CPI  R30,LOW(0xEA)
	LDI  R26,HIGH(0xEA)
	CPC  R31,R26
	BRNE _0xA5
;    {
;    Mx=0xEA;
	LDI  R30,LOW(234)
	CALL SUBOPT_0x48
;    RX_BUFFER_SIZE_USARTC0=2;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    case 0xE5:
_0xA5:
	CPI  R30,LOW(0xE5)
	LDI  R26,HIGH(0xE5)
	CPC  R31,R26
	BRNE _0xA6
;    {
;    Mx=0xE5;
	LDI  R30,LOW(229)
	CALL SUBOPT_0x4A
;    RX_BUFFER_SIZE_USARTC0=7;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    case 0xE7:
_0xA6:
	CPI  R30,LOW(0xE7)
	LDI  R26,HIGH(0xE7)
	CPC  R31,R26
	BRNE _0xA7
;    {
;    Mx=0xE7;
	LDI  R30,LOW(231)
	CALL SUBOPT_0x4A
;    RX_BUFFER_SIZE_USARTC0=7;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;
;
;    case 0x60:
_0xA7:
	CPI  R30,LOW(0x60)
	LDI  R26,HIGH(0x60)
	CPC  R31,R26
	BRNE _0xA8
;    {
;    Mx=0x60;
	LDI  R30,LOW(96)
	CALL SUBOPT_0x48
;    RX_BUFFER_SIZE_USARTC0=2;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    case 0xE8:
_0xA8:
	CPI  R30,LOW(0xE8)
	LDI  R26,HIGH(0xE8)
	CPC  R31,R26
	BRNE _0xA9
;    {
;    Mx=0xE8;
	LDI  R30,LOW(232)
	CALL SUBOPT_0x4B
;    RX_BUFFER_SIZE_USARTC0=3;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    ///////////////////////////////////////   ///////////////////////////////////////
;
;    case 0xE9:
_0xA9:
	CPI  R30,LOW(0xE9)
	LDI  R26,HIGH(0xE9)
	CPC  R31,R26
	BRNE _0xAA
;    {
;    Mx=0xE9;
	LDI  R30,LOW(233)
	CALL SUBOPT_0x4B
;    RX_BUFFER_SIZE_USARTC0=3;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    ///////////////////////////////////////   ///////////////////////////////////////
;    ///////////////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ...
;    /////////////////////дата ///////////////////////////////////////
;    case 0xD1:
_0xAA:
	CPI  R30,LOW(0xD1)
	LDI  R26,HIGH(0xD1)
	CPC  R31,R26
	BRNE _0xAB
;    {
;    Mx=0xD1;
	LDI  R30,LOW(209)
	STS  _Mx,R30
;    RX_BUFFER_SIZE_USARTC0=5;
	LDI  R30,LOW(5)
	MOV  R11,R30
;    rx_buffer_usartc0[0]=0xFF;
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    //////////////////////время///////////////////////////////////////
;    case 0xD3:
_0xAB:
	CPI  R30,LOW(0xD3)
	LDI  R26,HIGH(0xD3)
	CPC  R31,R26
	BRNE _0xAC
;    {
;    Mx=0xD3;
	LDI  R30,LOW(211)
	CALL SUBOPT_0x49
;    RX_BUFFER_SIZE_USARTC0=4;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;    //////////////////////////////////////////////////////////////////////////////
;     /////////////////////дата ///////////////////////////////////////
;    case 0xD5:
_0xAC:
	CPI  R30,LOW(0xD5)
	LDI  R26,HIGH(0xD5)
	CPC  R31,R26
	BRNE _0xAD
;    {
;    Mx=0xD5;
	LDI  R30,LOW(213)
	CALL SUBOPT_0x4C
;    rx_buffer_usartc0[0]=0xFF;
;    RX_BUFFER_SIZE_USARTC0=1;
	RJMP _0x222
;    rx_wr_index_usartc0=0;
;
;
;    }
;    break;
;
;    case 0xD7:
_0xAD:
	CPI  R30,LOW(0xD7)
	LDI  R26,HIGH(0xD7)
	CPC  R31,R26
	BRNE _0xAE
;    {
;    Mx=0xD7;
	LDI  R30,LOW(215)
	CALL SUBOPT_0x4C
;    rx_buffer_usartc0[0]=0xFF;
;    RX_BUFFER_SIZE_USARTC0=1;
	RJMP _0x222
;    rx_wr_index_usartc0=0;
;
;    }
;    break;
;
;    //////////////////////время///////////////////////////////////////
;    /*
;    case 0xA0:
;    {
;    //Mx=0xA0;
;    //RX_BUFFER_SIZE_USARTC0=1;
;    rx_buffer_usartc0[0]=0xFF;
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A0);
;    for(ch=1,A0[l-1]=0;ch<l-1;ch++) A0[l-1]=A0[l-1]+A0[ch];
;    //высылаем пачку
;    for (ch=0;ch<l;ch++) putchar(A0[ch]);
;    l=0;
;    Mx=0xFF;
;    rx_wr_index_usartc0=0;
;    }
;    break;
;    */
;
;
;
;
;
;
;
;
;
;
;
;    ///////////////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ...
;    //////////////////////////////запросы данных//////////////////////////////запросы данных
;    case 0xA0:
_0xAE:
	CPI  R30,LOW(0xA0)
	LDI  R26,HIGH(0xA0)
	CPC  R31,R26
	BRNE _0xAF
;    {
;    //Mx=0xA0;
;    //RX_BUFFER_SIZE_USARTC0=1;
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A0);
	CALL SUBOPT_0x1
;    for(ch=1,A0[l-1]=0;ch<l-1;ch++) A0[l-1]=A0[l-1]+A0[ch];
	SUBI R30,LOW(-_A0)
	SBCI R31,HIGH(-_A0)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xB1:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xB2
	CALL SUBOPT_0x2
	CALL SUBOPT_0x4
	CALL SUBOPT_0x5
	RJMP _0xB1
_0xB2:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xB4:
	CALL SUBOPT_0x4E
	BRSH _0xB5
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A0)
	SBCI R31,HIGH(-_A0)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xB4
_0xB5:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    rx_wr_index_usartc0=0;
	RJMP _0x221
;    }
;    break;
;
;    case 0xA1:
_0xAF:
	CPI  R30,LOW(0xA1)
	LDI  R26,HIGH(0xA1)
	CPC  R31,R26
	BRNE _0xB6
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A1);
	CALL SUBOPT_0xD
;    for(ch=1,A1[l-1]=0;ch<l-1;ch++) A1[l-1]=A1[l-1]+A1[ch];
	SUBI R30,LOW(-_A1)
	SBCI R31,HIGH(-_A1)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xB8:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xB9
	CALL SUBOPT_0x2
	CALL SUBOPT_0xE
	CALL SUBOPT_0x5
	RJMP _0xB8
_0xB9:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xBB:
	CALL SUBOPT_0x4E
	BRSH _0xBC
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A1)
	SBCI R31,HIGH(-_A1)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xBB
_0xBC:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xA2:
_0xB6:
	CPI  R30,LOW(0xA2)
	LDI  R26,HIGH(0xA2)
	CPC  R31,R26
	BRNE _0xBD
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A2);
	CALL SUBOPT_0x8
;    for(ch=1,A2[l-1]=0;ch<l-1;ch++) A2[l-1]=A2[l-1]+A2[ch];
	SUBI R30,LOW(-_A2)
	SBCI R31,HIGH(-_A2)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xBF:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xC0
	CALL SUBOPT_0x2
	CALL SUBOPT_0xA
	CALL SUBOPT_0x5
	RJMP _0xBF
_0xC0:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xC2:
	CALL SUBOPT_0x4E
	BRSH _0xC3
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A2)
	SBCI R31,HIGH(-_A2)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xC2
_0xC3:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xA4:
_0xBD:
	CPI  R30,LOW(0xA4)
	LDI  R26,HIGH(0xA4)
	CPC  R31,R26
	BRNE _0xC4
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A4);
	CALL SUBOPT_0x1
;    for(ch=1,A4[l-1]=0;ch<l-1;ch++) A4[l-1]=A4[l-1]+A4[ch];
	SUBI R30,LOW(-_A4)
	SBCI R31,HIGH(-_A4)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xC6:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xC7
	CALL SUBOPT_0x2
	CALL SUBOPT_0x16
	CALL SUBOPT_0x5
	RJMP _0xC6
_0xC7:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xC9:
	CALL SUBOPT_0x4E
	BRSH _0xCA
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A4)
	SBCI R31,HIGH(-_A4)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xC9
_0xCA:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xA6:
_0xC4:
	CPI  R30,LOW(0xA6)
	LDI  R26,HIGH(0xA6)
	CPC  R31,R26
	BRNE _0xCB
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A6);
	CALL SUBOPT_0x1
;    for(ch=1,A6[l-1]=0;ch<l-1;ch++) A6[l-1]=A6[l-1]+A6[ch];
	SUBI R30,LOW(-_A6)
	SBCI R31,HIGH(-_A6)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xCD:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xCE
	CALL SUBOPT_0x2
	CALL SUBOPT_0xC
	CALL SUBOPT_0x5
	RJMP _0xCD
_0xCE:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xD0:
	CALL SUBOPT_0x4E
	BRSH _0xD1
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A6)
	SBCI R31,HIGH(-_A6)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xD0
_0xD1:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xA7:
_0xCB:
	CPI  R30,LOW(0xA7)
	LDI  R26,HIGH(0xA7)
	CPC  R31,R26
	BRNE _0xD2
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(A7);
	CALL SUBOPT_0xF
;    for(ch=1,A7[l-1]=0;ch<l-1;ch++) A7[l-1]=A7[l-1]+A7[ch];
	SUBI R30,LOW(-_A7)
	SBCI R31,HIGH(-_A7)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xD4:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xD5
	CALL SUBOPT_0x2
	CALL SUBOPT_0x10
	CALL SUBOPT_0x5
	RJMP _0xD4
_0xD5:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xD7:
	CALL SUBOPT_0x4E
	BRSH _0xD8
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A7)
	SBCI R31,HIGH(-_A7)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xD7
_0xD8:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xAA:
_0xD2:
	CPI  R30,LOW(0xAA)
	LDI  R26,HIGH(0xAA)
	CPC  R31,R26
	BRNE _0xD9
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(AA);
	CALL SUBOPT_0x8
;    for(ch=1,AA[l-1]=0;ch<l-1;ch++) AA[l-1]=AA[l-1]+AA[ch];
	SUBI R30,LOW(-_AA)
	SBCI R31,HIGH(-_AA)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xDB:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xDC
	CALL SUBOPT_0x2
	CALL SUBOPT_0x9
	CALL SUBOPT_0x5
	RJMP _0xDB
_0xDC:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xDE:
	CALL SUBOPT_0x4E
	BRSH _0xDF
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AA)
	SBCI R31,HIGH(-_AA)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xDE
_0xDF:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;
;    case 0xAB:
_0xD9:
	CPI  R30,LOW(0xAB)
	LDI  R26,HIGH(0xAB)
	CPC  R31,R26
	BRNE _0xE0
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(AB);
	CALL SUBOPT_0x12
;    for(ch=1,AB[l-1]=0;ch<l-1;ch++) AB[l-1]=AB[l-1]+AB[ch];
	SUBI R30,LOW(-_AB)
	SBCI R31,HIGH(-_AB)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xE2:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xE3
	CALL SUBOPT_0x2
	CALL SUBOPT_0x13
	CALL SUBOPT_0x5
	RJMP _0xE2
_0xE3:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xE5:
	CALL SUBOPT_0x4E
	BRSH _0xE6
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AB)
	SBCI R31,HIGH(-_AB)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xE5
_0xE6:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xAD:
_0xE0:
	CPI  R30,LOW(0xAD)
	LDI  R26,HIGH(0xAD)
	CPC  R31,R26
	BRNE _0xE7
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(AD);
	CALL SUBOPT_0x1
;    for(ch=1,AD[l-1]=0;ch<l-1;ch++) AD[l-1]=AD[l-1]+AD[ch];
	SUBI R30,LOW(-_AD)
	SBCI R31,HIGH(-_AD)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xE9:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xEA
	CALL SUBOPT_0x2
	CALL SUBOPT_0xB
	CALL SUBOPT_0x5
	RJMP _0xE9
_0xEA:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xEC:
	CALL SUBOPT_0x4E
	BRSH _0xED
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AD)
	SBCI R31,HIGH(-_AD)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xEC
_0xED:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;
;    case 0xAE:
_0xE7:
	CPI  R30,LOW(0xAE)
	LDI  R26,HIGH(0xAE)
	CPC  R31,R26
	BRNE _0xEE
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(AE);
	CALL SUBOPT_0x14
;    for(ch=1,AE[l-1]=0;ch<l-1;ch++) AE[l-1]=AE[l-1]+AE[ch];
	SUBI R30,LOW(-_AE)
	SBCI R31,HIGH(-_AE)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xF0:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xF1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x15
	CALL SUBOPT_0x5
	RJMP _0xF0
_0xF1:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xF3:
	CALL SUBOPT_0x4E
	BRSH _0xF4
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AE)
	SBCI R31,HIGH(-_AE)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xF3
_0xF4:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0xAF:
_0xEE:
	CPI  R30,LOW(0xAF)
	LDI  R26,HIGH(0xAF)
	CPC  R31,R26
	BRNE _0xF5
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(AF);
	CALL SUBOPT_0x6
;    for(ch=1,AF[l-1]=0;ch<l-1;ch++) AF[l-1]=AF[l-1]+AF[ch];
	SUBI R30,LOW(-_AF)
	SBCI R31,HIGH(-_AF)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xF7:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xF8
	CALL SUBOPT_0x2
	CALL SUBOPT_0x7
	CALL SUBOPT_0x5
	RJMP _0xF7
_0xF8:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0xFA:
	CALL SUBOPT_0x4E
	BRSH _0xFB
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AF)
	SBCI R31,HIGH(-_AF)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0xFA
_0xFB:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;
;    case 0x58:
_0xF5:
	CPI  R30,LOW(0x58)
	LDI  R26,HIGH(0x58)
	CPC  R31,R26
	BRNE _0xFC
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(p58);
	CALL SUBOPT_0x1
;    for(ch=1,p58[l-1]=0;ch<l-1;ch++) p58[l-1]=p58[l-1]+p58[ch];
	SUBI R30,LOW(-_p58)
	SBCI R31,HIGH(-_p58)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0xFE:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0xFF
	CALL SUBOPT_0x2
	CALL SUBOPT_0x17
	CALL SUBOPT_0x5
	RJMP _0xFE
_0xFF:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x101:
	CALL SUBOPT_0x4E
	BRSH _0x102
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p58)
	SBCI R31,HIGH(-_p58)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x101
_0x102:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0x6A:
_0xFC:
	CPI  R30,LOW(0x6A)
	LDI  R26,HIGH(0x6A)
	CPC  R31,R26
	BRNE _0x103
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(p6A);
	CALL SUBOPT_0x1
;    for(ch=1,p6A[l-1]=0;ch<l-1;ch++) p6A[l-1]=p6A[l-1]+p6A[ch];
	SUBI R30,LOW(-_p6A)
	SBCI R31,HIGH(-_p6A)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x105:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x106
	CALL SUBOPT_0x2
	CALL SUBOPT_0x19
	CALL SUBOPT_0x5
	RJMP _0x105
_0x106:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x108:
	CALL SUBOPT_0x4E
	BRSH _0x109
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p6A)
	SBCI R31,HIGH(-_p6A)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x108
_0x109:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;
;    case 0x76:
_0x103:
	CPI  R30,LOW(0x76)
	LDI  R26,HIGH(0x76)
	CPC  R31,R26
	BRNE _0x10A
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(p76);
	CALL SUBOPT_0x8
;    for(ch=1,p76[l-1]=0;ch<l-1;ch++) p76[l-1]=p76[l-1]+p76[ch];
	SUBI R30,LOW(-_p76)
	SBCI R31,HIGH(-_p76)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x10C:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x10D
	CALL SUBOPT_0x2
	CALL SUBOPT_0x18
	CALL SUBOPT_0x5
	RJMP _0x10C
_0x10D:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x10F:
	CALL SUBOPT_0x4E
	BRSH _0x110
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p76)
	SBCI R31,HIGH(-_p76)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x10F
_0x110:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    case 0x77:
_0x10A:
	CPI  R30,LOW(0x77)
	LDI  R26,HIGH(0x77)
	CPC  R31,R26
	BRNE _0x118
;    {
;    rx_buffer_usartc0[0]=0xFF;
	CALL SUBOPT_0x4D
;    rx_wr_index_usartc0=0;
;    //тут же ответ
;    l=sizeof(p77);
	CALL SUBOPT_0x8
;    for(ch=1,p77[l-1]=0;ch<l-1;ch++) p77[l-1]=p77[l-1]+p77[ch];
	SUBI R30,LOW(-_p77)
	SBCI R31,HIGH(-_p77)
	LDI  R26,LOW(0)
	STD  Z+0,R26
_0x113:
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	BRGE _0x114
	CALL SUBOPT_0x2
	CALL SUBOPT_0x11
	CALL SUBOPT_0x5
	RJMP _0x113
_0x114:
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x116:
	CALL SUBOPT_0x4E
	BRSH _0x117
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p77)
	SBCI R31,HIGH(-_p77)
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x116
_0x117:
	CALL SUBOPT_0x4F
;    Mx=0xFF;
;    }
;    break;
	RJMP _0xA0
;
;    //////////////////////////////запросы данных//////////////////////////////запросы данных
;
;    default :
_0x118:
;    {
;    rx_buffer_usartc0[0]=0xFF;
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
;    Mx=0xFF;
	STS  _Mx,R30
;    RX_BUFFER_SIZE_USARTC0=1;
_0x222:
	LDI  R30,LOW(1)
	MOV  R11,R30
;    rx_wr_index_usartc0=0;
_0x221:
	CLR  R10
;    }
;
;
;
;}//switch buf
_0xA0:
;//////////////////////////////////////////////////////////////////////////////
;
;
;
;}//end case ff
;//break; //mx=ff
;
;
;///////////////////////////////////////////////////CACACACCAACACACACACACACACACACACACACACACACAC
;case 0xCA:
	RJMP _0x119
_0x9D:
	CPI  R30,LOW(0xCA)
	LDI  R26,HIGH(0xCA)
	CPC  R31,R26
	BRNE _0x11A
_0x119:
; {
; //проверка по длинне
; if(rx_wr_index_usartc0==2)
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x11B
; //проверка по содержанию пакета
; {
; if(rx_buffer_usartc0[0]==0x01&&rx_buffer_usartc0[1]==0x01) {putchar(0xCA);putchar(0xCA);Mx=0xFF;RX_BUFFER_SIZE_USARTC0= ...
	LDS  R26,_rx_buffer_usartc0
	CPI  R26,LOW(0x1)
	BRNE _0x11D
	__GETB2MN _rx_buffer_usartc0,1
	CPI  R26,LOW(0x1)
	BREQ _0x11E
_0x11D:
	RJMP _0x11C
_0x11E:
	CALL SUBOPT_0x50
	RJMP _0x223
; else if(rx_buffer_usartc0[0]==0x0F&&rx_buffer_usartc0[1]==0x0F) {putchar(0xCA);putchar(0xCA);Mx=0xFF;RX_BUFFER_SIZE_USA ...
_0x11C:
	LDS  R26,_rx_buffer_usartc0
	CPI  R26,LOW(0xF)
	BRNE _0x121
	__GETB2MN _rx_buffer_usartc0,1
	CPI  R26,LOW(0xF)
	BREQ _0x122
_0x121:
	RJMP _0x120
_0x122:
	CALL SUBOPT_0x50
	CALL SUBOPT_0x47
;                                                                    send=1;
	LDI  R30,LOW(1)
	STS  _send,R30
;                                                                    rx_wr_index_usartc0=0;}
	RJMP _0x224
; else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
_0x120:
_0x223:
	LDI  R30,LOW(255)
	STS  _Mx,R30
	LDI  R30,LOW(1)
	MOV  R11,R30
_0x224:
	CLR  R10
; }
;
;
; }
_0x11B:
;break;
	RJMP _0x9C
;/////////////////////////////////////////////////////////////////////////сброс
;case 0xF5:
_0x11A:
	CPI  R30,LOW(0xF5)
	LDI  R26,HIGH(0xF5)
	CPC  R31,R26
	BRNE _0x124
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==2)
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x125
; //содержание
;                if(rx_buffer_usartc0[0]==0x5F&&rx_buffer_usartc0[1]==0x5F)
	LDS  R26,_rx_buffer_usartc0
	CPI  R26,LOW(0x5F)
	BRNE _0x127
	__GETB2MN _rx_buffer_usartc0,1
	CPI  R26,LOW(0x5F)
	BREQ _0x128
_0x127:
	RJMP _0x126
_0x128:
;                {
;                putchar(0xF5);
	LDI  R26,LOW(245)
	RCALL _putchar
;                putchar(0xF5);
	LDI  R26,LOW(245)
	RCALL _putchar
;                putchar(0xF5);
	LDI  R26,LOW(245)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CLR  R10
;                delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
;                CCP = CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
;                RST.CTRL=RST_SWRST_bm;
	LDI  R30,LOW(1)
	STS  121,R30
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x129
_0x126:
	CALL SUBOPT_0x47
	CLR  R10
_0x129:
;
;}
_0x125:
;break;
	RJMP _0x9C
;///////////////////////////////////////////////////////////ответ данные%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ...
;case 0xB5:
_0x124:
	CPI  R30,LOW(0xB5)
	LDI  R26,HIGH(0xB5)
	CPC  R31,R26
	BRNE _0x12A
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==4)
	LDI  R30,LOW(4)
	CP   R30,R10
	BRNE _0x12B
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<3;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];B5buf[ch]=rx_buffer_usartc0[ch ...
	CALL SUBOPT_0x52
_0x12D:
	LDS  R26,_ch
	CPI  R26,LOW(0x3)
	BRSH _0x12E
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	LDS  R26,_ch
	LDI  R27,0
	SUBI R26,LOW(-_B5buf)
	SBCI R27,HIGH(-_B5buf)
	CALL SUBOPT_0x53
	ST   X,R30
	CALL SUBOPT_0x5
	RJMP _0x12D
_0x12E:
;
;                B5buf[3]=rx_buffer_usartc0[3];
	__GETB1MN _rx_buffer_usartc0,3
	__PUTB1MN _B5buf,3
;
;                if(rx_buffer_usartc0[3]==check_sum)
	__GETB2MN _rx_buffer_usartc0,3
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x12F
;
;
;
;                {
;
;                                /*
;                //эмуляция вывода кюветы
;                if( (rx_buffer_usartc0[0]&0b00001000)==0b00000000)
;                {
;                //S0[21]=S0[21]|0b00001000;
;                //S0[21]=S0[21]&0b11111011;
;                //увеличение значения усилителя
;                //S0[7]=0x00;// Сигнал  усилителя
;                //S0[8]=0xFF; //Сигнал  усилителя
;                }
;                else
;                if( (rx_buffer_usartc0[0]&0b00001000)==0b00001000)
;                {
;                //S0[21]=S0[21]|0b00000100;
;                //S0[21]=S0[21]&0b11110111;
;                //сигнал усилителя
;                //S0[7]=0xC0;
;                //S0[8]=0x0A;
;
;                }
;                //клапан
;                if( (rx_buffer_usartc0[0]&0b00000100)==0b00000100)
;                {
;                //S0[21]=S0[21]|0b00001000;
;                //давление
;                //S0[15]=0x04;// давление
;                //S0[16]=0x0C;//
;
;                //S0[15]=0xAC;// давление
;                //S0[16]=0x26;//
;                }
;
;
;                if( (rx_buffer_usartc0[0]&0b00000100)==0b00000000)
;                {
;                //S0[21]=S0[21]|0b00001000;
;                //давление
;                ///S0[15]=0xC0;//
;                //S0[16]=0x0C;//
;
;                //S0[15]=0x10;// давление
;                //S0[16]=0x27;//
;                }
;                */
;                B5upr=rx_buffer_usartc0[0];
	LDS  R30,_rx_buffer_usartc0
	STS  _B5upr,R30
;                putchar(0xB5);
	LDI  R26,LOW(181)
	RCALL _putchar
;                putchar(0xB5);
	LDI  R26,LOW(181)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x130
_0x12F:
	CALL SUBOPT_0x47
	CLR  R10
_0x130:
;   }
;}
_0x12B:
;break;
	RJMP _0x9C
;
;
;
;case 0xEA:
_0x12A:
	CPI  R30,LOW(0xEA)
	LDI  R26,HIGH(0xEA)
	CPC  R31,R26
	BRNE _0x131
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==2)
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x132
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<1;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x134:
	LDS  R26,_ch
	CPI  R26,LOW(0x1)
	BRSH _0x135
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x134
_0x135:
;
;                if(rx_buffer_usartc0[1]==check_sum)
	__GETB2MN _rx_buffer_usartc0,1
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x136
;
;                {
;                putchar(0xEA);
	LDI  R26,LOW(234)
	RCALL _putchar
;                putchar(0xEA);
	LDI  R26,LOW(234)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x137
_0x136:
	CALL SUBOPT_0x47
	CLR  R10
_0x137:
;   }
;}
_0x132:
;break;
	RJMP _0x9C
;
;case 0x60:
_0x131:
	CPI  R30,LOW(0x60)
	LDI  R26,HIGH(0x60)
	CPC  R31,R26
	BRNE _0x138
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==2)
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x139
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<1;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x13B:
	LDS  R26,_ch
	CPI  R26,LOW(0x1)
	BRSH _0x13C
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x13B
_0x13C:
;
;                if(rx_buffer_usartc0[1]==check_sum)
	__GETB2MN _rx_buffer_usartc0,1
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x13D
;
;                {
;                putchar(0x60);
	LDI  R26,LOW(96)
	RCALL _putchar
;                putchar(0x00);
	LDI  R26,LOW(0)
	RCALL _putchar
;                putchar(0x00);
	LDI  R26,LOW(0)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x13E
_0x13D:
	CALL SUBOPT_0x47
	CLR  R10
_0x13E:
;   }
;}
_0x139:
;break;
	RJMP _0x9C
;
;
;case 0xE5:
_0x138:
	CPI  R30,LOW(0xE5)
	LDI  R26,HIGH(0xE5)
	CPC  R31,R26
	BRNE _0x13F
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==7)
	LDI  R30,LOW(7)
	CP   R30,R10
	BRNE _0x140
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<6;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x142:
	LDS  R26,_ch
	CPI  R26,LOW(0x6)
	BRSH _0x143
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x142
_0x143:
;
;                if(rx_buffer_usartc0[6]==check_sum)
	__GETB2MN _rx_buffer_usartc0,6
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x144
;
;                {
;                putchar(0xE5);
	LDI  R26,LOW(229)
	RCALL _putchar
;                putchar(0xE5);
	LDI  R26,LOW(229)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x145
_0x144:
	CALL SUBOPT_0x47
	CLR  R10
_0x145:
;   }
;}
_0x140:
;break;
	RJMP _0x9C
;
;
;case 0xE7:
_0x13F:
	CPI  R30,LOW(0xE7)
	LDI  R26,HIGH(0xE7)
	CPC  R31,R26
	BRNE _0x146
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==7)
	LDI  R30,LOW(7)
	CP   R30,R10
	BRNE _0x147
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<6;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x149:
	LDS  R26,_ch
	CPI  R26,LOW(0x6)
	BRSH _0x14A
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x149
_0x14A:
;
;                if(rx_buffer_usartc0[6]==check_sum)
	__GETB2MN _rx_buffer_usartc0,6
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x14B
;
;                {
;                putchar(0xE7);
	LDI  R26,LOW(231)
	RCALL _putchar
;                putchar(0xE7);
	LDI  R26,LOW(231)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x14C
_0x14B:
	CALL SUBOPT_0x47
	CLR  R10
_0x14C:
;   }
;}
_0x147:
;break;
	RJMP _0x9C
;
;
;
;
;case 0xE8:
_0x146:
	CPI  R30,LOW(0xE8)
	LDI  R26,HIGH(0xE8)
	CPC  R31,R26
	BRNE _0x14D
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==3)
	LDI  R30,LOW(3)
	CP   R30,R10
	BRNE _0x14E
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<2;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x150:
	LDS  R26,_ch
	CPI  R26,LOW(0x2)
	BRSH _0x151
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x150
_0x151:
;
;                if(rx_buffer_usartc0[2]==check_sum)
	__GETB2MN _rx_buffer_usartc0,2
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x152
;
;                {
;                putchar(0xE8);
	LDI  R26,LOW(232)
	RCALL _putchar
;                putchar(0xE8);
	LDI  R26,LOW(232)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x153
_0x152:
	CALL SUBOPT_0x47
	CLR  R10
_0x153:
;   }
;}
_0x14E:
;break;
	RJMP _0x9C
;
;
;case 0xE9:
_0x14D:
	CPI  R30,LOW(0xE9)
	LDI  R26,HIGH(0xE9)
	CPC  R31,R26
	BRNE _0x154
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==3)
	LDI  R30,LOW(3)
	CP   R30,R10
	BRNE _0x155
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<2;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x157:
	LDS  R26,_ch
	CPI  R26,LOW(0x2)
	BRSH _0x158
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x157
_0x158:
;
;                if(rx_buffer_usartc0[2]==check_sum)
	__GETB2MN _rx_buffer_usartc0,2
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x159
;
;                {
;                putchar(0xE9);
	LDI  R26,LOW(233)
	RCALL _putchar
;                putchar(0xE9);
	LDI  R26,LOW(233)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x15A
_0x159:
	CALL SUBOPT_0x47
	CLR  R10
_0x15A:
;   }
;}
_0x155:
;break;
	RJMP _0x9C
;
;
;case 0xD1:
_0x154:
	CPI  R30,LOW(0xD1)
	LDI  R26,HIGH(0xD1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x15B
;{
;
;//проверка по длинне
; if(rx_wr_index_usartc0==5)
	LDI  R30,LOW(5)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x15C
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<4;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x15E:
	LDS  R26,_ch
	CPI  R26,LOW(0x4)
	BRSH _0x15F
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x15E
_0x15F:
;
;                if(rx_buffer_usartc0[4]==check_sum)
	__GETB2MN _rx_buffer_usartc0,4
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x160
;
;                {
;                //копировать дату
;                rx_buffer_usartc0[4]=NULL;
	LDI  R30,LOW(0)
	__PUTB1MN _rx_buffer_usartc0,4
;                date1=0;
	STS  _date1,R30
	STS  _date1+1,R30
	STS  _date1+2,R30
	STS  _date1+3,R30
;                date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
	CALL SUBOPT_0x56
	CALL SUBOPT_0x57
;                date1=date1*100+rx_buffer_usartc0[2];
	CALL SUBOPT_0x58
	CALL SUBOPT_0x57
;                date1=date1*100+rx_buffer_usartc0[3];
	__GETB1MN _rx_buffer_usartc0,3
	LDI  R31,0
	CALL SUBOPT_0x59
	STS  _date1,R30
	STS  _date1+1,R31
	STS  _date1+2,R22
	STS  _date1+3,R23
;                newdate=1;
	LDI  R30,LOW(1)
	STS  _newdate,R30
;                putchar(0xD1);
	LDI  R26,LOW(209)
	RCALL _putchar
;                putchar(0xD1);
	LDI  R26,LOW(209)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x161
_0x160:
	CALL SUBOPT_0x47
	CLR  R10
_0x161:
;   }
;}
_0x15C:
;break;
	RJMP _0x9C
;
;case 0xD3:
_0x15B:
	CPI  R30,LOW(0xD3)
	LDI  R26,HIGH(0xD3)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x162
;{
;//проверка по длинне
; if(rx_wr_index_usartc0==4)
	LDI  R30,LOW(4)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x163
; {
; //содержание
;
;                for(ch=0,check_sum=0;ch<3;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
	CALL SUBOPT_0x52
_0x165:
	LDS  R26,_ch
	CPI  R26,LOW(0x3)
	BRSH _0x166
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
	CALL SUBOPT_0x5
	RJMP _0x165
_0x166:
;
;                if(rx_buffer_usartc0[3]==check_sum)
	__GETB2MN _rx_buffer_usartc0,3
	LDS  R30,_check_sum
	CP   R30,R26
	BRNE _0x167
;
;                {
;                //установить время
;                //запись даты в переменные
;                rx_buffer_usartc0[3]=NULL;
	LDI  R30,LOW(0)
	__PUTB1MN _rx_buffer_usartc0,3
;                time1=0;
	STS  _time1,R30
	STS  _time1+1,R30
	STS  _time1+2,R30
	STS  _time1+3,R30
;                time1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
	CALL SUBOPT_0x56
	CALL SUBOPT_0x5A
;                time1=time1*100+rx_buffer_usartc0[2];
	CALL SUBOPT_0x5B
	__GETD2N 0x64
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x58
	CALL SUBOPT_0x5A
;                newtime=1;
	LDI  R30,LOW(1)
	STS  _newtime,R30
;                putchar(0xD3);
	LDI  R26,LOW(211)
	RCALL _putchar
;                putchar(0xD3);
	LDI  R26,LOW(211)
	CALL SUBOPT_0x51
;                Mx=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
;                rx_wr_index_usartc0=0;
	CALL SUBOPT_0x55
;                check_sum=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
	RJMP _0x168
_0x167:
	CALL SUBOPT_0x47
	CLR  R10
_0x168:
;   }
;}
_0x163:
;break;
	RJMP _0x9C
;
;case 0xD5:
_0x162:
	CPI  R30,LOW(0xD5)
	LDI  R26,HIGH(0xD5)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x169
;{
;//проверка по длинне
; if(rx_wr_index_usartc0==1)
	LDI  R30,LOW(1)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x16A
; {
;                if(rx_buffer_usartc0[0]==0xD5)
	LDS  R26,_rx_buffer_usartc0
	CPI  R26,LOW(0xD5)
	BREQ PC+2
	RJMP _0x16B
;
;                {
;                //установить время
;                //запись даты в переменные
;                get_CNTRTC(&X);
	CALL SUBOPT_0x5C
;                calcDateTime(X, 0, &date1,&time1);
;                //date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
;                //date1=date1*100+rx_buffer_usartc0[2];
;                //date1=date1*100+rx_buffer_usartc0[3];
;                //CSdt
;                //bufdt
;               // bufdt[0]=time1/10000;
;               // bufdt[1]=(time1-bufdt[0]*10000)/100;
;               // bufdt[2]=(time1-bufdt[0]*10000-bufdt[1]*100);
;
;
;                bufdt[0]=date1/1000000;
	CALL SUBOPT_0x5D
	CALL __DIVD21U
	STS  _bufdt,R30
;                bufdt[1]=date1%1000000/10000;
	CALL SUBOPT_0x5D
	CALL __MODD21U
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x5E
	CALL __DIVD21U
	__PUTB1MN _bufdt,1
;                bufdt[2]=date1%10000/100;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x3E
	__PUTB1MN _bufdt,2
;                bufdt[3]=date1%100;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x3F
	__PUTB1MN _bufdt,3
;
;
;                //тут же ответ
;
;                for(ch=0,bufdt[4]=0;ch<4;ch++) bufdt[4]=bufdt[4]+bufdt[ch];
	LDI  R30,LOW(0)
	STS  _ch,R30
	__PUTB1MN _bufdt,4
_0x16D:
	LDS  R26,_ch
	CPI  R26,LOW(0x4)
	BRSH _0x16E
	__GETB2MN _bufdt,4
	CALL SUBOPT_0x60
	LD   R30,Z
	ADD  R30,R26
	__PUTB1MN _bufdt,4
	CALL SUBOPT_0x5
	RJMP _0x16D
_0x16E:
	LDI  R26,LOW(213)
	RCALL _putchar
;                for (ch=0;ch<5;ch++) putchar(bufdt[ch]);
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x170:
	LDS  R26,_ch
	CPI  R26,LOW(0x5)
	BRSH _0x171
	CALL SUBOPT_0x60
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x170
_0x171:
	LDI  R30,LOW(255)
	CALL SUBOPT_0x4C
;                rx_buffer_usartc0[0]=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
	RJMP _0x225
;                rx_wr_index_usartc0=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
_0x16B:
	LDI  R30,LOW(255)
	STS  _Mx,R30
_0x225:
	LDI  R30,LOW(1)
	MOV  R11,R30
	CLR  R10
;   }
;}
_0x16A:
;break;
	RJMP _0x9C
;
;case 0xD7:
_0x169:
	CPI  R30,LOW(0xD7)
	LDI  R26,HIGH(0xD7)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x17D
;{
;//проверка по длинне
; if(rx_wr_index_usartc0==1)
	LDI  R30,LOW(1)
	CP   R30,R10
	BREQ PC+2
	RJMP _0x174
; {
;                if(rx_buffer_usartc0[0]==0xD7)
	LDS  R26,_rx_buffer_usartc0
	CPI  R26,LOW(0xD7)
	BREQ PC+2
	RJMP _0x175
;
;                {
;                //установить время
;                //запись даты в переменные
;                get_CNTRTC(&X);
	CALL SUBOPT_0x5C
;                calcDateTime(X, 0, &date1,&time1);
;                //date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
;                //date1=date1*100+rx_buffer_usartc0[2];
;                //date1=date1*100+rx_buffer_usartc0[3];
;                //CSdt
;                //bufdt
;                //
;
;
;                bufdt[0]=time1/10000;
	CALL SUBOPT_0x61
	CALL __DIVD21U
	STS  _bufdt,R30
;                bufdt[1]=time1%10000/100;
	CALL SUBOPT_0x61
	CALL SUBOPT_0x3E
	__PUTB1MN _bufdt,1
;                bufdt[2]=time1%100;
	LDS  R26,_time1
	LDS  R27,_time1+1
	LDS  R24,_time1+2
	LDS  R25,_time1+3
	CALL SUBOPT_0x3F
	__PUTB1MN _bufdt,2
;                //тут же ответ
;                for(ch=0,bufdt[3]=0;ch<3;ch++) bufdt[3]=bufdt[3]+bufdt[ch];
	LDI  R30,LOW(0)
	STS  _ch,R30
	__PUTB1MN _bufdt,3
_0x177:
	LDS  R26,_ch
	CPI  R26,LOW(0x3)
	BRSH _0x178
	__GETB2MN _bufdt,3
	CALL SUBOPT_0x60
	LD   R30,Z
	ADD  R30,R26
	__PUTB1MN _bufdt,3
	CALL SUBOPT_0x5
	RJMP _0x177
_0x178:
	LDI  R26,LOW(215)
	RCALL _putchar
;                for (ch=0;ch<4;ch++) putchar(bufdt[ch]);
	LDI  R30,LOW(0)
	STS  _ch,R30
_0x17A:
	LDS  R26,_ch
	CPI  R26,LOW(0x4)
	BRSH _0x17B
	CALL SUBOPT_0x60
	LD   R26,Z
	RCALL _putchar
	CALL SUBOPT_0x5
	RJMP _0x17A
_0x17B:
	LDI  R30,LOW(255)
	CALL SUBOPT_0x4C
;                rx_buffer_usartc0[0]=0xFF;
;                RX_BUFFER_SIZE_USARTC0=1;
	RJMP _0x226
;                rx_wr_index_usartc0=0;
;                }
;                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
_0x175:
	LDI  R30,LOW(255)
	STS  _Mx,R30
_0x226:
	LDI  R30,LOW(1)
	MOV  R11,R30
	CLR  R10
;   }
;}
_0x174:
;break;
	RJMP _0x9C
;
;
;
;default :
_0x17D:
;{
;rx_buffer_usartc0[0]=0xFF;
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
;Mx=0xFF;
	CALL SUBOPT_0x47
;RX_BUFFER_SIZE_USARTC0=1;
;rx_wr_index_usartc0=0;
	CLR  R10
;}
;//delay_ms(1);
;}
_0x9C:
;
;
;}
	RJMP _0x239
; .FEND
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;//////////////////////////////////////////////////////////////////////////////////////////////////////
;// Receive a character from USARTC0
;// USARTC0 is used as the default input device by the 'getchar' function
;#define _ALTERNATE_GETCHAR_
;
;#pragma used+
;char getchar(void)
;{
;char data;
;
;while (rx_counter_usartc0==0);
;	data -> R17
;data=rx_buffer_usartc0[rx_rd_index_usartc0++];
;//#if RX_BUFFER_SIZE_USARTC0 != 256
;if (rx_rd_index_usartc0 == RX_BUFFER_SIZE_USARTC0) rx_rd_index_usartc0=0;
;//#endif
;#asm("cli")
;--rx_counter_usartc0;
;#asm("sei")
;return data;
;}
;#pragma used-
;
;// Write a character to the USARTC0 Transmitter
;// USARTC0 is used as the default output device by the 'putchar' function
;#define _ALTERNATE_PUTCHAR_
;
;#pragma used+
;void putchar(char c)
;{
_putchar:
; .FSTART _putchar
;while ((USARTC0.STATUS & USART_DREIF_bm) == 0);
	ST   -Y,R26
;	c -> Y+0
_0x182:
	LDS  R30,2209
	ANDI R30,LOW(0x20)
	BREQ _0x182
;USARTC0.DATA=c;
	LD   R30,Y
	STS  2208,R30
;}
	RJMP _0x2100028
; .FEND
;#pragma used-
;
;// USARTD1 initialization
;void usartd1_init(void)
;{
_usartd1_init:
; .FSTART _usartd1_init
;// Note: the correct PORTD direction for the RxD, TxD and XCK signals
;// is configured in the ports_init function
;
;// Transmitter is enabled
;// Set TxD=1
;PORTD.OUTSET=0x80;
	LDI  R30,LOW(128)
	STS  1637,R30
;
;// Communication mode: Asynchronous USART
;// Data bits: 8
;// Stop bits: 1
;// Parity: Disabled
;USARTD1.CTRLC=USART_CMODE_ASYNCHRONOUS_gc | USART_PMODE_DISABLED_gc | USART_CHSIZE_8BIT_gc;
	LDI  R30,LOW(3)
	STS  2485,R30
;
;// Receive complete interrupt: Disabled
;// Transmit complete interrupt: Disabled
;// Data register empty interrupt: Disabled
;USARTD1.CTRLA=(USARTD1.CTRLA & (~(USART_RXCINTLVL_gm | USART_TXCINTLVL_gm | USART_DREINTLVL_gm))) |
;    USART_RXCINTLVL_OFF_gc | USART_TXCINTLVL_OFF_gc | USART_DREINTLVL_OFF_gc;
	LDS  R30,2483
	ANDI R30,LOW(0xC0)
	STS  2483,R30
;
;// Required Baud rate: 57600
;// Real Baud Rate: 57605,8 (x1 Mode), Error: 0,0 %
;USARTD1.BAUDCTRLA=0x6E;
	LDI  R30,LOW(110)
	STS  2486,R30
;USARTD1.BAUDCTRLB=((0x0A << USART_BSCALE_bp) & USART_BSCALE_gm) | 0x08;
	LDI  R30,LOW(168)
	STS  2487,R30
;
;// Receiver: Off
;// Transmitter: On
;// Double transmission speed mode: Off
;// Multi-processor communication mode: Off
;USARTD1.CTRLB=(USARTD1.CTRLB & (~(USART_RXEN_bm | USART_TXEN_bm | USART_CLK2X_bm | USART_MPCM_bm | USART_TXB8_bm))) |
;    USART_TXEN_bm;
	LDS  R30,2484
	ANDI R30,LOW(0xE0)
	ORI  R30,8
	STS  2484,R30
;}
	RET
; .FEND
;
;// Write a character to the USARTD1 Transmitter
;#pragma used+
;void putchar_usartd1(char c)
;{
_putchar_usartd1:
; .FSTART _putchar_usartd1
;while ((USARTD1.STATUS & USART_DREIF_bm) == 0);
	ST   -Y,R26
;	c -> Y+0
_0x185:
	LDS  R30,2481
	ANDI R30,LOW(0x20)
	BREQ _0x185
;USARTD1.DATA=c;
	LD   R30,Y
	STS  2480,R30
;}
	RJMP _0x2100028
; .FEND
;#pragma used-
;
;
;//второй usart для меня
;void monitor(void)
;{
_monitor:
; .FSTART _monitor
;char x;
;for(x=0;x<strlen(info);x++)
	ST   -Y,R17
;	x -> R17
	LDI  R17,LOW(0)
_0x189:
	LDI  R26,LOW(_info)
	LDI  R27,HIGH(_info)
	CALL _strlen
	MOV  R26,R17
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x18A
;{
;putchar_usartd1(info[x]);
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_info)
	SBCI R31,HIGH(-_info)
	LD   R26,Z
	RCALL _putchar_usartd1
;}
	SUBI R17,-1
	RJMP _0x189
_0x18A:
;memset(info,0,30);
	CALL SUBOPT_0x62
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(30)
	LDI  R27,0
	CALL _memset
;putchar_usartd1(10);
	LDI  R26,LOW(10)
	RCALL _putchar_usartd1
;putchar_usartd1(13);
	LDI  R26,LOW(13)
	RCALL _putchar_usartd1
;}
	RJMP _0x210002A
; .FEND
;
;
;
;#include "for_SD.c"
;
;//#include "for_SD.c"
;
;
;#include <io.h>
;#include <delay.h>
;#include <stdio.h>
;#include <stdlib.h>
;#include <ff.h>
;#include <string.h>
;
;
;// Declare your global variables here
;
;/* FAT function result */
;FRESULT res;
;/* number of bytes written/read to the file */
;unsigned int nbytes;
;/* will hold the information for logical drive 0: */
;FATFS fat;
;/* will hold the file information */
;FIL file;
;/* file path */
;char path[]="0:/test.txt";

	.DSEG
;char SD_IN=1;
;/* file read buffer */
;char buffer[36];
;
;char SD[15];
;char SD1[15];
;
;
;
;
;/* error message list */
;flash char * flash error_msg[]=
;{
;"", /* not used */
;"FR_DISK_ERR",
;"FR_INT_ERR",
;"FR_INT_ERR",
;"FR_NOT_READY",
;"FR_NO_FILE",
;"FR_NO_PATH",
;"FR_INVALID_NAME",
;"FR_DENIED",
;"FR_EXIST",
;"FR_INVALID_OBJECT",
;"FR_WRITE_PROTECTED",
;"FR_INVALID_DRIVE",
;"FR_NOT_ENABLED",
;"FR_NO_FILESYSTEM",
;"FR_MKFS_ABORTED",
;"FR_TIMEOUT"
;};
;
;/* display error message and stop */
;void error(FRESULT res)
; 0000 0014 {

	.CSEG
_error:
; .FSTART _error
;if ((res>=FR_DISK_ERR) && (res<=FR_TIMEOUT))
	ST   -Y,R26
;	res -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRLO _0x18E
	CPI  R26,LOW(0x10)
	BRLO _0x18F
_0x18E:
	RJMP _0x18D
_0x18F:
;   {
;   sprintf(info,"ERROR: %p\r\n",error_msg[res]);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,207
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDI  R26,LOW(_error_msg*2)
	LDI  R27,HIGH(_error_msg*2)
	CALL SUBOPT_0x63
	CALL __GETW1PF
	CALL SUBOPT_0x64
;   monitor();
;   // Дерегистрация и отмена рабочих областей, освобождение порта
;   f_mount(0, NULL);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _f_mount
;   SD_IN=0;
	LDI  R30,LOW(0)
	STS  _SD_IN,R30
;   PORTC.DIR=0x00;
	STS  1600,R30
;   PORTC.OUT=0x00;
	STS  1604,R30
;   PORTC.OUT=0x18;
	CALL SUBOPT_0x1A
;   PORTC.DIR=0xB9;
;   }
;/* stop here */
;//while(1);
;}
_0x18D:
	RJMP _0x2100028
; .FEND
;
;#include "timers_init.c"
;void tc0_disable(TC0_t *ptc)
; 0000 0015 {
_tc0_disable:
; .FSTART _tc0_disable
;// Timer/Counter off
;ptc->CTRLA=(ptc->CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
;	*ptc -> Y+0
;// Issue a reset command
;ptc->CTRLFSET=TC_CMD_RESET_gc;
;}
; .FEND
;
;void tc1_disable(TC1_t *ptc)
;{
_tc1_disable:
; .FSTART _tc1_disable
;// Timer/Counter off
;ptc->CTRLA=(ptc->CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
_0x210002B:
	ST   -Y,R27
	ST   -Y,R26
;	*ptc -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	ANDI R30,LOW(0xF0)
	ST   X,R30
;// Issue a reset command
;ptc->CTRLFSET=TC_CMD_RESET_gc;
	ADIW R26,9
	LDI  R30,LOW(12)
	ST   X,R30
;}
	ADIW R28,2
	RET
; .FEND
;
;
;// Timer/Counter TCC0 initialization
;void tcc0_init(void)
;{
_tcc0_init:
; .FSTART _tcc0_init
;unsigned char s;
;unsigned char n;
;
;// Note: the correct PORTC direction for the Compare Channels outputs
;// is configured in the ports_init function
;
;// Save interrupts enabled/disabled state
;s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	s -> R17
;	n -> R16
	IN   R17,63
;// Disable interrupts
;#asm("cli")
	cli
;
;// Disable and reset the timer/counter just to be sure
;//tc0_disable(&TCC0);
;// Clock source: Peripheral Clock/64
;TCC0.CTRLA=(TCC0.CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_DIV64_gc;
	LDS  R30,2048
	ANDI R30,LOW(0xF0)
	ORI  R30,LOW(0x5)
	STS  2048,R30
;// Mode: Normal Operation, Overflow Int./Event on TOP
;// Compare/Capture on channel A: Off
;// Compare/Capture on channel B: Off
;// Compare/Capture on channel C: Off
;// Compare/Capture on channel D: Off
;TCC0.CTRLB=(TCC0.CTRLB & (~(TC0_CCAEN_bm | TC0_CCBEN_bm | TC0_CCCEN_bm | TC0_CCDEN_bm | TC0_WGMODE_gm))) |
;    TC_WGMODE_NORMAL_gc;
	LDS  R30,2049
	ANDI R30,LOW(0x8)
	STS  2049,R30
;
;// Capture event source: None
;// Capture event action: None
;TCC0.CTRLD=(TCC0.CTRLD & (~(TC0_EVACT_gm | TC0_EVSEL_gm))) |
;    TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	LDS  R30,2051
	ANDI R30,LOW(0x10)
	STS  2051,R30
;
;// Overflow interrupt: High Level
;// Error interrupt: Disabled
;TCC0.INTCTRLA=(TCC0.INTCTRLA & (~(TC0_ERRINTLVL_gm | TC0_OVFINTLVL_gm))) |
;    TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_LO_gc;   //////////////////////////////////////////hi
	LDS  R30,2054
	ANDI R30,LOW(0xF0)
	ORI  R30,1
	STS  2054,R30
;
;// Compare/Capture channel A interrupt: Disabled
;// Compare/Capture channel B interrupt: Disabled
;// Compare/Capture channel C interrupt: Disabled
;// Compare/Capture channel D interrupt: Disabled
;TCC0.INTCTRLB=(TCC0.INTCTRLB & (~(TC0_CCDINTLVL_gm | TC0_CCCINTLVL_gm | TC0_CCBINTLVL_gm | TC0_CCAINTLVL_gm))) |
;    TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDS  R30,2055
	ANDI R30,LOW(0x0)
	STS  2055,R30
;
;// High resolution extension: Off
;//HIRESC.CTRL&= ~HIRES_HREN0_bm;
;
;// Advanced Waveform Extension initialization
;// Optimize for speed
;#pragma optsize-
;// Disable locking the AWEX configuration registers just to be sure
;n=MCU.AWEXLOCK & (~MCU_AWEXCLOCK_bm);
	LDS  R30,153
	ANDI R30,0xFE
	MOV  R16,R30
;CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
;MCU.AWEXLOCK=n;
	STS  153,R16
;// Restore optimization for size if needed
;#pragma optsize_default
;
;// Pattern generation: Off
;// Dead time insertion: Off
;AWEXC.CTRL&= ~(AWEX_PGM_bm | AWEX_CWCM_bm | AWEX_DTICCDEN_bm | AWEX_DTICCCEN_bm | AWEX_DTICCBEN_bm | AWEX_DTICCAEN_bm);
	LDS  R30,2176
	ANDI R30,LOW(0xC0)
	STS  2176,R30
;
;// Fault protection initialization
;// Fault detection on OCD Break detection: On
;// Fault detection restart mode: Latched Mode
;// Fault detection action: None (Fault protection disabled)
;AWEXC.FDCTRL=(AWEXC.FDCTRL & (~(AWEX_FDDBD_bm | AWEX_FDMODE_bm | AWEX_FDACT_gm))) |
;    AWEX_FDACT_NONE_gc;
	LDS  R30,2179
	ANDI R30,LOW(0xE8)
	STS  2179,R30
;// Fault detect events:
;// Event channel 0: Off
;// Event channel 1: Off
;// Event channel 2: Off
;// Event channel 3: Off
;// Event channel 4: Off
;// Event channel 5: Off
;// Event channel 6: Off
;// Event channel 7: Off
;AWEXC.FDEVMASK=0b00000000;
	LDI  R30,LOW(0)
	STS  2178,R30
;// Make sure the fault detect flag is cleared
;AWEXC.STATUS|=AWEXC.STATUS & AWEX_FDF_bm;
	LDI  R26,LOW(2180)
	LDI  R27,HIGH(2180)
	MOV  R0,R26
	LD   R26,X
	LDS  R30,2180
	ANDI R30,LOW(0x4)
	OR   R30,R26
	MOV  R26,R0
	ST   X,R30
;
;// Clear the interrupt flags
;TCC0.INTFLAGS=TCC0.INTFLAGS;
	LDS  R30,2060
	STS  2060,R30
;// Set counter register
;TCC0.CNT=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2080,R30
	STS  2080+1,R31
;// Set period register
;TCC0.PER=0x7A11;
	LDI  R30,LOW(31249)
	LDI  R31,HIGH(31249)
	STS  2086,R30
	STS  2086+1,R31
;// Set channel A Compare/Capture register
;TCC0.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2088,R30
	STS  2088+1,R31
;// Set channel B Compare/Capture register
;TCC0.CCB=0x0000;
	STS  2090,R30
	STS  2090+1,R31
;// Set channel C Compare/Capture register
;TCC0.CCC=0x0000;
	STS  2092,R30
	STS  2092+1,R31
;// Set channel D Compare/Capture register
;TCC0.CCD=0x0000;
	STS  2094,R30
	STS  2094+1,R31
;
;// Restore interrupts enabled/disabled state
;SREG=s;
	OUT  0x3F,R17
;}
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;
;
;
;// Timer/Counter TCC1 initialization
;void tcc1_init(void)
;
;{
_tcc1_init:
; .FSTART _tcc1_init
;unsigned char s;
;
;// Note: the correct PORTC direction for the Compare Channels outputs
;// is configured in the ports_init function
;
;// Save interrupts enabled/disabled state
;s=SREG;
	ST   -Y,R17
;	s -> R17
	IN   R17,63
;// Disable interrupts
;#asm("cli")
	cli
;
;// Disable and reset the timer/counter just to be sure
;tc1_disable(&TCC1);
	LDI  R26,LOW(2112)
	LDI  R27,HIGH(2112)
	RCALL _tc1_disable
;// Clock source: ClkPer/64
;//40ms!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;TCC1.CTRLA=TC_CLKSEL_DIV64_gc;
	LDI  R30,LOW(5)
	STS  2112,R30
;// Mode: Normal Operation, Overflow Int./Event on TOP
;// Compare/Capture on channel A: Off
;// Compare/Capture on channel B: Off
;TCC1.CTRLB=(0<<TC1_CCBEN_bp) | (0<<TC1_CCAEN_bp) |
;	TC_WGMODE_NORMAL_gc;
	LDI  R30,LOW(0)
	STS  2113,R30
;// Capture event source: None
;// Capture event action: None
;TCC1.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	STS  2115,R30
;
;// Set Timer/Counter in Normal mode
;TCC1.CTRLE=(0<<TC1_BYTEM_bp);
	STS  2116,R30
;
;// Overflow interrupt: Disabled
;// Error interrupt: Disabled
;//TCC1.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_OFF_gc;
;TCC1.INTCTRLA=(TCC1.INTCTRLA & (~(TC1_ERRINTLVL_gm | TC1_OVFINTLVL_gm))) |
;    TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_LO_gc;
	LDS  R30,2118
	ANDI R30,LOW(0xF0)
	ORI  R30,1
	STS  2118,R30
;
;// Compare/Capture channel A interrupt: Disabled
;// Compare/Capture channel B interrupt: Disabled
;TCC1.INTCTRLB=TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDI  R30,LOW(0)
	STS  2119,R30
;
;// High resolution extension: Off
;HIRESC.CTRLA&= ~HIRES_HREN1_bm;
	LDS  R30,2192
	ANDI R30,0xFD
	STS  2192,R30
;
;// Clear the interrupt flags
;TCC1.INTFLAGS=TCC1.INTFLAGS;
	LDS  R30,2124
	STS  2124,R30
;// Set Counter register
;TCC1.CNT=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2144,R30
	STS  2144+1,R31
;// Set Period register
;
;//40ms!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;TCC1.PER=0x4E1F;// n
	LDI  R30,LOW(19999)
	LDI  R31,HIGH(19999)
	STS  2150,R30
	STS  2150+1,R31
;// Set channel A Compare/Capture register
;TCC1.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2152,R30
	STS  2152+1,R31
;// Set channel B Compare/Capture register
;TCC1.CCB=0x0000;
	STS  2154,R30
	STS  2154+1,R31
;
;// Restore interrupts enabled/disabled state
;SREG=s;
	RJMP _0x2100029
;}
; .FEND
;// Timer/Counter TCD0 initialization
;// Timer/Counter TCD0 initialization
;void tcd0_init(void)
;{
_tcd0_init:
; .FSTART _tcd0_init
;unsigned char s;
;
;// Note: The correct PORTD direction for the Compare Channels
;// outputs is configured in the ports_init function.
;
;// Save interrupts enabled/disabled state
;s=SREG;
	ST   -Y,R17
;	s -> R17
	IN   R17,63
;// Disable interrupts
;#asm("cli")
	cli
;
;// Disable and reset the timer/counter just to be sure
;tc0_disable(&TCD0);
	LDI  R26,LOW(2304)
	LDI  R27,HIGH(2304)
	RCALL _tc0_disable
;// Clock source: ClkPer/8
;TCD0.CTRLA=TC_CLKSEL_DIV8_gc;
	LDI  R30,LOW(4)
	STS  2304,R30
;// Mode: Normal Operation, Overflow Int./Event on TOP
;// Compare/Capture on channel A: Off
;// Compare/Capture on channel B: Off
;// Compare/Capture on channel C: Off
;// Compare/Capture on channel D: Off
;TCD0.CTRLB=(0<<TC0_CCDEN_bp) | (0<<TC0_CCCEN_bp) | (0<<TC0_CCBEN_bp) | (0<<TC0_CCAEN_bp) |
;	TC_WGMODE_NORMAL_gc;
	LDI  R30,LOW(0)
	STS  2305,R30
;// Capture event source: None
;// Capture event action: None
;TCD0.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	STS  2307,R30
;
;// Set Timer/Counter in Normal mode
;TCD0.CTRLE=(0<<TC0_BYTEM_bp);
	STS  2308,R30
;
;// Overflow interrupt: High Level
;// Error interrupt: Disabled
;TCD0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;
	LDI  R30,LOW(3)
	STS  2310,R30
;
;// Compare/Capture channel A interrupt: Disabled
;// Compare/Capture channel B interrupt: Disabled
;// Compare/Capture channel C interrupt: Disabled
;// Compare/Capture channel D interrupt: Disabled
;TCD0.INTCTRLB=TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDI  R30,LOW(0)
	STS  2311,R30
;
;// High resolution extension: Off
;HIRESD.CTRLA&= ~HIRES_HREN0_bm;
	LDS  R30,2448
	ANDI R30,0xFE
	STS  2448,R30
;
;// Clear the interrupt flags
;TCD0.INTFLAGS=TCD0.INTFLAGS;
	LDS  R30,2316
	STS  2316,R30
;// Set Counter register
;TCD0.CNT=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2336,R30
	STS  2336+1,R31
;// Set Period register
;TCD0.PER=0x9C3F;
	LDI  R30,LOW(39999)
	LDI  R31,HIGH(39999)
	STS  2342,R30
	STS  2342+1,R31
;// Set channel A Compare/Capture register
;TCD0.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2344,R30
	STS  2344+1,R31
;// Set channel B Compare/Capture register
;TCD0.CCB=0x0000;
	STS  2346,R30
	STS  2346+1,R31
;// Set channel C Compare/Capture register
;TCD0.CCC=0x0000;
	STS  2348,R30
	STS  2348+1,R31
;// Set channel D Compare/Capture register
;TCD0.CCD=0x0000;
	STS  2350,R30
	STS  2350+1,R31
;
;// Restore interrupts enabled/disabled state
;SREG=s;
	RJMP _0x2100029
;}
; .FEND
;
;
;// Timer/Counter TCF0 initialization
;void tcf0_init(void)
;{
_tcf0_init:
; .FSTART _tcf0_init
;unsigned char s;
;
;// Note: The correct PORTF direction for the Compare Channels
;// outputs is configured in the ports_init function.
;
;// Save interrupts enabled/disabled state
;s=SREG;
	ST   -Y,R17
;	s -> R17
	IN   R17,63
;// Disable interrupts
;#asm("cli")
	cli
;
;// Disable and reset the timer/counter just to be sure
;tc0_disable(&TCF0);
	LDI  R26,LOW(2816)
	LDI  R27,HIGH(2816)
	RCALL _tc0_disable
;// Clock source: ClkPer/1024
;TCF0.CTRLA=TC_CLKSEL_DIV1024_gc;
	LDI  R30,LOW(7)
	STS  2816,R30
;// Mode: Normal Operation, Overflow Int./Event on TOP
;// Compare/Capture on channel A: Off
;// Compare/Capture on channel B: Off
;// Compare/Capture on channel C: Off
;// Compare/Capture on channel D: Off
;TCF0.CTRLB=(0<<TC0_CCDEN_bp) | (0<<TC0_CCCEN_bp) | (0<<TC0_CCBEN_bp) | (0<<TC0_CCAEN_bp) |
;	TC_WGMODE_NORMAL_gc;
	LDI  R30,LOW(0)
	STS  2817,R30
;// Capture event source: None
;// Capture event action: None
;TCF0.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	STS  2819,R30
;
;// Set Timer/Counter in Normal mode
;TCF0.CTRLE=(0<<TC0_BYTEM_bp);
	STS  2820,R30
;
;// Overflow interrupt: hi Level
;// Error interrupt: Disabled
;TCF0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;
	LDI  R30,LOW(3)
	STS  2822,R30
;
;// Compare/Capture channel A interrupt: Disabled
;// Compare/Capture channel B interrupt: Disabled
;// Compare/Capture channel C interrupt: Disabled
;// Compare/Capture channel D interrupt: Disabled
;TCF0.INTCTRLB=TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDI  R30,LOW(0)
	STS  2823,R30
;
;// High resolution extension: Off
;HIRESF.CTRLA&= ~HIRES_HREN0_bm;
	LDS  R30,2960
	ANDI R30,0xFE
	STS  2960,R30
;
;// Clear the interrupt flags
;TCF0.INTFLAGS=TCF0.INTFLAGS;
	LDS  R30,2828
	STS  2828,R30
;// Set Counter register
;TCF0.CNT=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2848,R30
	STS  2848+1,R31
;// Set Period register
;// 1 cek
;TCF0.PER=0x7A11;
	LDI  R30,LOW(31249)
	LDI  R31,HIGH(31249)
	STS  2854,R30
	STS  2854+1,R31
;//999 ms
;//TCF0.PER=0x79F2;
;// Set channel A Compare/Capture register
;TCF0.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2856,R30
	STS  2856+1,R31
;// Set channel B Compare/Capture register
;TCF0.CCB=0x0000;
	STS  2858,R30
	STS  2858+1,R31
;// Set channel C Compare/Capture register
;TCF0.CCC=0x0000;
	STS  2860,R30
	STS  2860+1,R31
;// Set channel D Compare/Capture register
;TCF0.CCD=0x0000;
	STS  2862,R30
	STS  2862+1,R31
;
;// Restore interrupts enabled/disabled state
;SREG=s;
_0x2100029:
	OUT  0x3F,R17
;}
_0x210002A:
	LD   R17,Y+
	RET
; .FEND
;
;#include "spi_twi_init.c"
;// SPIC initialization
;void spic_init(void)
; 0000 0016 {
_spic_init:
; .FSTART _spic_init
;// SPIC is enabled
;// SPI mode: 0
;// Operating as: Master
;// Data order: MSB First
;// SCK clock prescaler: 128 250
;// SCK clock prescaler: 64  1000
;// SCK clock prescaler: 16  2000
;// SCK clock doubled: Off
;// SCK clock frequency: 250,000 - 2000!!!
;SPIC.CTRL=SPI_ENABLE_bm | SPI_MODE_0_gc | SPI_MASTER_bm |
;    SPI_PRESCALER_DIV64_gc;
	LDI  R30,LOW(82)
	STS  2240,R30
;// SPIC interrupt: Disabled
;SPIC.INTCTRL=(SPIC.INTCTRL & (~SPI_INTLVL_gm)) | SPI_INTLVL_OFF_gc;
	LDS  R30,2241
	ANDI R30,LOW(0xFC)
	STS  2241,R30
;// Note: the MOSI (PORTC Bit 5), SCK (PORTC Bit 7) and
;// /SS (PORTC Bit 4) signals are configured as outputs in the ports_init function
;}
	RET
; .FEND
;
;// Macro used to drive the SPIC /SS signal low in order to select the slave
;//#define SET_SPIC_SS_LOW {PORTC.OUTCLR=SPI_SS_bm;}
;// Macro used to drive the SPIC /SS signal high in order to deselect the slave
;//#define SET_SPIC_SS_HIGH {PORTC.OUTSET=SPI_SS_bm;}
;
;// SPIC transmit/receive function in Master mode
;// c - data to be transmitted
;// Returns the received data
;unsigned char spic_master_tx_rx(unsigned char c)
;{
_spic_master_tx_rx:
; .FSTART _spic_master_tx_rx
;// Transmit data in Master mode
;SPIC.DATA=c;
	ST   -Y,R26
;	c -> Y+0
	LD   R30,Y
	STS  2243,R30
;// Wait for the data to be transmitted/received
;while ((SPIC.STATUS & SPI_IF_bm)==0);
_0x190:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x190
;// Return the received data
;return SPIC.DATA;
	LDS  R30,2243
_0x2100028:
	ADIW R28,1
	RET
;}
; .FEND
;
;
;
;// TWIE initialization
;// structure that holds information used by the TWIE Master
;// for performing a TWI bus transaction
;TWI_MASTER_INFO_t twie_master;
;
;void twie_init(void)
;{
_twie_init:
; .FSTART _twie_init
;// General TWIE initialization
;// External Driver Interface: Off
;// SDA Hold: Off
;twi_init(&TWIE,false,false);
	LDI  R30,LOW(1184)
	LDI  R31,HIGH(1184)
	CALL SUBOPT_0x65
	LDI  R26,LOW(0)
	CALL _twi_init
;
;// TWIE Master initialization
;// Master interrupt: Low Level
;// System Clock frequency: 32000000 Hz
;// SCL Rate: 100000 bps
;// Real SCL Rate: 100000 bps, Error: 0,0 %
;twi_master_init(&twie_master,&TWIE,TWI_MASTER_INTLVL_LO_gc,
;    TWI_BAUD_REG(32000000,100000));
	CALL SUBOPT_0x66
	LDI  R30,LOW(1184)
	LDI  R31,HIGH(1184)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(155)
	CALL _twi_master_init
;
;
;
;// TWIE Slave is disabled
;TWIE.SLAVE.CTRLA=0;
	LDI  R30,LOW(0)
	STS  1192,R30
;}
	RET
; .FEND
;
;// TWIE Master interrupt service routine
;#pragma optsize- // optimize for speed
;interrupt [TWIE_TWIM_vect] void twie_master_isr(void)
;{
_twie_master_isr:
; .FSTART _twie_master_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;twi_master_int_handler(&twie_master);
	LDI  R26,LOW(_twie_master)
	LDI  R27,HIGH(_twie_master)
	CALL _twi_master_int_handler
;}
_0x239:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;#pragma optsize_default
;#include "bmp085.c"
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//адрес BMP085 без W/R
;#define BMP085_TWI_BUS_ADDRESS (0xEE>>1)
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;#include <twix.h>
;// I/O Registers definitions
;#include <io.h>
;#include <delay.h>
;#include <stdio.h>
;//#include <alcd.h>
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_VARIABLE_!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;signed short AC1;
;signed short AC2;
;signed short AC3;
;unsigned short  AC4;
;unsigned short  AC5;
;unsigned short  AC6;
;signed short B1;
;signed short B2;
;signed short MB;
;signed short MC;
;signed short MD;
;long UT = 0;
;char oss=3;

	.DSEG
;long UP = 0;
;
;signed long X1,X2,B5,Temp,B6,X3,B3,p;
;unsigned long B4,B7;
;float Tempf;
;float p1;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_VARIABLE_!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;
;//структура данных датчика
;//адреса регистров
;      struct
;        {
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC1;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC2;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC3;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC4;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC5;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC6;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } B1;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } B2;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MB;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MC;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MD;
;        } twi_bmp085_reg;
;
;
;
;  //значения калибр регистров
;struct
;        {
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC1;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC2;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC3;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC4;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC5;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } AC6;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } B1;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } B2;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MB;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MC;
;        struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } MD;
;        } twi_bmp085_data;
;
;//запрос температуры
; struct
;            {
;            unsigned char reg;
;            unsigned char data;
;            } read_temp_please;
;
; //чтение температуры
; //адреса
;  struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } read_temp_adr;
;  //данные
;  struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            } read_temp_data;
;
;
;  //чтение давления
;  //запрос давления
; struct
;            {
;            unsigned char reg;
;            unsigned char data;
;            } read_pres_please;
; //адреса
;  struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            unsigned char xlsb;
;            } read_pres_adr;
;  //данные
;  struct
;            {
;            unsigned char msb;
;            unsigned char lsb;
;            unsigned char xlsb;
;            } read_pres_data;
;
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//установка адресов регистров калибровки, запроса температуры и давления
;void set_reg (void)
; 0000 0017 {

	.CSEG
_set_reg:
; .FSTART _set_reg
;
;//адреса регистров температуры
;read_temp_adr.msb=0xF6;
	LDI  R30,LOW(246)
	STS  _read_temp_adr,R30
;read_temp_adr.lsb=0xF7;
	LDI  R30,LOW(247)
	__PUTB1MN _read_temp_adr,1
;//запрос температуры
;read_temp_please.reg=0xF4;
	LDI  R30,LOW(244)
	STS  _read_temp_please,R30
;read_temp_please.data=0x2E;
	LDI  R30,LOW(46)
	__PUTB1MN _read_temp_please,1
;
;//адреса регистров давления
;read_pres_adr.msb=0xF6;
	LDI  R30,LOW(246)
	STS  _read_pres_adr,R30
;read_pres_adr.lsb=0xF7;
	LDI  R30,LOW(247)
	__PUTB1MN _read_pres_adr,1
;read_pres_adr.xlsb=0xF8;
	LDI  R30,LOW(248)
	__PUTB1MN _read_pres_adr,2
;//запрос давления
;read_pres_please.reg=0xF4;
	LDI  R30,LOW(244)
	STS  _read_pres_please,R30
;read_pres_please.data=0x34+(oss<<6);
	LDS  R30,_oss
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LSL  R30
	SUBI R30,-LOW(52)
	__PUTB1MN _read_pres_please,1
;
;//адреса калибровочных регистров
;//AC1 adres
;twi_bmp085_reg.AC1.msb=0xAA;
	LDI  R30,LOW(170)
	STS  _twi_bmp085_reg,R30
;twi_bmp085_reg.AC1.lsb=0xAB;
	LDI  R30,LOW(171)
	__PUTB1MN _twi_bmp085_reg,1
;//AC2 adres
;twi_bmp085_reg.AC2.msb=0xAC;
	LDI  R30,LOW(172)
	__PUTB1MN _twi_bmp085_reg,2
;twi_bmp085_reg.AC2.lsb=0xAD;
	LDI  R30,LOW(173)
	__PUTB1MN _twi_bmp085_reg,3
;//AC3 adres
;twi_bmp085_reg.AC3.msb=0xAE;
	LDI  R30,LOW(174)
	__PUTB1MN _twi_bmp085_reg,4
;twi_bmp085_reg.AC3.lsb=0xAF;
	LDI  R30,LOW(175)
	__PUTB1MN _twi_bmp085_reg,5
;//AC4 adres
;twi_bmp085_reg.AC4.msb=0xB0;
	LDI  R30,LOW(176)
	__PUTB1MN _twi_bmp085_reg,6
;twi_bmp085_reg.AC4.lsb=0xB1;
	LDI  R30,LOW(177)
	__PUTB1MN _twi_bmp085_reg,7
;//AC5 adres
;twi_bmp085_reg.AC5.msb=0xB2;
	LDI  R30,LOW(178)
	__PUTB1MN _twi_bmp085_reg,8
;twi_bmp085_reg.AC5.lsb=0xB3;
	LDI  R30,LOW(179)
	__PUTB1MN _twi_bmp085_reg,9
;//AC6 adres
;twi_bmp085_reg.AC6.msb=0xB4;
	LDI  R30,LOW(180)
	__PUTB1MN _twi_bmp085_reg,10
;twi_bmp085_reg.AC6.lsb=0xB5;
	LDI  R30,LOW(181)
	__PUTB1MN _twi_bmp085_reg,11
;//B1 adres
;twi_bmp085_reg.B1.msb=0xB6;
	LDI  R30,LOW(182)
	__PUTB1MN _twi_bmp085_reg,12
;twi_bmp085_reg.B1.lsb=0xB7;
	LDI  R30,LOW(183)
	__PUTB1MN _twi_bmp085_reg,13
;//B2 adres
;twi_bmp085_reg.B2.msb=0xB8;
	LDI  R30,LOW(184)
	__PUTB1MN _twi_bmp085_reg,14
;twi_bmp085_reg.B2.lsb=0xB9;
	LDI  R30,LOW(185)
	__PUTB1MN _twi_bmp085_reg,15
;//MB adres
;twi_bmp085_reg.MB.msb=0xBA;
	LDI  R30,LOW(186)
	__PUTB1MN _twi_bmp085_reg,16
;twi_bmp085_reg.MB.lsb=0xBB;
	LDI  R30,LOW(187)
	__PUTB1MN _twi_bmp085_reg,17
;//MC adres
;twi_bmp085_reg.MC.msb=0xBC;
	LDI  R30,LOW(188)
	__PUTB1MN _twi_bmp085_reg,18
;twi_bmp085_reg.MC.lsb=0xBD;
	LDI  R30,LOW(189)
	__PUTB1MN _twi_bmp085_reg,19
;//MD adres
;twi_bmp085_reg.MD.msb=0xBE;
	LDI  R30,LOW(190)
	__PUTB1MN _twi_bmp085_reg,20
;twi_bmp085_reg.MD.lsb=0xBF;
	LDI  R30,LOW(191)
	__PUTB1MN _twi_bmp085_reg,21
;}
	RET
; .FEND
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//функция для сокращения объема основной проги
;void bmp_reg_init (void)
;{
_bmp_reg_init:
; .FSTART _bmp_reg_init
;/////////////////////////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ...
;//адреса калибровки
;set_reg();
	RCALL _set_reg
;//чтение калибровочных данных
;//AC1
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC1,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC1,
;    2                     );
	CALL SUBOPT_0x66
	LDI  R30,LOW(119)
	ST   -Y,R30
	LDI  R30,LOW(_twi_bmp085_reg)
	LDI  R31,HIGH(_twi_bmp085_reg)
	CALL SUBOPT_0x67
	LDI  R30,LOW(_twi_bmp085_data)
	LDI  R31,HIGH(_twi_bmp085_data)
	CALL SUBOPT_0x68
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//AC2
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC2,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC2,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,2
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,2
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//AC3
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC3,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC3,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,4
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,4
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//AC4
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC4,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC4,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,6
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,6
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//AC5
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC5,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC5,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,8
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,8
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//AC6
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.AC6,
;    2,
;    (unsigned char *)&twi_bmp085_data.AC6,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,10
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,10
	CALL SUBOPT_0x68
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//B1
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.B1,
;    2,
;    (unsigned char *)&twi_bmp085_data.B1,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,12
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,12
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//B2
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.B2,
;    2,
;    (unsigned char *)&twi_bmp085_data.B2,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,14
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,14
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//MB
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.MB,
;    2,
;    (unsigned char *)&twi_bmp085_data.MB,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,16
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,16
	CALL SUBOPT_0x68
;
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//MC
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.MC,
;    2,
;    (unsigned char *)&twi_bmp085_data.MC,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,18
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,18
	CALL SUBOPT_0x68
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//MD
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&twi_bmp085_reg.MD,
;    2,
;    (unsigned char *)&twi_bmp085_data.MD,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _twi_bmp085_reg,20
	CALL SUBOPT_0x67
	__POINTW1MN _twi_bmp085_data,20
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(2)
	CALL _twi_master_trans
;//////////////////////////////////////CALC////////////////////////////////////////////////////
;
;
;//вычисление переменных для расчета температуры// и давления
;AC1=(twi_bmp085_data.AC1.msb<<8)+twi_bmp085_data.AC1.lsb;
	LDS  R27,_twi_bmp085_data
	LDI  R26,LOW(0)
	__GETB1MN _twi_bmp085_data,1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC1,R30
	STS  _AC1+1,R31
;AC2=(twi_bmp085_data.AC2.msb<<8)+twi_bmp085_data.AC2.lsb;
	__GETB1HMN _twi_bmp085_data,2
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,3
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC2,R30
	STS  _AC2+1,R31
;AC3=(twi_bmp085_data.AC3.msb<<8)+twi_bmp085_data.AC3.lsb;
	__GETB1HMN _twi_bmp085_data,4
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,5
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC3,R30
	STS  _AC3+1,R31
;AC4=(twi_bmp085_data.AC4.msb<<8)+twi_bmp085_data.AC4.lsb;
	__GETB1HMN _twi_bmp085_data,6
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,7
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC4,R30
	STS  _AC4+1,R31
;AC5=(twi_bmp085_data.AC5.msb<<8)+twi_bmp085_data.AC5.lsb; //
	__GETB1HMN _twi_bmp085_data,8
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,9
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC5,R30
	STS  _AC5+1,R31
;AC6=(twi_bmp085_data.AC6.msb<<8)+twi_bmp085_data.AC6.lsb;//
	__GETB1HMN _twi_bmp085_data,10
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,11
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _AC6,R30
	STS  _AC6+1,R31
;B1=(twi_bmp085_data.B1.msb<<8)+twi_bmp085_data.B1.lsb;
	__GETB1HMN _twi_bmp085_data,12
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,13
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _B1,R30
	STS  _B1+1,R31
;B2=(twi_bmp085_data.B2.msb<<8)+twi_bmp085_data.B2.lsb;
	__GETB1HMN _twi_bmp085_data,14
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,15
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _B2,R30
	STS  _B2+1,R31
;MB=(twi_bmp085_data.MB.msb<<8)+twi_bmp085_data.MB.lsb;
	__GETB1HMN _twi_bmp085_data,16
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,17
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _MB,R30
	STS  _MB+1,R31
;MC=(twi_bmp085_data.MC.msb<<8)+twi_bmp085_data.MC.lsb;//
	__GETB1HMN _twi_bmp085_data,18
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,19
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _MC,R30
	STS  _MC+1,R31
;MD=(twi_bmp085_data.MD.msb<<8)+twi_bmp085_data.MD.lsb;//
	__GETB1HMN _twi_bmp085_data,20
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _twi_bmp085_data,21
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _MD,R30
	STS  _MD+1,R31
;
;//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
;
;
;
;
;
;
;
;
;}
	RET
; .FEND
;
;//
;void read_bmp(void)
;{
_read_bmp:
; .FSTART _read_bmp
;/////////////////////////////MEASUREMENT//////////////////////////////////////////////////////
;//запрос температуры
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_temp_please,
;    2,
;    0,
;    0                     );
	CALL SUBOPT_0x66
	LDI  R30,LOW(119)
	ST   -Y,R30
	LDI  R30,LOW(_read_temp_please)
	LDI  R31,HIGH(_read_temp_please)
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//пауза
;//ожидание сигнал по линии OEC
;//while((PORTE.IN&0b00000100)==0b00000000)
;//{
;//;
;//}
;delay_ms(26);
;
;//адреса и данные
;
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_temp_adr,
;    2,
;    (unsigned char *)&read_temp_data,
;    2                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	LDI  R30,LOW(_read_temp_adr)
	LDI  R31,HIGH(_read_temp_adr)
	CALL SUBOPT_0x67
	LDI  R30,LOW(_read_temp_data)
	LDI  R31,HIGH(_read_temp_data)
	CALL SUBOPT_0x68
;
;//??????????????????????????????????????????????????????????????????????????????????????????????
;
;//запрос давления
;
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_pres_please,
;    2,
;    0,
;    0                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	LDI  R30,LOW(_read_pres_please)
	LDI  R31,HIGH(_read_pres_please)
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
;//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;//пауза
;//ожидание по OEC
;//
;delay_ms(26);
;//while((PORTE.IN&0b00000100)==0b00000000)
;//{
;//;
;//}
;
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_pres_adr.msb,
;    1,
;    (unsigned char *)&read_pres_data.msb,
;    1                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	LDI  R30,LOW(_read_pres_adr)
	LDI  R31,HIGH(_read_pres_adr)
	CALL SUBOPT_0x6A
	LDI  R30,LOW(_read_pres_data)
	LDI  R31,HIGH(_read_pres_data)
	CALL SUBOPT_0x6B
;
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_pres_adr.lsb,
;    1,
;    (unsigned char *)&read_pres_data.lsb,
;    1                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _read_pres_adr,1
	CALL SUBOPT_0x6A
	__POINTW1MN _read_pres_data,1
	CALL SUBOPT_0x6B
;
;twi_master_trans (
;    &twie_master,
;    BMP085_TWI_BUS_ADDRESS,
;    (unsigned char *)&read_pres_adr.xlsb,
;    1,
;    (unsigned char *)&read_pres_data.xlsb,
;    1                     );
	LDI  R30,LOW(119)
	ST   -Y,R30
	__POINTW1MN _read_pres_adr,2
	CALL SUBOPT_0x6A
	__POINTW1MN _read_pres_data,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _twi_master_trans
;
;/////////////////////////////MEASUREMENT//////////////////////////////////////////////////////
;
;
;//////////////////////////////////////CALC////////////////////////////////////////////////////
;//собираем регистр температуры
;UT=(read_temp_data.msb<<8)+read_temp_data.lsb;
	LDS  R27,_read_temp_data
	LDI  R26,LOW(0)
	__GETB1MN _read_temp_data,1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL __CWD1
	STS  _UT,R30
	STS  _UT+1,R31
	STS  _UT+2,R22
	STS  _UT+3,R23
;UP= read_pres_data.msb;
	LDS  R30,_read_pres_data
	CLR  R31
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x6C
;UP<<=8;
	CALL SUBOPT_0x6D
	LDI  R30,LOW(8)
	CALL __LSLD12
	CALL SUBOPT_0x6C
;UP=UP+read_pres_data.lsb;
	__GETB1MN _read_pres_data,1
	LDI  R31,0
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x59
	CALL SUBOPT_0x6C
;UP<<=8;
	CALL SUBOPT_0x6D
	LDI  R30,LOW(8)
	CALL __LSLD12
	CALL SUBOPT_0x6C
;UP=UP+read_pres_data.xlsb;
	__GETB1MN _read_pres_data,2
	LDI  R31,0
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x59
	CALL SUBOPT_0x6C
;UP>>=(8-oss);
	LDS  R26,_oss
	LDI  R30,LOW(8)
	SUB  R30,R26
	CALL SUBOPT_0x6D
	CALL __ASRD12
	CALL SUBOPT_0x6C
;
;///////////////_TTTTT_/////////////
;X1=((UT-AC6)*AC5)>>15;
	LDS  R30,_AC6
	LDS  R31,_AC6+1
	LDS  R26,_UT
	LDS  R27,_UT+1
	LDS  R24,_UT+2
	LDS  R25,_UT+3
	CLR  R22
	CLR  R23
	CALL __SUBD21
	LDS  R30,_AC5
	LDS  R31,_AC5+1
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x6E
	LDI  R30,LOW(15)
	CALL SUBOPT_0x6F
;X2=((long)MC<<11)/(X1+MD);
	LDS  R26,_MC
	LDS  R27,_MC+1
	CALL __CWD2
	LDI  R30,LOW(11)
	CALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_MD
	LDS  R31,_MD+1
	CALL SUBOPT_0x70
	CALL SUBOPT_0x59
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVD21
	CALL SUBOPT_0x71
;B5=(X1+X2);
	STS  _B5,R30
	STS  _B5+1,R31
	STS  _B5+2,R22
	STS  _B5+3,R23
;Temp=((B5+8)>>4);
	CALL SUBOPT_0x72
	__ADDD1N 8
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(4)
	CALL __ASRD12
	STS  _Temp,R30
	STS  _Temp+1,R31
	STS  _Temp+2,R22
	STS  _Temp+3,R23
;Tempf=Temp/10.0;
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x73
	CALL __DIVF21
	STS  _Tempf,R30
	STS  _Tempf+1,R31
	STS  _Tempf+2,R22
	STS  _Tempf+3,R23
;///////////////_TTTTT_/////////////
;
;//////////////_PPPPPPP_////////////
;B6=B5-4000;
	CALL SUBOPT_0x72
	__SUBD1N 4000
	STS  _B6,R30
	STS  _B6+1,R31
	STS  _B6+2,R22
	STS  _B6+3,R23
;X1=(B2*(B6*B6)>>12)>>11;
	CALL SUBOPT_0x74
	CALL SUBOPT_0x75
	CALL __MULD12
	LDS  R26,_B2
	LDS  R27,_B2+1
	CALL SUBOPT_0x76
	LDI  R30,LOW(12)
	CALL __ASRD12
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(11)
	CALL SUBOPT_0x6F
;X2=(AC2*B6)>>11;
	CALL SUBOPT_0x74
	LDS  R26,_AC2
	LDS  R27,_AC2+1
	CALL SUBOPT_0x76
	LDI  R30,LOW(11)
	CALL __ASRD12
	CALL SUBOPT_0x71
;X3=X1+X2;
	CALL SUBOPT_0x77
;B3=    ((( ((signed long)AC1)*4 + X3)<<oss) + 2)>>2;
	LDS  R26,_AC1
	LDS  R27,_AC1+1
	CALL __CWD2
	__GETD1N 0x4
	CALL __MULD12
	LDS  R26,_X3
	LDS  R27,_X3+1
	LDS  R24,_X3+2
	LDS  R25,_X3+3
	CALL __ADDD21
	LDS  R30,_oss
	CALL __LSLD12
	CALL SUBOPT_0x78
	STS  _B3,R30
	STS  _B3+1,R31
	STS  _B3+2,R22
	STS  _B3+3,R23
;X1=(AC3*B6)>>13;
	CALL SUBOPT_0x74
	LDS  R26,_AC3
	LDS  R27,_AC3+1
	CALL SUBOPT_0x76
	LDI  R30,LOW(13)
	CALL SUBOPT_0x6F
;X2 = (B1 * ((B6 * B6)>>12))>>16;
	CALL SUBOPT_0x74
	CALL SUBOPT_0x75
	CALL SUBOPT_0x6E
	LDI  R30,LOW(12)
	CALL __ASRD12
	LDS  R26,_B1
	LDS  R27,_B1+1
	CALL __CWD2
	CALL SUBOPT_0x79
	CALL SUBOPT_0x71
;X3 = ((X1 + X2) + 2)>>2;
	CALL SUBOPT_0x78
	CALL SUBOPT_0x77
;B4 = (AC4 * (unsigned long)(X3 + 32768))>>15;
	LDS  R30,_X3
	LDS  R31,_X3+1
	LDS  R22,_X3+2
	LDS  R23,_X3+3
	__ADDD1N 32768
	LDS  R26,_AC4
	LDS  R27,_AC4+1
	CLR  R24
	CLR  R25
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(15)
	CALL __LSRD12
	STS  _B4,R30
	STS  _B4+1,R31
	STS  _B4+2,R22
	STS  _B4+3,R23
;B7 = ((unsigned long)(UP - B3) * (50000>>oss));
	LDS  R26,_B3
	LDS  R27,_B3+1
	LDS  R24,_B3+2
	LDS  R25,_B3+3
	LDS  R30,_UP
	LDS  R31,_UP+1
	LDS  R22,_UP+2
	LDS  R23,_UP+3
	CALL __SUBD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_oss
	LDI  R26,LOW(50000)
	LDI  R27,HIGH(50000)
	CALL __LSRW12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CLR  R22
	CLR  R23
	CALL __MULD12U
	STS  _B7,R30
	STS  _B7+1,R31
	STS  _B7+2,R22
	STS  _B7+3,R23
;if (B7 < 0x80000000){p = (B7<<1)/B4;}
	CALL SUBOPT_0x7A
	__CPD2N 0x80000000
	BRSH _0x194
	LDS  R30,_B7
	LDS  R31,_B7+1
	LDS  R22,_B7+2
	LDS  R23,_B7+3
	CALL __LSLD1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x7B
	CALL __DIVD21U
	RJMP _0x227
;else {p = (B7/B4)<<1;}
_0x194:
	CALL SUBOPT_0x7B
	CALL SUBOPT_0x7A
	CALL __DIVD21U
	CALL __LSLD1
_0x227:
	STS  _p,R30
	STS  _p+1,R31
	STS  _p+2,R22
	STS  _p+3,R23
;X1=(p>>8)*(p>>8);
	CALL SUBOPT_0x7C
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x7C
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __MULD12
	CALL SUBOPT_0x7D
;X1=(X1*3038)>>16;
	LDS  R30,_X1
	LDS  R31,_X1+1
	LDS  R22,_X1+2
	LDS  R23,_X1+3
	__GETD2N 0xBDE
	CALL SUBOPT_0x79
	CALL SUBOPT_0x7D
;X2=(-7357*p)>>16;
	CALL SUBOPT_0x7E
	__GETD2N 0xFFFFE343
	CALL SUBOPT_0x79
	CALL SUBOPT_0x71
;p+=(X1+X2+3791)>>4;
	__ADDD1N 3791
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(4)
	CALL __ASRD12
	CALL SUBOPT_0x7F
	CALL __ADDD12
	STS  _p,R30
	STS  _p+1,R31
	STS  _p+2,R22
	STS  _p+3,R23
;p1=p/133.322;
	CALL SUBOPT_0x7E
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x4305526F
	CALL __DIVF21
	STS  _p1,R30
	STS  _p1+1,R31
	STS  _p1+2,R22
	STS  _p1+3,R23
;//////////////_PPPPPPP_////////////
;}
	RET
; .FEND
;
;#include "PCA9557D.c"
;//адреса наших микросхем
;#define PCA9557D_U1 (0x30>>1)
;#define PCA9557D_U2 (0x32>>1)
;#define PCA9557D_U3 (0x34>>1)
;//необходимые библиотеки
;#include <io.h>
;#include <stdio.h>
;
;char error_buf=0;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char input;
;            } U1in;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char output;
;            } U1out;
;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char io;
;            } U1io;
;
;         struct
;            {
;            unsigned char control;
;            unsigned char data;
;            } U1ne_invert;
;         ////////////////////////////////U1////////////////////////////////////
;
;         ////////////////////////////////U2////////////////////////////////////
;        struct
;            {
;            unsigned char control;
;            unsigned char input;
;            } U2in;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char output;
;            } U2out;
;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char io;
;            } U2io;
;
;         struct
;            {
;            unsigned char control;
;            unsigned char data;
;            } U2ne_invert;
;         ////////////////////////////////U2////////////////////////////////////
;
;          ////////////////////////////////U3////////////////////////////////////
;        struct
;            {
;            unsigned char control;
;            unsigned char input;
;            } U3in;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char output;
;            } U3out;
;
;
;        struct
;            {
;            unsigned char control;
;            unsigned char io;
;            } U3io;
;
;         struct
;            {
;            unsigned char control;
;            unsigned char data;
;            } U3ne_invert;
;         ////////////////////////////////U3////////////////////////////////////
;
;
;///////////////////111111111111111111111111111111111111111111111111//////////////////////////////////
;
;
;//из буфера U1 мы читаем биты 1,4,5
;//пишим биты 0,2,3,6,7
;//настройка конфигурации =0x32
;
;//инициализация буфера U1
;void init_buferU1 (void)
; 0000 0018 {
_init_buferU1:
; .FSTART _init_buferU1
;//запрещаем инверсию
;
;U1ne_invert.control=0x02;
	LDI  R30,LOW(2)
	STS  _U1ne_invert,R30
;U1ne_invert.data=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _U1ne_invert,1
;
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U1,
;    (unsigned char *)&U1ne_invert,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(24)
	ST   -Y,R30
	LDI  R30,LOW(_U1ne_invert)
	LDI  R31,HIGH(_U1ne_invert)
	CALL SUBOPT_0x67
	CALL SUBOPT_0x80
;
;//настройка входов выходов
;U1io.control=0x03;
	STS  _U1io,R30
;U1io.io=0x32;   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	LDI  R30,LOW(50)
	__PUTB1MN _U1io,1
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U1,
;    (unsigned char *)&U1io,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(24)
	ST   -Y,R30
	LDI  R30,LOW(_U1io)
	LDI  R31,HIGH(_U1io)
	RJMP _0x2100027
;}
; .FEND
;
;//опрос буфера U1
;void buferU1_opros(void)
;{
_buferU1_opros:
; .FSTART _buferU1_opros
;U1in.control=0x00;
	LDI  R30,LOW(0)
	STS  _U1in,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U1,
;    (unsigned char *)&U1in.control,1,
;    (unsigned char *)&U1in.input, 1);
	CALL SUBOPT_0x66
	LDI  R30,LOW(24)
	ST   -Y,R30
	LDI  R30,LOW(_U1in)
	LDI  R31,HIGH(_U1in)
	CALL SUBOPT_0x6A
	__POINTW1MN _U1in,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _0x2100026
;//ответ храниться в U1in.input
;}
; .FEND
;
;//установка выходов буфера U1
;//значение должно храниться в U1out.output
;void buferU1_set(void)
;{
_buferU1_set:
; .FSTART _buferU1_set
;U1out.control=0x01;
	LDI  R30,LOW(1)
	STS  _U1out,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U1,
;    (unsigned char *)&U1out,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(24)
	ST   -Y,R30
	LDI  R30,LOW(_U1out)
	LDI  R31,HIGH(_U1out)
	RJMP _0x2100027
;}
; .FEND
;
;
;//из буфера U2 мы читаем биты 7,3,4
;//пишим биты 0,1,2,5,6
;//настройка конфигурации =0x98
;
;//инициализация буфера U2
;void init_buferU2 (void)
;{
_init_buferU2:
; .FSTART _init_buferU2
;//запрещаем инверсию
;U2ne_invert.control=0x02;
	LDI  R30,LOW(2)
	STS  _U2ne_invert,R30
;U2ne_invert.data=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _U2ne_invert,1
;
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U2,
;    (unsigned char *)&U2ne_invert,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(25)
	ST   -Y,R30
	LDI  R30,LOW(_U2ne_invert)
	LDI  R31,HIGH(_U2ne_invert)
	CALL SUBOPT_0x67
	CALL SUBOPT_0x80
;
;//настройка входов выходов
;U2io.control=0x03;
	STS  _U2io,R30
;U2io.io=0x98;
	LDI  R30,LOW(152)
	__PUTB1MN _U2io,1
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U2,
;    (unsigned char *)&U2io,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(25)
	ST   -Y,R30
	LDI  R30,LOW(_U2io)
	LDI  R31,HIGH(_U2io)
	RJMP _0x2100027
;}
; .FEND
;
;//опрос буфера U2
;void buferU2_opros(void)
;{
_buferU2_opros:
; .FSTART _buferU2_opros
;U2in.control=0x00;
	LDI  R30,LOW(0)
	STS  _U2in,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U2,
;    (unsigned char *)&U2in.control,1,
;    (unsigned char *)&U2in.input, 1);
	CALL SUBOPT_0x66
	LDI  R30,LOW(25)
	ST   -Y,R30
	LDI  R30,LOW(_U2in)
	LDI  R31,HIGH(_U2in)
	CALL SUBOPT_0x6A
	__POINTW1MN _U2in,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _0x2100026
;//ответ храниться в U2in.input
;}
; .FEND
;
;
;
;//установка выходов буфера U2
;//значение должно храниться в U2out.output
;void buferU2_set(void)
;{
_buferU2_set:
; .FSTART _buferU2_set
;U2out.control=0x01;
	LDI  R30,LOW(1)
	STS  _U2out,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U2,
;    (unsigned char *)&U2out,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(25)
	ST   -Y,R30
	LDI  R30,LOW(_U2out)
	LDI  R31,HIGH(_U2out)
	RJMP _0x2100027
;}
; .FEND
;
;///////////////////2222222222222222222222222222222222222222222222222222//////////////////////////////
;
;
;
;
;
;///////////////////333333333333333333333333333333333333333333333333333//////////////////////////////////
;
;
;//из буфера U3 мы читаем биты 6
;//пишим биты 0,1,2,3,4,5,7
;//настройка конфигурации =0x40
;
;//инициализация буфера U3
;void init_buferU3 (void)
;{
_init_buferU3:
; .FSTART _init_buferU3
;//запрещаем инверсию
;U3ne_invert.control=0x02;
	LDI  R30,LOW(2)
	STS  _U3ne_invert,R30
;U3ne_invert.data=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _U3ne_invert,1
;
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U3,
;    (unsigned char *)&U3ne_invert,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(26)
	ST   -Y,R30
	LDI  R30,LOW(_U3ne_invert)
	LDI  R31,HIGH(_U3ne_invert)
	CALL SUBOPT_0x67
	CALL SUBOPT_0x80
;
;//настройка входов выходов
;U3io.control=0x03;
	STS  _U3io,R30
;U3io.io=0x40;
	LDI  R30,LOW(64)
	__PUTB1MN _U3io,1
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U3,
;    (unsigned char *)&U3io,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(26)
	ST   -Y,R30
	LDI  R30,LOW(_U3io)
	LDI  R31,HIGH(_U3io)
	RJMP _0x2100027
;}
; .FEND
;
;//опрос буфера U3
;void buferU3_opros(void)
;{
_buferU3_opros:
; .FSTART _buferU3_opros
;U3in.control=0x00;
	LDI  R30,LOW(0)
	STS  _U3in,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U3,
;    (unsigned char *)&U3in.control,1,
;    (unsigned char *)&U3in.input, 1);
	CALL SUBOPT_0x66
	LDI  R30,LOW(26)
	ST   -Y,R30
	LDI  R30,LOW(_U3in)
	LDI  R31,HIGH(_U3in)
	CALL SUBOPT_0x6A
	__POINTW1MN _U3in,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _0x2100026
;//ответ храниться в U3in.input
;}
; .FEND
;
;
;
;//установка выходов буфера U3
;//значение должно храниться в U2out.output
;void buferU3_set(void)
;{
_buferU3_set:
; .FSTART _buferU3_set
;U3out.control=0x01;
	LDI  R30,LOW(1)
	STS  _U3out,R30
;twi_master_trans(
;     &twie_master,
;     PCA9557D_U3,
;    (unsigned char *)&U3out,2,
;    0, 0);
	CALL SUBOPT_0x66
	LDI  R30,LOW(26)
	ST   -Y,R30
	LDI  R30,LOW(_U3out)
	LDI  R31,HIGH(_U3out)
_0x2100027:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
_0x2100026:
	CALL _twi_master_trans
;}
	RET
; .FEND
;
;///////////////////333333333333333333333333333333333333333333333333333333//////////////////////////////
;#include "ad7705.c"
;#include <io.h>
;#include <delay.h>
;#include <stdio.h>
;
;#define Uop 1.6 //опорное напряжение
;
;unsigned char chan=1;   //default канал 1

	.DSEG
;
;#define can1cl 0x20     //активный первый канал, след операция настройка частоты (byte1)
;#define mclk4 0x0C      //0x0C для кварца 4,9М , 0x04 для (2,4M)             byte2
;#define mclk2 0x04      //   byte2
;#define can1set 0x10    //активный первый канал, след операция настройка ацп  byte3
;#define set1 0x40       // gain = 1, bipolar mode,    byte4
;//buffer off, clear FSYNC and perform a Self Calibration
;#define set2 0x04       // gain = 1, unipolar mode,    byte4
;//buffer off, normal mode
;
;#define can2cl 0x21  // активный второй канал, след операция настройка частоты (byte1)
;#define can2set 0x11 //   активный воторой канал, след операция настройка ацп  byte3
;
;
;
;//ad7705_init(can1cl,mclk4,can1set,set1); например
;
;int RESULT;
;int RESULT_buf;
;long int RESULT_sr;
;//измерений
;char RESULT_count;
;
;
;
;
;void ad7705_init (unsigned char by1,unsigned char by2,unsigned char by3, unsigned char by4)
; 0000 0019 {

	.CSEG
_ad7705_init:
; .FSTART _ad7705_init
;
;//Выставляем сигнал CS в 0
;PORTC.OUTCLR = 0b00010000;
	ST   -Y,R26
;	by1 -> Y+3
;	by2 -> Y+2
;	by3 -> Y+1
;	by4 -> Y+0
	LDI  R30,LOW(16)
	STS  1606,R30
;//Отправляем по SPI четыре байта настройки
;spic_master_tx_rx(by1);
	LDD  R26,Y+3
	RCALL _spic_master_tx_rx
;spic_master_tx_rx(by2);
	LDD  R26,Y+2
	RCALL _spic_master_tx_rx
;spic_master_tx_rx(by3);
	LDD  R26,Y+1
	RCALL _spic_master_tx_rx
;spic_master_tx_rx(by4);
	LD   R26,Y
	RCALL _spic_master_tx_rx
;// Ждем пока DRDY не станет 0.
;// Как только DRDY = 0, АЦП настроен.
;// С этого момента DRDY будет меняться то в 1 то в 0.
;
;
;while((PORTC.IN|0b11111101)==0b11111111);
_0x197:
	LDS  R30,1608
	ORI  R30,LOW(0xFD)
	CPI  R30,LOW(0xFF)
	BREQ _0x197
;// переводим CS в 1.
;PORTC.OUTSET = 0b00010000;
	LDI  R30,LOW(16)
	STS  1605,R30
;}
	ADIW R28,4
	RET
; .FEND
;
;
;int ad7705 (unsigned char chanel)
;{
_ad7705:
; .FSTART _ad7705
;unsigned int ti;
;
;
;short data_h,data_l;
;
;//проверка активного канала
;if ((chanel!=chan)&&(chanel==1||chanel==2))
	ST   -Y,R26
	CALL __SAVELOCR6
;	chanel -> Y+6
;	ti -> R16,R17
;	data_h -> R18,R19
;	data_l -> R20,R21
	LDS  R30,_chan
	LDD  R26,Y+6
	CP   R30,R26
	BREQ _0x19B
	CPI  R26,LOW(0x1)
	BREQ _0x19C
	CPI  R26,LOW(0x2)
	BRNE _0x19B
_0x19C:
	RJMP _0x19E
_0x19B:
	RJMP _0x19A
_0x19E:
;{
;//настройка каналов на биполярный режим
;    if (chanel==1)  ad7705_init(can1cl,mclk4,can1set,set1);
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x19F
	CALL SUBOPT_0x81
;    if (chanel==2)  ad7705_init(can2cl,mclk4,can2set,set1);
_0x19F:
	LDD  R26,Y+6
	CPI  R26,LOW(0x2)
	BRNE _0x1A0
	LDI  R30,LOW(33)
	ST   -Y,R30
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(17)
	ST   -Y,R30
	LDI  R26,LOW(64)
	RCALL _ad7705_init
;
;}
_0x1A0:
;
;//глобальная
;chan=chanel;
_0x19A:
	LDD  R30,Y+6
	STS  _chan,R30
;
;//for (ti=0;ti<50000;ti++)
;//if((PORTC.IN|0b11111101)==0b11111111) delay_us(1);
;//else ti=60000;
;
;//if(ti==60000)
;//{
;KALC_PULS=0;
	CLR  R8
	CLR  R9
;while(((PORTC.IN|0b11111101)==0b11111111)&&(KALC_PULS<20000)) {KALC_PULS++;delay_us(1);}
_0x1A1:
	LDS  R30,1608
	ORI  R30,LOW(0xFD)
	CPI  R30,LOW(0xFF)
	BRNE _0x1A4
	LDI  R30,LOW(20000)
	LDI  R31,HIGH(20000)
	CP   R8,R30
	CPC  R9,R31
	BRLO _0x1A5
_0x1A4:
	RJMP _0x1A3
_0x1A5:
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	__DELAY_USB 11
	RJMP _0x1A1
_0x1A3:
;//Выставляем сигнал CS в 0
;if(KALC_PULS==20000)
	LDI  R30,LOW(20000)
	LDI  R31,HIGH(20000)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x1A6
;{
;//PORTC.OUTCLR = 0b00010000;
;//delay_us(10);
;//запрос
;//spic_master_tx_rx(0x38);
;//ответ
;//data_h=spic_master_tx_rx(0xFF);
;//data_l=spic_master_tx_rx(0xFF);
;//Выставляем сигнал CS в 1
;//PORTC.OUTSET = 0b00010000;
;//Ответ длинною 16 бит
;//if (chanel==1)  ad7705_init(can1cl,mclk4,can1set,set1);
;//if (chanel==2)  ad7705_init(can2cl,mclk4,can2set,set1);
;//while((PORTC.IN|0b11111101)==0b11111111);
;return(0x03FF);
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	RJMP _0x2100025
;}
;
;else
_0x1A6:
;{
;PORTC.OUTCLR = 0b00010000;
	LDI  R30,LOW(16)
	STS  1606,R30
;
;delay_us(10);
	__DELAY_USB 107
;//запрос
;spic_master_tx_rx(0x38);
	LDI  R26,LOW(56)
	RCALL _spic_master_tx_rx
;//ответ
;data_h=spic_master_tx_rx(0xFF);
	LDI  R26,LOW(255)
	RCALL _spic_master_tx_rx
	MOV  R18,R30
	CLR  R19
;data_l=spic_master_tx_rx(0xFF);
	LDI  R26,LOW(255)
	RCALL _spic_master_tx_rx
	MOV  R20,R30
	CLR  R21
;//Выставляем сигнал CS в 1
;PORTC.OUTSET = 0b00010000;
	LDI  R30,LOW(16)
	STS  1605,R30
;//Ответ длинною 16 бит
;
;return(data_h<<8|data_l);
	MOV  R31,R18
	LDI  R30,LOW(0)
	OR   R30,R20
	OR   R31,R21
;//return((data_h*256+data_l)*Uop/32768.0);
;//}
;//else return(0xFF<<8|0xFF);
;}
;
;}
_0x2100025:
	CALL __LOADLOCR6
	ADIW R28,7
	RET
; .FEND
;#include "ISR.c"
;//функция создания нового файла
;//анализ даты для нового файла в суточках
;void GETFILNAME (void)
; 0000 001A {
_GETFILNAME:
; .FSTART _GETFILNAME
;char po;
;char da=0;
;char newfNAME[15];
;sprintf(newfNAME,"0:/%ld.bin",date1);
	SBIW R28,15
	ST   -Y,R17
	ST   -Y,R16
;	po -> R17
;	da -> R16
;	newfNAME -> Y+2
	LDI  R16,0
	MOVW R30,R28
	ADIW R30,2
	CALL SUBOPT_0x82
;for(po=0;po<11;po++)
	LDI  R17,LOW(0)
_0x1A9:
	CPI  R17,11
	BRSH _0x1AA
;if(newfNAME[po]!=fNAME[po]) {da=1;po=12;}
	CALL SUBOPT_0x83
	LD   R26,X
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_fNAME)
	SBCI R31,HIGH(-_fNAME)
	LD   R30,Z
	CP   R30,R26
	BREQ _0x1AB
	LDI  R16,LOW(1)
	LDI  R17,LOW(12)
;
;if (da)
_0x1AB:
	SUBI R17,-1
	RJMP _0x1A9
_0x1AA:
	CPI  R16,0
	BREQ _0x1AC
;{
;for(po=0;po<15;po++)
	LDI  R17,LOW(0)
_0x1AE:
	CPI  R17,15
	BRSH _0x1AF
;fNAME[po]=newfNAME[po];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_fNAME)
	SBCI R31,HIGH(-_fNAME)
	MOVW R0,R30
	CALL SUBOPT_0x83
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	SUBI R17,-1
	RJMP _0x1AE
_0x1AF:
	CALL SUBOPT_0x84
	LDI  R26,LOW(3)
	CALL SUBOPT_0x85
	CPI  R30,0
	BREQ _0x228
;else
;{
;res = f_open(&file,fNAME,FA_CREATE_ALWAYS | FA_WRITE);
	CALL SUBOPT_0x84
	LDI  R26,LOW(10)
	CALL SUBOPT_0x85
;res=f_close(&file);
_0x228:
	LDI  R26,LOW(_file)
	LDI  R27,HIGH(_file)
	CALL SUBOPT_0x86
;}
;}
;else ;
_0x1AC:
;
;}
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,17
	RET
; .FEND
;
;void bufform (void)
;{
_bufform:
; .FSTART _bufform
;char i;
;char tim[6];
;char potok[36];
;//время
;sprintf(tim,"%6ld",time1);
	SBIW R28,42
	ST   -Y,R17
;	i -> R17
;	tim -> Y+37
;	potok -> Y+1
	MOVW R30,R28
	ADIW R30,37
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,230
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x5B
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
;//////начало маркер
;potok[0]=0xF4;
	LDI  R30,LOW(244)
	STD  Y+1,R30
;
;for(i=1;i<7;i++)
	LDI  R17,LOW(1)
_0x1B4:
	CPI  R17,7
	BRSH _0x1B5
;potok[i]=tim[i-1];
	CALL SUBOPT_0x87
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOV  R30,R17
	LDI  R31,0
	SBIW R30,1
	MOVW R26,R28
	ADIW R26,37
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	SUBI R17,-1
	RJMP _0x1B4
_0x1B5:
	LDI  R30,LOW(165)
	STD  Y+8,R30
;
;potok[8]=potok1[8];
	__GETB1MN _potok1,8
	STD  Y+9,R30
;potok[9]=potok1[9];
	__GETB1MN _potok1,9
	STD  Y+10,R30
;potok[10]=potok1[10];
	__GETB1MN _potok1,10
	STD  Y+11,R30
;potok[11]=potok1[11];
	__GETB1MN _potok1,11
	STD  Y+12,R30
;potok[12]=potok1[12];
	__GETB1MN _potok1,12
	STD  Y+13,R30
;potok[13]=potok1[13];
	__GETB1MN _potok1,13
	STD  Y+14,R30
;potok[14]=potok1[14];
	__GETB1MN _potok1,14
	STD  Y+15,R30
;potok[15]=potok1[15];
	__GETB1MN _potok1,15
	STD  Y+16,R30
;potok[16]=potok1[16];
	__GETB1MN _potok1,16
	STD  Y+17,R30
;potok[17]=potok1[17];
	__GETB1MN _potok1,17
	STD  Y+18,R30
;potok[18]=S0[11];
	__GETB1MN _S0,11
	STD  Y+19,R30
;potok[19]=S0[12];
	__GETB1MN _S0,12
	STD  Y+20,R30
;potok[20]=potok1[20];
	__GETB1MN _potok1,20
	STD  Y+21,R30
;potok[21]=potok1[21];
	__GETB1MN _potok1,21
	STD  Y+22,R30
;potok[22]=S0[15];
	__GETB1MN _S0,15
	STD  Y+23,R30
;potok[23]=S0[16];
	__GETB1MN _S0,16
	STD  Y+24,R30
;potok[24]=potok1[24];
	__GETB1MN _potok1,24
	STD  Y+25,R30
;potok[25]=potok1[25];
	__GETB1MN _potok1,25
	STD  Y+26,R30
;potok[26]=potok1[26];
	__GETB1MN _potok1,26
	STD  Y+27,R30
;potok[27]=potok1[27];
	__GETB1MN _potok1,27
	STD  Y+28,R30
;potok[28]=S0[21];
	__GETB1MN _S0,21
	STD  Y+29,R30
;potok[29]=S0[22];
	__GETB1MN _S0,22
	STD  Y+30,R30
;potok[30]=0xB5;
	LDI  R30,LOW(181)
	STD  Y+31,R30
;
;for(i=31;i<31+4;i++)
	LDI  R17,LOW(31)
_0x1B7:
	CPI  R17,35
	BRSH _0x1B8
;{
;potok[i]=B5buf[i-31];
	CALL SUBOPT_0x87
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R17
	LDI  R31,0
	SBIW R30,31
	SUBI R30,LOW(-_B5buf)
	SBCI R31,HIGH(-_B5buf)
	LD   R30,Z
	ST   X,R30
;}
	SUBI R17,-1
	RJMP _0x1B7
_0x1B8:
;
;
;potok[35]=0xF8;
	LDI  R30,LOW(248)
	STD  Y+36,R30
;memset(B5buf,0,4);
	LDI  R30,LOW(_B5buf)
	LDI  R31,HIGH(_B5buf)
	CALL SUBOPT_0x65
	LDI  R26,LOW(4)
	LDI  R27,0
	CALL _memset
;for(i=0;i<36;i++)
	LDI  R17,LOW(0)
_0x1BA:
	CPI  R17,36
	BRSH _0x1BB
;{
;buffer[i]=potok[i];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_buffer)
	SBCI R31,HIGH(-_buffer)
	MOVW R0,R30
	CALL SUBOPT_0x87
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
;}
	SUBI R17,-1
	RJMP _0x1BA
_0x1BB:
;
;}
	LDD  R17,Y+0
	ADIW R28,43
	RET
; .FEND
;
;void check_sd_card (void)
;{
_check_sd_card:
; .FSTART _check_sd_card
;
;if ((res=f_mount(0,&fat))==FR_OK)
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(_fat)
	LDI  R27,HIGH(_fat)
	CALL _f_mount
	STS  _res,R30
	CPI  R30,0
	BRNE _0x1BC
;
;{
;sprintf(info,"Logical drive 0: mounted OK\r\n",);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,235
	CALL SUBOPT_0x88
;monitor();
	CALL SUBOPT_0x89
;delay_ms(100);
;}
;
;else
	RJMP _0x1BD
_0x1BC:
;  error(res);
	CALL SUBOPT_0x8A
;
;if ((res=f_open(&file,path,FA_CREATE_ALWAYS | FA_WRITE))==FR_OK)
_0x1BD:
	CALL SUBOPT_0x8B
	LDI  R30,LOW(_path)
	LDI  R31,HIGH(_path)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(10)
	CALL SUBOPT_0x85
	CPI  R30,0
	BRNE _0x1BE
;   {
;   sprintf(info,"File %s created OK\r\n",path);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,265
	CALL SUBOPT_0x8C
;   monitor();
;   SD_IN=1;
	LDI  R30,LOW(1)
	STS  _SD_IN,R30
;   }
;else
	RJMP _0x1BF
_0x1BE:
;   {
;   error(res);
	CALL SUBOPT_0x8A
;   SD_IN=0;
	LDI  R30,LOW(0)
	STS  _SD_IN,R30
;   TCF0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_OFF_gc;
	STS  2822,R30
;   }
_0x1BF:
;
;
;if (SD_IN==1)
	LDS  R26,_SD_IN
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x1C0
;{
;sprintf(SD,"this is test",);
	LDI  R30,LOW(_SD)
	LDI  R31,HIGH(_SD)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,286
	CALL SUBOPT_0x88
;SD[13]=0x0D;
	LDI  R30,LOW(13)
	__PUTB1MN _SD,13
;SD[14]=0x0A;
	LDI  R30,LOW(10)
	__PUTB1MN _SD,14
;
;if ((res=f_write(&file,SD,sizeof(SD)-1,&nbytes))==FR_OK)
	CALL SUBOPT_0x8B
	LDI  R30,LOW(_SD)
	LDI  R31,HIGH(_SD)
	CALL SUBOPT_0x8D
	BRNE _0x1C1
; {
;   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(SD)-1);
	CALL SUBOPT_0x62
	CALL SUBOPT_0x8E
;   monitor();
;   }
;else
	RJMP _0x1C2
_0x1C1:
;   //
;   error(res);
	CALL SUBOPT_0x8A
;
;sprintf(SD1,"file sd card",);
_0x1C2:
	LDI  R30,LOW(_SD1)
	LDI  R31,HIGH(_SD1)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,324
	CALL SUBOPT_0x88
;SD1[13]=0x0D;
	LDI  R30,LOW(13)
	__PUTB1MN _SD1,13
;SD1[14]=0x0A;
	LDI  R30,LOW(10)
	__PUTB1MN _SD1,14
;
;if ((res=f_write(&file,SD1,sizeof(SD1)-1,&nbytes))==FR_OK)
	CALL SUBOPT_0x8B
	LDI  R30,LOW(_SD1)
	LDI  R31,HIGH(_SD1)
	CALL SUBOPT_0x8D
	BRNE _0x1C3
;   {
;   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(SD1)-1);
	CALL SUBOPT_0x62
	CALL SUBOPT_0x8E
;   monitor();
;   }
;else
	RJMP _0x1C4
_0x1C3:
;
;   error(res);
	CALL SUBOPT_0x8A
;
;
;
;if ((res=f_close(&file))==FR_OK)
_0x1C4:
	CALL SUBOPT_0x8F
	CPI  R30,0
	BRNE _0x1C5
;   {
;   sprintf(info,"File %s closed OK\r\n",path);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,337
	CALL SUBOPT_0x8C
;   monitor();
;   }
;else
	RJMP _0x1C6
_0x1C5:
;   /* an error occured, display it and stop */
;   error(res);
	CALL SUBOPT_0x8A
;
;
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// ...
;
;get_CNTRTC(&X);
_0x1C6:
	CALL SUBOPT_0x5C
;calcDateTime(X, 0, &date1,&time1);
;sprintf(fNAME,"0:/%ld.bin",date1);
	LDI  R30,LOW(_fNAME)
	LDI  R31,HIGH(_fNAME)
	CALL SUBOPT_0x82
;
;
;bufform();
	RCALL _bufform
;
;if ((res=f_open(&file,fNAME,FA_READ)==FR_OK))
	CALL SUBOPT_0x84
	LDI  R26,LOW(1)
	CALL _f_open
	LDI  R26,LOW(0)
	CALL __EQB12
	STS  _res,R30
	CPI  R30,0
	BREQ _0x1C7
;{
;sprintf(info,"File est yze");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,357
	CALL SUBOPT_0x88
;monitor();
	CALL _monitor
;}
;else
	RJMP _0x1C8
_0x1C7:
;{
;   if ((res=f_open(&file,fNAME,FA_CREATE_ALWAYS | FA_WRITE))==FR_OK)
	CALL SUBOPT_0x84
	LDI  R26,LOW(10)
	CALL SUBOPT_0x85
	CPI  R30,0
	BRNE _0x1C9
;   {
;   sprintf(info,"File %s created OK\r\n",fNAME);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,265
	CALL SUBOPT_0x90
;   monitor();
;   }
;else
	RJMP _0x1CA
_0x1C9:
;      error(res);
	CALL SUBOPT_0x8A
;
;if ((res=f_write(&file,buffer,sizeof(buffer),&nbytes))==FR_OK)
_0x1CA:
	CALL SUBOPT_0x8B
	CALL SUBOPT_0x91
	CPI  R30,0
	BRNE _0x1CB
;
; {
;   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(buffer)-1);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,299
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_nbytes
	LDS  R31,_nbytes+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETD1N 0x23
	CALL __PUTPARD1
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
;   monitor();
	CALL _monitor
;   }
;else
	RJMP _0x1CC
_0x1CB:
;    error(res);
	CALL SUBOPT_0x8A
;
;}
_0x1CC:
_0x1C8:
;
;/*зактрыть файл*/
;if ((res=f_close(&file))==FR_OK)
	CALL SUBOPT_0x8F
	CPI  R30,0
	BRNE _0x1CD
;   {
;   sprintf(info,"File %s closed OK\r\n",fNAME);
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,337
	CALL SUBOPT_0x90
;   monitor();
;   }
;else
	RJMP _0x1CE
_0x1CD:
;
;   error(res);
	CALL SUBOPT_0x8A
;
;delay_ms(100);
_0x1CE:
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
;
;
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// ...
;}
;
;PORTC.OUTSET=0b00010001;
_0x1C0:
	LDI  R30,LOW(17)
	STS  1605,R30
;}
	RET
; .FEND
;
;
;
;
;
;
;
;// Timer/counter TCC0 Overflow/Underflow interrupt service routine
;interrupt [TCC0_OVF_vect] void tcc0_overflow_isr(void)
;{
_tcc0_overflow_isr:
; .FSTART _tcc0_overflow_isr
	CALL SUBOPT_0x46
;// write your code here
;char qw,qi;
;
;if(send&&Mx==0xFF) {topk();delay_us(5);izm=0;}
	ST   -Y,R17
	ST   -Y,R16
;	qw -> R17
;	qi -> R16
	LDS  R30,_send
	CPI  R30,0
	BREQ _0x1D0
	LDS  R26,_Mx
	CPI  R26,LOW(0xFF)
	BREQ _0x1D1
_0x1D0:
	RJMP _0x1CF
_0x1D1:
	CALL _topk
	__DELAY_USB 53
	CLR  R3
;
;
;}
_0x1CF:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x238
; .FEND
;
;// Timer/counter TCC1 Overflow/Underflow interrupt service routine
;interrupt [TCC1_OVF_vect] void tcc1_overflow_isr(void)
;{
_tcc1_overflow_isr:
; .FSTART _tcc1_overflow_isr
	CALL SUBOPT_0x46
;
;if(!izm)
	TST  R3
	BREQ PC+2
	RJMP _0x1D2
;{
;izm=1;
	LDI  R30,LOW(1)
	MOV  R3,R30
;RESULT_buf=ad7705(1);
	LDI  R26,LOW(1)
	RCALL _ad7705
	STS  _RESULT_buf,R30
	STS  _RESULT_buf+1,R31
;if(RESULT_buf<0) RESULT_buf=32768+RESULT_buf;
;else RESULT_buf=-32768+RESULT_buf;
_0x229:
	LDS  R30,_RESULT_buf
	LDS  R31,_RESULT_buf+1
	SUBI R30,LOW(-32768)
	SBCI R31,HIGH(-32768)
	STS  _RESULT_buf,R30
	STS  _RESULT_buf+1,R31
;RESULT_sr+=RESULT_buf;
	CALL SUBOPT_0x92
	CALL SUBOPT_0x59
	STS  _RESULT_sr,R30
	STS  _RESULT_sr+1,R31
	STS  _RESULT_sr+2,R22
	STS  _RESULT_sr+3,R23
;S0[7]=RESULT_buf;// Сигнал  усилителя младший
	LDS  R30,_RESULT_buf
	__PUTB1MN _S0,7
;S0[8]=(RESULT_buf>>8); //Сигнал  усилителя старший
	LDS  R30,_RESULT_buf
	LDS  R31,_RESULT_buf+1
	CALL __ASRW8
	__PUTB1MN _S0,8
;//4*2 АЦП
;for (nn=0; nn<CHANNELS; nn++)
	LDI  R30,LOW(0)
	STS  _nn,R30
_0x1D6:
	LDS  R26,_nn
	CPI  R26,LOW(0x4)
	BRLO PC+2
	RJMP _0x1D7
;{
;adca_store[nn]=adca_read(nn);
	LDS  R30,_nn
	LDI  R26,LOW(_adca_store)
	LDI  R27,HIGH(_adca_store)
	CALL SUBOPT_0x63
	PUSH R31
	PUSH R30
	LDS  R26,_nn
	CALL _adca_read
	POP  R26
	POP  R27
	CALL SUBOPT_0x93
;adca_SD[nn]+=adca_store[nn];
	LDI  R26,LOW(_adca_SD)
	LDI  R27,HIGH(_adca_SD)
	CALL SUBOPT_0x63
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	LDS  R30,_nn
	LDI  R26,LOW(_adca_store)
	LDI  R27,HIGH(_adca_store)
	CALL SUBOPT_0x94
	CALL SUBOPT_0x93
;adcb_store[nn]=adcb_read(nn);
	LDI  R26,LOW(_adcb_store)
	LDI  R27,HIGH(_adcb_store)
	CALL SUBOPT_0x63
	PUSH R31
	PUSH R30
	LDS  R26,_nn
	CALL _adcb_read
	POP  R26
	POP  R27
	CALL SUBOPT_0x93
;adcb_SD[nn]+=adcb_store[nn];
	LDI  R26,LOW(_adcb_SD)
	LDI  R27,HIGH(_adcb_SD)
	CALL SUBOPT_0x63
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	LDS  R30,_nn
	LDI  R26,LOW(_adcb_store)
	LDI  R27,HIGH(_adcb_store)
	CALL SUBOPT_0x94
	ST   X+,R30
	ST   X,R31
;}
	CALL SUBOPT_0x95
	RJMP _0x1D6
_0x1D7:
;
;
;S0[1]=adcb_store[0];//adc0 b0 мл ток ФЭУ
	LDS  R30,_adcb_store
	__PUTB1MN _S0,1
;S0[2]=adcb_store[0]>>8;// ст
	LDS  R30,_adcb_store+1
	__PUTB1MN _S0,2
;
;S0[5]=adcb_store[1];//adc1 b1 мл напряжение фэу
	__GETB1MN _adcb_store,2
	__PUTB1MN _S0,5
;S0[6]=adcb_store[1]>>8;// ст
	__GETB1MN _adcb_store,3
	__PUTB1MN _S0,6
;
;S0[3]=adcb_store[2];//adc2 b2 мл расход помпы
	__GETB1MN _adcb_store,4
	__PUTB1MN _S0,3
;S0[4]=adcb_store[2]>>8;// ст
	__GETB1MN _adcb_store,5
	__PUTB1MN _S0,4
;
;T_analog=(((adcb_store[3]-993)/19.85)+273)*10;
	__GETW1MN _adcb_store,6
	CALL SUBOPT_0x96
;
;S0[13]=T_analog;//adc3 b3 мл температура контрольн кюветы
	__PUTBMRN _S0,13,4
;S0[14]=T_analog>>8;// ст
	__PUTBMRN _S0,14,5
;
;
;S0[17]=adca_store[0];//adc4 a4 доп ацп
	LDS  R30,_adca_store
	__PUTB1MN _S0,17
;S0[18]=adca_store[0]>>8;// ст
	LDS  R30,_adca_store+1
	__PUTB1MN _S0,18
;
;S0[19]=adca_store[1];//adc5 a5 мл доп ацп
	__GETB1MN _adca_store,2
	__PUTB1MN _S0,19
;S0[20]=adca_store[1]>>8;// ст
	__GETB1MN _adca_store,3
	__PUTB1MN _S0,20
;
;S0[9]=adca_store[2];//adc6 a6 мл доп ацп
	__GETB1MN _adca_store,4
	__PUTB1MN _S0,9
;S0[10]=adca_store[2]>>8;// ст
	__GETB1MN _adca_store,5
	__PUTB1MN _S0,10
;
;if(SD_IN)
	LDS  R30,_SD_IN
	CPI  R30,0
	BRNE PC+2
	RJMP _0x1D8
;{
;//подсчет для усреднения
;RESULT_count++;
	LDS  R30,_RESULT_count
	SUBI R30,-LOW(1)
	STS  _RESULT_count,R30
;////////////////////////////////////////////////////////////////////////////////////////////////////
;if(RESULT_count==16)    {
	LDS  R26,_RESULT_count
	CPI  R26,LOW(0x10)
	BREQ PC+2
	RJMP _0x1D9
;                        RESULT=RESULT_sr/16;
	CALL SUBOPT_0x92
	__GETD1N 0x10
	CALL __DIVD21
	STS  _RESULT,R30
	STS  _RESULT+1,R31
;                        RESULT_count=0;
	LDI  R30,LOW(0)
	STS  _RESULT_count,R30
;                        RESULT_sr=0;
	STS  _RESULT_sr,R30
	STS  _RESULT_sr+1,R30
	STS  _RESULT_sr+2,R30
	STS  _RESULT_sr+3,R30
;                        potok1[14]=RESULT;// Сигнал  усилителя младший;
	LDS  R30,_RESULT
	__PUTB1MN _potok1,14
;                        potok1[15]=(RESULT>>8); //Сигнал  усилителя старший
	CALL SUBOPT_0x97
	__PUTB1MN _potok1,15
;
;
;
;
;
;for (nn=0; nn<CHANNELS; nn++)
	LDI  R30,LOW(0)
	STS  _nn,R30
_0x1DB:
	LDS  R26,_nn
	CPI  R26,LOW(0x4)
	BRSH _0x1DC
;{
;adca_SD[nn]=adca_SD[nn]/16;
	CALL SUBOPT_0x98
	CALL SUBOPT_0x63
	MOVW R0,R30
	CALL SUBOPT_0x98
	CALL SUBOPT_0x99
	CALL SUBOPT_0x93
;adcb_SD[nn]=adcb_SD[nn]/16;
	LDI  R26,LOW(_adcb_SD)
	LDI  R27,HIGH(_adcb_SD)
	CALL SUBOPT_0x63
	MOVW R0,R30
	LDS  R30,_nn
	LDI  R26,LOW(_adcb_SD)
	LDI  R27,HIGH(_adcb_SD)
	CALL SUBOPT_0x99
	ST   X+,R30
	ST   X,R31
;}
	CALL SUBOPT_0x95
	RJMP _0x1DB
_0x1DC:
;
;
;
;potok1[8]=adcb_SD[0];//adc0 b0 мл ток ФЭУ
	LDS  R30,_adcb_SD
	__PUTB1MN _potok1,8
;potok1[9]=adcb_SD[0]>>8;// ст
	LDS  R30,_adcb_SD+1
	__PUTB1MN _potok1,9
;
;potok1[12]=adcb_SD[1];//adc1 b1 мл напряжение фэу
	__GETB1MN _adcb_SD,2
	__PUTB1MN _potok1,12
;potok1[13]=adcb_SD[1]>>8;// ст
	__GETB1MN _adcb_SD,3
	__PUTB1MN _potok1,13
;
;potok1[10]=adcb_SD[2];//adc2 b2 мл расход помпы
	__GETB1MN _adcb_SD,4
	__PUTB1MN _potok1,10
;potok1[11]=adcb_SD[2]>>8;// ст
	__GETB1MN _adcb_SD,5
	__PUTB1MN _potok1,11
;
;T_analog=(((adcb_SD[3]-993)/19.85)+273)*10;
	__GETW1MN _adcb_SD,6
	CALL SUBOPT_0x96
;
;potok1[20]=T_analog;//adc3 b3 мл температура контрольн кюветы
	__PUTBMRN _potok1,20,4
;potok1[21]=T_analog>>8;// ст
	__PUTBMRN _potok1,21,5
;
;//potok1[20]=adcb_SD[3];//adc3 b3 мл температура контрольн кюветы
;//potok1[21]=adcb_SD[3]>>8;// ст
;
;potok1[24]=adca_SD[0];//adc4 a4 доп ацп
	LDS  R30,_adca_SD
	__PUTB1MN _potok1,24
;potok1[25]=adca_SD[0]>>8;// ст
	LDS  R30,_adca_SD+1
	__PUTB1MN _potok1,25
;
;potok1[26]=adca_SD[1];//adc5 a5 мл доп ацп
	__GETB1MN _adca_SD,2
	__PUTB1MN _potok1,26
;potok1[27]=adca_SD[1]>>8;// ст
	__GETB1MN _adca_SD,3
	__PUTB1MN _potok1,27
;
;potok1[16]=adca_SD[2];//adc6 a6 мл доп ацп
	__GETB1MN _adca_SD,4
	__PUTB1MN _potok1,16
;potok1[17]=adca_SD[2]>>8;// ст
	__GETB1MN _adca_SD,5
	__PUTB1MN _potok1,17
;
;
;for (nn=0; nn<CHANNELS; nn++)
	LDI  R30,LOW(0)
	STS  _nn,R30
_0x1DE:
	LDS  R26,_nn
	CPI  R26,LOW(0x4)
	BRSH _0x1DF
;{
;adca_SD[nn]=0;
	CALL SUBOPT_0x98
	CALL SUBOPT_0x9A
	CALL SUBOPT_0x93
;adcb_SD[nn]=0;
	LDI  R26,LOW(_adcb_SD)
	LDI  R27,HIGH(_adcb_SD)
	CALL SUBOPT_0x9A
	ST   X+,R30
	ST   X,R31
;}
	CALL SUBOPT_0x95
	RJMP _0x1DE
_0x1DF:
;
;
;}
;}
_0x1D9:
;
;}
_0x1D8:
;
;
;else
_0x1D2:
;{
;;
;}
;
;
;}
	RJMP _0x238
; .FEND
;
;// Timer/counter TCD0 Overflow/Underflow interrupt service routine
;interrupt [TCD0_OVF_vect] void tcd0_overflow_isr(void)
;{
_tcd0_overflow_isr:
; .FSTART _tcd0_overflow_isr
	CALL SUBOPT_0x46
;if(SD_IN)
	LDS  R30,_SD_IN
	CPI  R30,0
	BREQ _0x1E1
;disk_timerproc();
	CALL _disk_timerproc
;}
_0x1E1:
	RJMP _0x238
; .FEND
;
;//  прерывание по секунде от таймера
;interrupt [TCF0_OVF_vect] void tcf0_overflow_isr(void)
;{
_tcf0_overflow_isr:
; .FSTART _tcf0_overflow_isr
	CALL SUBOPT_0x46
;if(SD_IN==1)
	LDS  R26,_SD_IN
	CPI  R26,LOW(0x1)
	BRNE _0x1E2
;{
;res = f_open(&file,fNAME,FA_READ|FA_WRITE);
	CALL SUBOPT_0x84
	LDI  R26,LOW(3)
	CALL SUBOPT_0x85
;res = f_lseek(&file, file.fsize);
	CALL SUBOPT_0x8B
	__GETD2MN _file,10
	CALL _f_lseek
	STS  _res,R30
;
;res=f_write(&file,buffer,sizeof(buffer),&nbytes);
	CALL SUBOPT_0x8B
	CALL SUBOPT_0x91
;res=f_close(&file);
	CALL SUBOPT_0x8F
;}
;error(res);
_0x1E2:
	CALL SUBOPT_0x8A
;
;
;}
_0x238:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;
;
;
;
;
;// System Clocks initialization
;void system_clocks_init(void)
; 0000 001E {
_system_clocks_init:
; .FSTART _system_clocks_init
; 0000 001F unsigned char n,s;
; 0000 0020 
; 0000 0021 // Optimize for speed
; 0000 0022 #pragma optsize-
; 0000 0023 // Save interrupts enabled/disabled state
; 0000 0024 s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	n -> R17
;	s -> R16
	IN   R16,63
; 0000 0025 // Disable interrupts
; 0000 0026 #asm("cli")
	cli
; 0000 0027 
; 0000 0028 // Internal 32 MHz RC oscillator initialization
; 0000 0029 // Enable the internal 32 MHz RC oscillator
; 0000 002A OSC.CTRL|=OSC_RC32MEN_bm;
	LDS  R30,80
	ORI  R30,2
	STS  80,R30
; 0000 002B 
; 0000 002C // System Clock prescaler A division factor: 1
; 0000 002D // System Clock prescalers B & C division factors: B:1, C:1
; 0000 002E // ClkPer4: 32000,000 kHz
; 0000 002F // ClkPer2: 32000,000 kHz
; 0000 0030 // ClkPer:  32000,000 kHz
; 0000 0031 // ClkCPU:  32000,000 kHz
; 0000 0032 n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
; 0000 0033 	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
	LDS  R30,65
	ANDI R30,LOW(0x80)
	MOV  R17,R30
; 0000 0034 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0035 CLK.PSCTRL=n;
	STS  65,R17
; 0000 0036 
; 0000 0037 // Disable the autocalibration of the internal 32 MHz RC oscillator
; 0000 0038 DFLLRC32M.CTRL&= ~DFLL_ENABLE_bm;
	LDS  R30,96
	ANDI R30,0xFE
	STS  96,R30
; 0000 0039 
; 0000 003A // Wait for the internal 32 MHz RC oscillator to stabilize
; 0000 003B while ((OSC.STATUS & OSC_RC32MRDY_bm)==0);
_0x1E3:
	LDS  R30,81
	ANDI R30,LOW(0x2)
	BREQ _0x1E3
; 0000 003C 
; 0000 003D // Select the system clock source: 32 MHz Internal RC Osc.
; 0000 003E n=(CLK.CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc;
	LDS  R30,64
	ANDI R30,LOW(0xF8)
	ORI  R30,1
	MOV  R17,R30
; 0000 003F CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0040 CLK.CTRL=n;
	STS  64,R17
; 0000 0041 
; 0000 0042 // Disable the unused oscillators: 2 MHz, internal 32 kHz, external clock/crystal oscillator, PLL
; 0000 0043 OSC.CTRL&= ~(OSC_RC2MEN_bm | OSC_RC32KEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm);
	LDS  R30,80
	ANDI R30,LOW(0xE2)
	STS  80,R30
; 0000 0044 
; 0000 0045 // Peripheral Clock output: Disabled
; 0000 0046 PORTCFG.CLKEVOUT=(PORTCFG.CLKEVOUT & (~PORTCFG_CLKOUT_gm)) | PORTCFG_CLKOUT_OFF_gc;
	LDS  R30,180
	ANDI R30,LOW(0xFC)
	STS  180,R30
; 0000 0047 
; 0000 0048 // Restore interrupts enabled/disabled state
; 0000 0049 SREG=s;
	OUT  0x3F,R16
; 0000 004A // Restore optimization for size if needed
; 0000 004B #pragma optsize_default
; 0000 004C }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;
;
;
;void main(void)
; 0000 0052 {
_main:
; .FSTART _main
; 0000 0053 unsigned char n;
; 0000 0054 #pragma optsize-
; 0000 0055 #asm("cli")
;	n -> R17
	cli
; 0000 0056 n=(PMIC.CTRL & (~(PMIC_RREN_bm | PMIC_IVSEL_bm | PMIC_HILVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_LOLVLEN_bm))) |
; 0000 0057 	PMIC_LOLVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm;
	LDS  R30,162
	ANDI R30,LOW(0x38)
	ORI  R30,LOW(0x7)
	MOV  R17,R30
; 0000 0058 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0059 PMIC.CTRL=n;
	STS  162,R17
; 0000 005A PMIC.INTPRI=0x00;
	LDI  R30,LOW(0)
	STS  161,R30
; 0000 005B #pragma optsize_default
; 0000 005C system_clocks_init();
	RCALL _system_clocks_init
; 0000 005D 
; 0000 005E ports_init();
	CALL _ports_init
; 0000 005F usartc0_init();
	CALL _usartc0_init
; 0000 0060 usartd1_init();
	CALL _usartd1_init
; 0000 0061 rtc32_init_my();
	CALL _rtc32_init_my
; 0000 0062 delay_ms(50);
	CALL SUBOPT_0x9B
; 0000 0063 tcd0_init();
	CALL _tcd0_init
; 0000 0064 twie_init();
	CALL _twie_init
; 0000 0065 sprintf(info,"start i2c");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,370
	CALL SUBOPT_0x88
; 0000 0066 monitor();
	CALL SUBOPT_0x9C
; 0000 0067 delay_ms(50);
; 0000 0068 #asm("sei")
	sei
; 0000 0069 delay_ms(1);
	LDI  R26,LOW(1)
	CALL SUBOPT_0x9D
; 0000 006A PORTE.OUT=PORTE.OUT|0b00010000;
	ORI  R30,0x10
	STS  1668,R30
; 0000 006B init_buferU1();
	RCALL _init_buferU1
; 0000 006C delay_ms(50);
	CALL SUBOPT_0x9B
; 0000 006D PORTE.OUT=PORTE.OUT&0b11101111;
	CALL SUBOPT_0x9E
; 0000 006E delay_ms(50);
; 0000 006F PORTE.OUT=PORTE.OUT|0b00010000;
	CALL SUBOPT_0x9F
; 0000 0070 init_buferU2();
	RCALL _init_buferU2
; 0000 0071 delay_ms(50);
	CALL SUBOPT_0x9B
; 0000 0072 PORTE.OUT=PORTE.OUT&0b11101111;
	CALL SUBOPT_0x9E
; 0000 0073 delay_ms(50);
; 0000 0074 PORTE.OUT=PORTE.OUT|0b00010000;
	CALL SUBOPT_0x9F
; 0000 0075 init_buferU3();
	RCALL _init_buferU3
; 0000 0076 delay_ms(50);
	CALL SUBOPT_0x9B
; 0000 0077 PORTE.OUT=PORTE.OUT&0b11101111;
	CALL SUBOPT_0x9E
; 0000 0078 delay_ms(50);
; 0000 0079 sprintf(info,"buf i2c start ok");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,380
	CALL SUBOPT_0x88
; 0000 007A monitor();
	CALL SUBOPT_0x9C
; 0000 007B delay_ms(50);
; 0000 007C PORTE.OUT=PORTE.OUT|0b00010000;
	CALL SUBOPT_0x9F
; 0000 007D bmp_reg_init();
	CALL _bmp_reg_init
; 0000 007E delay_ms(50);
	CALL SUBOPT_0x9B
; 0000 007F sprintf(info,"bmp i2c start ok");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,397
	CALL SUBOPT_0x88
; 0000 0080 PORTE.OUT=PORTE.OUT&0b11101111;
	CALL SUBOPT_0x9E
; 0000 0081 delay_ms(50);
; 0000 0082 monitor();
	CALL SUBOPT_0x89
; 0000 0083 delay_ms(100);
; 0000 0084 spic_init();
	CALL _spic_init
; 0000 0085 sprintf(info,"SPI START");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,414
	CALL SUBOPT_0x88
; 0000 0086 monitor();
	CALL _monitor
; 0000 0087 #asm("sei")
	sei
; 0000 0088 delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 0089 
; 0000 008A check_sd_card();
	RCALL _check_sd_card
; 0000 008B 
; 0000 008C 
; 0000 008D spic_init();
	CALL _spic_init
; 0000 008E PORTA.DIRSET=0b00000001;
	LDI  R30,LOW(1)
	STS  1537,R30
; 0000 008F PORTA.OUTSET = 0b00000001;
	CALL SUBOPT_0xA0
; 0000 0090 delay_ms(10);
; 0000 0091 PORTA.OUTCLR = 0b00000001;
	LDI  R30,LOW(1)
	STS  1542,R30
; 0000 0092 delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 0093 PORTA.OUTSET = 0b00000001;
	CALL SUBOPT_0xA0
; 0000 0094 delay_ms(10);
; 0000 0095 ad7705_init(can1cl,mclk4,can1set,set1);
	CALL SUBOPT_0x81
; 0000 0096 delay_ms(10);
	LDI  R26,LOW(10)
	CALL SUBOPT_0x9D
; 0000 0097 PORTE.OUT=PORTE.OUT&0b11101111;
	ANDI R30,0xEF
	STS  1668,R30
; 0000 0098 delay_ms(10);
	LDI  R26,LOW(10)
	CALL SUBOPT_0x9D
; 0000 0099 PORTE.OUT=PORTE.OUT|0b00010000;
	ORI  R30,0x10
	STS  1668,R30
; 0000 009A sprintf(info,"ad7705 start ok");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,424
	CALL SUBOPT_0x88
; 0000 009B monitor();
	CALL _monitor
; 0000 009C 
; 0000 009D RESULT=ad7705(1);
	LDI  R26,LOW(1)
	RCALL _ad7705
	STS  _RESULT,R30
	STS  _RESULT+1,R31
; 0000 009E S0[7]=RESULT;// Сигнал  усилителя младший
	LDS  R30,_RESULT
	__PUTB1MN _S0,7
; 0000 009F S0[8]=(RESULT>>8); //Сигнал  усилителя старший
	CALL SUBOPT_0x97
	__PUTB1MN _S0,8
; 0000 00A0 
; 0000 00A1 // ADCA initialization
; 0000 00A2 adca_init();
	CALL _adca_init
; 0000 00A3 // ADCB initialization
; 0000 00A4 adcb_init();
	CALL _adcb_init
; 0000 00A5 
; 0000 00A6 // Timer/Counter
; 0000 00A7 tcc0_init();
	CALL _tcc0_init
; 0000 00A8 tcc1_init();
	CALL _tcc1_init
; 0000 00A9 tcf0_init();
	CALL _tcf0_init
; 0000 00AA delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0000 00AB 
; 0000 00AC sprintf(info,"start device");
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,440
	CALL SUBOPT_0x88
; 0000 00AD monitor();
	CALL SUBOPT_0x9C
; 0000 00AE delay_ms(50);
; 0000 00AF 
; 0000 00B0 if(Xsave==0xFFFFFFFF)Xsave=0;
	LDI  R26,LOW(_Xsave)
	LDI  R27,HIGH(_Xsave)
	CALL __EEPROMRDD
	__CPD1N 0xFFFFFFFF
	BRNE _0x1E6
	LDI  R26,LOW(_Xsave)
	LDI  R27,HIGH(_Xsave)
	CALL SUBOPT_0x1C
	CALL __EEPROMWRD
; 0000 00B1 sprintf(info,"START WHILE");
_0x1E6:
	CALL SUBOPT_0x62
	__POINTW1FN _0x0,453
	CALL SUBOPT_0x88
; 0000 00B2 monitor();
	CALL SUBOPT_0x9C
; 0000 00B3 delay_ms(50);
; 0000 00B4 
; 0000 00B5 if(RTC32.CNT<1454622753) RTC32.CNT=1454622753;
	LDS  R26,1060
	LDS  R27,1060+1
	LDS  R24,1060+2
	LDS  R25,1060+3
	__CPD2N 0x56B3C821
	BRSH _0x1E7
	__GETD1N 0x56B3C821
	CALL SUBOPT_0x1E
; 0000 00B6 
; 0000 00B7 PORTE.OUT=PORTE.OUT&0b11101111;
_0x1E7:
	LDS  R30,1668
	ANDI R30,0xEF
	STS  1668,R30
; 0000 00B8 //прописываем заводской ответ
; 0000 00B9 //!!!! важно смертельно
; 0000 00BA initzavod();
	CALL _initzavod
; 0000 00BB reginit();
	CALL _reginit
; 0000 00BC 
; 0000 00BD 
; 0000 00BE 
; 0000 00BF while (1)
_0x1E8:
; 0000 00C0 {
; 0000 00C1 PORTR.OUTTGL=0b00000010;
	LDI  R30,LOW(2)
	STS  2023,R30
; 0000 00C2 //////////////////////////////////////*************************************
; 0000 00C3 //поиск ошибки буфера
; 0000 00C4 //buferU1_error();
; 0000 00C5 //включаю подсветку
; 0000 00C6 //if(error_buf!=0) PORTE.OUT=PORTE.OUT|0b00010000;
; 0000 00C7 init_buferU1();
	RCALL _init_buferU1
; 0000 00C8 /////////////////////////////////////////////////////////////////////////////
; 0000 00C9 read_bmp();
	CALL _read_bmp
; 0000 00CA ///////////////////////////////////////////////////////////////
; 0000 00CB if((0.0<Tempf&&Tempf<60.0)&&(300.0<p1&&p1<825.0))
	LDS  R30,_Tempf
	LDS  R31,_Tempf+1
	LDS  R22,_Tempf+2
	LDS  R23,_Tempf+3
	CALL __CPD01
	BRGE _0x1EC
	CALL SUBOPT_0xA1
	__GETD1N 0x42700000
	CALL __CMPF12
	BRLO _0x1ED
_0x1EC:
	RJMP _0x1EE
_0x1ED:
	LDS  R30,_p1
	LDS  R31,_p1+1
	LDS  R22,_p1+2
	LDS  R23,_p1+3
	__GETD2N 0x43960000
	CALL __CMPF12
	BRSH _0x1EF
	LDS  R26,_p1
	LDS  R27,_p1+1
	LDS  R24,_p1+2
	LDS  R25,_p1+3
	__GETD1N 0x444E4000
	CALL __CMPF12
	BRLO _0x1F0
_0x1EF:
	RJMP _0x1EE
_0x1F0:
	RJMP _0x1F1
_0x1EE:
	RJMP _0x1EB
_0x1F1:
; 0000 00CC {
; 0000 00CD Tempf_K=Tempf*10.0+2730.0;
	CALL SUBOPT_0xA1
	CALL SUBOPT_0xA2
	__GETD2N 0x452AA000
	CALL __ADDF12
	CALL __CFD1U
	MOVW R6,R30
; 0000 00CE S0[11]=Tempf_K;// температура бмп младший
	__PUTBMRN _S0,11,6
; 0000 00CF S0[12]=(Tempf_K>>8); //температура бмп  старший
	__PUTBMRN _S0,12,7
; 0000 00D0 ///////////////////////////////////////////////////////////////
; 0000 00D1 S0[15]=p/10;//ДАВЛЕНИЕ бмп младший
	CALL SUBOPT_0xA3
	__PUTB1MN _S0,15
; 0000 00D2 S0[16]=(p/10>>8);//ДАВЛЕНИЕ бмп  старший
	CALL SUBOPT_0xA3
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(8)
	CALL __ASRD12
	__PUTB1MN _S0,16
; 0000 00D3 }
; 0000 00D4 
; 0000 00D5 init_buferU2();
_0x1EB:
	RCALL _init_buferU2
; 0000 00D6 
; 0000 00D7 if(SD_IN)
	LDS  R30,_SD_IN
	CPI  R30,0
	BREQ _0x1F2
; 0000 00D8 {
; 0000 00D9 get_CNTRTC(&X);
	CALL SUBOPT_0x5C
; 0000 00DA calcDateTime(X, 0, &date1,&time1);
; 0000 00DB bufform();
	RCALL _bufform
; 0000 00DC GETFILNAME();
	RCALL _GETFILNAME
; 0000 00DD }
; 0000 00DE 
; 0000 00DF init_buferU3();
_0x1F2:
	RCALL _init_buferU3
; 0000 00E0 
; 0000 00E1 buferU1_opros();
	RCALL _buferU1_opros
; 0000 00E2 buferU2_opros();
	RCALL _buferU2_opros
; 0000 00E3 buferU3_opros();
	RCALL _buferU3_opros
; 0000 00E4 //обработочка
; 0000 00E5     //21.1 b2 io7  +
; 0000 00E6      if((U2in.input&0b10000000)==0b10000000) S0[21]=S0[21]|0b00000010;
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x1F3
	__GETB1MN _S0,21
	ORI  R30,2
	RJMP _0x22A
; 0000 00E7 else if((U2in.input&0b10000000)==0b00000000) S0[21]=S0[21]&0b11111101;
_0x1F3:
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x80)
	BRNE _0x1F5
	__GETB1MN _S0,21
	ANDI R30,0xFD
_0x22A:
	__PUTB1MN _S0,21
; 0000 00E8      //21.2 b1 io4 +
; 0000 00E9      if((U1in.input&0b00010000)==0b00010000) S0[21]=S0[21]|0b00000100;
_0x1F5:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x1F6
	__GETB1MN _S0,21
	ORI  R30,4
	RJMP _0x22B
; 0000 00EA else if((U1in.input&0b00010000)==0b00000000) S0[21]=S0[21]&0b11111011;
_0x1F6:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x10)
	BRNE _0x1F8
	__GETB1MN _S0,21
	ANDI R30,0xFB
_0x22B:
	__PUTB1MN _S0,21
; 0000 00EB      //21.3 b1 io5  +
; 0000 00EC      if((U1in.input&0b00100000)==0b00100000) S0[21]=S0[21]|0b00001000;
_0x1F8:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x1F9
	__GETB1MN _S0,21
	ORI  R30,8
	RJMP _0x22C
; 0000 00ED else if((U1in.input&0b00100000)==0b00000000) S0[21]=S0[21]&0b11110111;
_0x1F9:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x20)
	BRNE _0x1FB
	__GETB1MN _S0,21
	ANDI R30,0XF7
_0x22C:
	__PUTB1MN _S0,21
; 0000 00EE      //21.4 b1 io1   ----
; 0000 00EF      if((U1in.input&0b00000010)==0b00000010) S0[21]=S0[21]|0b00010000;
_0x1FB:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x1FC
	__GETB1MN _S0,21
	ORI  R30,0x10
	RJMP _0x22D
; 0000 00F0 else if((U1in.input&0b00000010)==0b00000000) S0[21]=S0[21]&0b11101111;
_0x1FC:
	__GETB1MN _U1in,1
	ANDI R30,LOW(0x2)
	BRNE _0x1FE
	__GETB1MN _S0,21
	ANDI R30,0xEF
_0x22D:
	__PUTB1MN _S0,21
; 0000 00F1      //21.5 b2 io3
; 0000 00F2      if((U2in.input&0b00001000)==0b00001000) S0[21]=S0[21]|0b00100000;
_0x1FE:
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x1FF
	__GETB1MN _S0,21
	ORI  R30,0x20
	RJMP _0x22E
; 0000 00F3 else if((U2in.input&0b00001000)==0b00000000) S0[21]=S0[21]&0b11011111;
_0x1FF:
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x8)
	BRNE _0x201
	__GETB1MN _S0,21
	ANDI R30,0xDF
_0x22E:
	__PUTB1MN _S0,21
; 0000 00F4      //21.6 b2 io4
; 0000 00F5      if((U2in.input&0b00010000)==0b00010000) S0[21]=S0[21]|0b01000000;
_0x201:
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x202
	__GETB1MN _S0,21
	ORI  R30,0x40
	RJMP _0x22F
; 0000 00F6 else if((U2in.input&0b00010000)==0b00000000) S0[21]=S0[21]&0b10111111;
_0x202:
	__GETB1MN _U2in,1
	ANDI R30,LOW(0x10)
	BRNE _0x204
	__GETB1MN _S0,21
	ANDI R30,0xBF
_0x22F:
	__PUTB1MN _S0,21
; 0000 00F7      //21.6 b3 io6
; 0000 00F8      if((U3in.input&0b01000000)==0b01000000) S0[21]=S0[21]|0b10000000;
_0x204:
	__GETB1MN _U3in,1
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x205
	__GETB1MN _S0,21
	ORI  R30,0x80
	RJMP _0x230
; 0000 00F9 else if((U3in.input&0b01000000)==0b00000000) S0[21]=S0[21]&0b01111111;
_0x205:
	__GETB1MN _U3in,1
	ANDI R30,LOW(0x40)
	BRNE _0x207
	__GETB1MN _S0,21
	ANDI R30,0x7F
_0x230:
	__PUTB1MN _S0,21
; 0000 00FA 
; 0000 00FB //пождиг
; 0000 00FC if( (B5upr&0b00000010)==0b00000010 ) { U3out.output=U3out.output|0b00000010; }
_0x207:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x208
	__GETB1MN _U3out,1
	ORI  R30,2
	RJMP _0x231
; 0000 00FD else if( (B5upr&0b00000010)==0b00000000 ) {U3out.output=U3out.output&0b11111101;}
_0x208:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x2)
	BRNE _0x20A
	__GETB1MN _U3out,1
	ANDI R30,0xFD
_0x231:
	__PUTB1MN _U3out,1
; 0000 00FE //клапан1
; 0000 00FF if( (B5upr&0b00000100)==0b00000100 ) {U3out.output=U3out.output|0b00000100;}
_0x20A:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x20B
	__GETB1MN _U3out,1
	ORI  R30,4
	RJMP _0x232
; 0000 0100 else if( (B5upr&0b00000100)==0b00000000 ) {U3out.output=U3out.output&0b11111011;}
_0x20B:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x4)
	BRNE _0x20D
	__GETB1MN _U3out,1
	ANDI R30,0xFB
_0x232:
	__PUTB1MN _U3out,1
; 0000 0101 //контрольная кювета
; 0000 0102 if( (B5upr&0b00001000)==0b00001000)        {U1out.output=U1out.output&0b00111111;
_0x20D:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x20E
	CALL SUBOPT_0xA4
; 0000 0103                                             U1out.output=U1out.output|0b01000000;}
	ORI  R30,0x40
	RJMP _0x233
; 0000 0104 
; 0000 0105 else if((B5upr&0b00001000)==0b00000000)     {U1out.output=U1out.output&0b00111111;
_0x20E:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x8)
	BRNE _0x210
	CALL SUBOPT_0xA4
; 0000 0106                                              U1out.output=U1out.output|0b10000000;}
	ORI  R30,0x80
_0x233:
	__PUTB1MN _U1out,1
; 0000 0107 
; 0000 0108 
; 0000 0109 //клапан 2
; 0000 010A if( (B5upr&0b00010000)==0b00010000 ) {U3out.output=U3out.output|0b00001000;}
_0x210:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x211
	__GETB1MN _U3out,1
	ORI  R30,8
	RJMP _0x234
; 0000 010B else if( (B5upr&0b00010000)==0b00000000 ) {U3out.output=U3out.output&0b11110111;}
_0x211:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x10)
	BRNE _0x213
	__GETB1MN _U3out,1
	ANDI R30,0XF7
_0x234:
	__PUTB1MN _U3out,1
; 0000 010C //клапан 3
; 0000 010D if( (B5upr&0b00100000)==0b00100000 ) {U3out.output=U3out.output|0b00010000;}
_0x213:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x214
	__GETB1MN _U3out,1
	ORI  R30,0x10
	RJMP _0x235
; 0000 010E else if( (B5upr&0b00100000)==0b00000000 ) {U3out.output=U3out.output&0b11101111;}
_0x214:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x20)
	BRNE _0x216
	__GETB1MN _U3out,1
	ANDI R30,0xEF
_0x235:
	__PUTB1MN _U3out,1
; 0000 010F //реле 1    инверсно
; 0000 0110 if( (B5upr&0b01000000)==0b01000000 )       {U1out.output=U1out.output&0b11111110;}
_0x216:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x217
	__GETB1MN _U1out,1
	ANDI R30,0xFE
	RJMP _0x236
; 0000 0111 else if( (B5upr&0b01000000)==0b00000000 ) {U1out.output=U1out.output|0b00000001;}
_0x217:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x40)
	BRNE _0x219
	__GETB1MN _U1out,1
	ORI  R30,1
_0x236:
	__PUTB1MN _U1out,1
; 0000 0112 //реле 2  инверсно
; 0000 0113 if( (B5upr&0b10000000)==0b10000000 )      {U2out.output=U2out.output&0b11111110;}
_0x219:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x21A
	__GETB1MN _U2out,1
	ANDI R30,0xFE
	RJMP _0x237
; 0000 0114 else if( (B5upr&0b10000000)==0b00000000 ) {U2out.output=U2out.output|0b00000001;}
_0x21A:
	LDS  R30,_B5upr
	ANDI R30,LOW(0x80)
	BRNE _0x21C
	__GETB1MN _U2out,1
	ORI  R30,1
_0x237:
	__PUTB1MN _U2out,1
; 0000 0115 
; 0000 0116 buferU1_set();
_0x21C:
	CALL _buferU1_set
; 0000 0117 buferU2_set();
	CALL _buferU2_set
; 0000 0118 buferU3_set();
	RCALL _buferU3_set
; 0000 0119 
; 0000 011A //////////////////////////////////////*************************************
; 0000 011B //установка даты времени
; 0000 011C if ((newtime==1)||(newdate==1))
	LDS  R26,_newtime
	CPI  R26,LOW(0x1)
	BREQ _0x21E
	LDS  R26,_newdate
	CPI  R26,LOW(0x1)
	BRNE _0x21D
_0x21E:
; 0000 011D                       {
; 0000 011E 
; 0000 011F                       calcSeconds(date1,time1,0,&X);
	LDS  R30,_date1
	LDS  R31,_date1+1
	LDS  R22,_date1+2
	LDS  R23,_date1+3
	CALL __PUTPARD1
	CALL SUBOPT_0x5B
	CALL __PUTPARD1
	CALL SUBOPT_0x1C
	CALL __PUTPARD1
	LDI  R26,LOW(_X)
	LDI  R27,HIGH(_X)
	CALL _calcSeconds
; 0000 0120                       Xsave=X;//последняя установка
	CALL SUBOPT_0x1D
	LDI  R26,LOW(_Xsave)
	LDI  R27,HIGH(_Xsave)
	CALL __EEPROMWRD
; 0000 0121                       set_CNTRTC();
	CALL _set_CNTRTC
; 0000 0122                       newdate=0;
	LDI  R30,LOW(0)
	STS  _newdate,R30
; 0000 0123                       newtime=0;
	STS  _newtime,R30
; 0000 0124 
; 0000 0125                       }
; 0000 0126 
; 0000 0127 
; 0000 0128 
; 0000 0129 
; 0000 012A 
; 0000 012B }
_0x21D:
	RJMP _0x1E8
; 0000 012C 
; 0000 012D 
; 0000 012E 
; 0000 012F }
_0x220:
	RJMP _0x220
; .FEND
;

	.DSEG

	.CSEG
_crc7_G100:
; .FSTART _crc7_G100
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R18,LOW(0)
	LDD  R16,Y+4
_0x2000005:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LD   R19,X+
	STD  Y+5,R26
	STD  Y+5+1,R27
	LDI  R17,LOW(8)
_0x2000008:
	LSL  R18
	MOV  R30,R18
	EOR  R30,R19
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	LDI  R30,LOW(9)
	EOR  R18,R30
_0x200000A:
	LSL  R19
	SUBI R17,LOW(1)
	BRNE _0x2000008
	SUBI R16,LOW(1)
	BRNE _0x2000005
	MOV  R30,R18
	LSL  R30
	ORI  R30,1
	CALL __LOADLOCR4
	RJMP _0x210001E
; .FEND
_wait_ready_G100:
; .FSTART _wait_ready_G100
	ST   -Y,R17
	LDI  R30,LOW(50)
	STS  _timer2_G100,R30
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200000B:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200000B
_0x200000F:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000011:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000011
	LDS  R17,2243
	CPI  R17,255
	BREQ _0x2000014
	LDS  R30,_timer2_G100
	CPI  R30,0
	BRNE _0x2000015
_0x2000014:
	RJMP _0x2000010
_0x2000015:
	RJMP _0x200000F
_0x2000010:
	MOV  R30,R17
	RJMP _0x210001F
; .FEND
_deselect_card_G100:
; .FSTART _deselect_card_G100
	LDI  R30,LOW(1)
	STS  1605,R30
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000016:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000016
	RET
; .FEND
_rx_datablock_G100:
; .FSTART _rx_datablock_G100
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R30,LOW(20)
	STS  _timer1_G100,R30
_0x200001A:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200001C:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200001C
	LDS  R17,2243
	CPI  R17,255
	BRNE _0x200001F
	LDS  R30,_timer1_G100
	CPI  R30,0
	BRNE _0x2000020
_0x200001F:
	RJMP _0x200001B
_0x2000020:
	RJMP _0x200001A
_0x200001B:
	CPI  R17,254
	BREQ _0x2000021
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x2100021
_0x2000021:
	__GETWRS 18,19,6
_0x2000023:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000025:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000025
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	LDS  R30,2243
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000028:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000028
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	LDS  R30,2243
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200002B:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200002B
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	LDS  R30,2243
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200002E:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200002E
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	LDS  R30,2243
	POP  R26
	POP  R27
	ST   X,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,4
	STD  Y+4,R30
	STD  Y+4+1,R31
	BREQ _0x2000024
	RJMP _0x2000023
_0x2000024:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000031:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000031
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000034:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000034
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x2100021
; .FEND
_tx_datablock_G100:
; .FSTART _tx_datablock_G100
	ST   -Y,R26
	CALL __SAVELOCR4
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BREQ _0x2000037
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x210001E
_0x2000037:
	LDD  R30,Y+4
	STS  2243,R30
_0x2000038:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000038
	LDD  R26,Y+4
	CPI  R26,LOW(0xFD)
	BREQ _0x200003B
	LDI  R16,LOW(0)
	__GETWRS 18,19,5
_0x200003D:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	STS  2243,R30
_0x200003F:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200003F
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	STS  2243,R30
_0x2000042:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000042
	SUBI R16,LOW(1)
	BRNE _0x200003D
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000045:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000045
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000048:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000048
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200004B:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200004B
	LDS  R17,2243
	MOV  R30,R17
	ANDI R30,LOW(0x1F)
	CPI  R30,LOW(0x5)
	BREQ _0x200004E
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x210001E
_0x200004E:
_0x200003B:
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x210001E
; .FEND
_send_cmd_G100:
; .FSTART _send_cmd_G100
	CALL __PUTPARD2
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	ANDI R30,LOW(0x80)
	BREQ _0x200004F
	LDD  R30,Y+6
	ANDI R30,0x7F
	STD  Y+6,R30
	LDI  R30,LOW(119)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	MOV  R16,R30
	CPI  R16,2
	BRLO _0x2000050
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x210001E
_0x2000050:
_0x200004F:
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BREQ _0x2000051
	RCALL _deselect_card_G100
	LDI  R30,LOW(1)
	STS  1606,R30
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BREQ _0x2000052
	LDI  R30,LOW(255)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x210001E
_0x2000052:
_0x2000051:
	LDD  R30,Y+6
	STS  2243,R30
_0x2000053:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000053
	LDD  R30,Y+5
	STS  2243,R30
_0x2000056:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000056
	LDD  R30,Y+4
	STS  2243,R30
_0x2000059:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000059
	LDD  R30,Y+3
	STS  2243,R30
_0x200005C:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200005C
	LDD  R30,Y+2
	STS  2243,R30
_0x200005F:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200005F
	LDI  R17,LOW(1)
	LDD  R26,Y+6
	CPI  R26,LOW(0x40)
	BRNE _0x2000062
	LDI  R17,LOW(149)
	RJMP _0x2000063
_0x2000062:
	LDD  R26,Y+6
	CPI  R26,LOW(0x48)
	BRNE _0x2000064
	LDI  R17,LOW(135)
_0x2000064:
_0x2000063:
	STS  2243,R17
_0x2000065:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000065
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BRNE _0x2000068
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000069:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000069
_0x2000068:
	LDI  R17,LOW(255)
_0x200006D:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x200006F:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x200006F
	LDS  R16,2243
	SBRS R16,7
	RJMP _0x2000072
	SUBI R17,LOW(1)
	BRNE _0x2000073
_0x2000072:
	RJMP _0x200006E
_0x2000073:
	RJMP _0x200006D
_0x200006E:
	MOV  R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x210001E
; .FEND
_rx_spi4_G100:
; .FSTART _rx_spi4_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDI  R17,4
_0x2000075:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000077:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000077
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,1
	STD  Y+1,R26
	STD  Y+1+1,R27
	SBIW R26,1
	LDS  R30,2243
	ST   X,R30
	SUBI R17,LOW(1)
	BRNE _0x2000075
	RJMP _0x210001C
; .FEND
_disk_initialize:
; .FSTART _disk_initialize
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x200007A
	LDI  R30,LOW(1)
	RJMP _0x2100024
_0x200007A:
	LDI  R30,LOW(10)
	STS  _timer1_G100,R30
_0x200007B:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BRNE _0x200007B
	LDS  R30,_status_G100
	ANDI R30,LOW(0x2)
	BREQ _0x200007E
	RJMP _0x2100023
_0x200007E:
	LDI  R30,LOW(1)
	STS  1601,R30
	STS  1605,R30
	LDI  R30,LOW(160)
	STS  1606,R30
	LDI  R30,LOW(64)
	STS  1602,R30
	LDI  R30,LOW(24)
	STS  1622,R30
	LDI  R30,LOW(176)
	STS  1601,R30
	LDI  R30,LOW(83)
	STS  2240,R30
	LDI  R19,LOW(5)
_0x2000080:
	LDI  R17,LOW(10)
_0x2000083:
	LDI  R30,LOW(255)
	STS  2243,R30
_0x2000085:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x2000085
	SUBI R17,LOW(1)
	BRNE _0x2000083
	LDI  R30,LOW(64)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	MOV  R16,R30
	SUBI R19,LOW(1)
	CPI  R16,1
	BREQ _0x2000088
	CPI  R19,0
	BRNE _0x2000089
_0x2000088:
	RJMP _0x2000081
_0x2000089:
	RJMP _0x2000080
_0x2000081:
	LDI  R19,LOW(0)
	CPI  R16,1
	BREQ PC+2
	RJMP _0x200008A
	LDI  R30,LOW(100)
	STS  _timer1_G100,R30
	LDI  R30,LOW(72)
	ST   -Y,R30
	__GETD2N 0x1AA
	RCALL _send_cmd_G100
	CPI  R30,LOW(0x1)
	BRNE _0x200008B
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G100
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x200008D
	LDD  R26,Y+7
	CPI  R26,LOW(0xAA)
	BREQ _0x200008E
_0x200008D:
	RJMP _0x200008C
_0x200008E:
_0x200008F:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x2000092
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x40000000
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x2000093
_0x2000092:
	RJMP _0x2000091
_0x2000093:
	RJMP _0x200008F
_0x2000091:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x2000095
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ _0x2000096
_0x2000095:
	RJMP _0x2000094
_0x2000096:
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G100
	LDD  R30,Y+4
	ANDI R30,LOW(0x40)
	BREQ _0x2000097
	LDI  R30,LOW(12)
	RJMP _0x2000098
_0x2000097:
	LDI  R30,LOW(4)
_0x2000098:
	MOV  R19,R30
_0x2000094:
_0x200008C:
	RJMP _0x200009A
_0x200008B:
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,LOW(0x2)
	BRSH _0x200009B
	LDI  R19,LOW(2)
	LDI  R16,LOW(233)
	RJMP _0x200009C
_0x200009B:
	LDI  R19,LOW(1)
	LDI  R16,LOW(65)
_0x200009C:
_0x200009D:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x20000A0
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000A1
_0x20000A0:
	RJMP _0x200009F
_0x20000A1:
	RJMP _0x200009D
_0x200009F:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x20000A3
	LDI  R30,LOW(80)
	ST   -Y,R30
	__GETD2N 0x200
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ _0x20000A2
_0x20000A3:
	LDI  R19,LOW(0)
_0x20000A2:
_0x200009A:
_0x200008A:
	STS  _card_type_G100,R19
	RCALL _deselect_card_G100
	CPI  R19,0
	BREQ _0x20000A5
	LDS  R30,_status_G100
	ANDI R30,0xFE
	STS  _status_G100,R30
	LDI  R30,LOW(208)
	STS  2240,R30
	RJMP _0x20000A6
_0x20000A5:
	LDI  R30,LOW(1)
	STS  1606,R30
	RCALL _wait_ready_G100
	RCALL _deselect_card_G100
	LDI  R30,LOW(0)
	STS  2240,R30
	LDI  R30,LOW(240)
	STS  1602,R30
	LDI  R30,LOW(1)
	STS  1602,R30
	LDS  R30,_status_G100
	ORI  R30,1
	STS  _status_G100,R30
_0x20000A6:
_0x2100023:
	LDS  R30,_status_G100
_0x2100024:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_disk_status:
; .FSTART _disk_status
	ST   -Y,R26
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000A7
	LDI  R30,LOW(1)
	RJMP _0x2100022
_0x20000A7:
	LDS  R30,_status_G100
_0x2100022:
	ADIW R28,1
	RET
; .FEND
_disk_read:
; .FSTART _disk_read
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20000A9
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20000A8
_0x20000A9:
	LDI  R30,LOW(4)
	RJMP _0x2100021
_0x20000A8:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000AB
	LDI  R30,LOW(3)
	RJMP _0x2100021
_0x20000AB:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x8)
	BRNE _0x20000AC
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20000AC:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20000AD
	LDI  R30,LOW(81)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000AE
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000AF
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20000AF:
_0x20000AE:
	RJMP _0x20000B0
_0x20000AD:
	LDI  R30,LOW(82)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000B1
_0x20000B3:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000B4
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20000B3
_0x20000B4:
	LDI  R30,LOW(76)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
_0x20000B1:
_0x20000B0:
	RCALL _deselect_card_G100
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000B6
	LDI  R30,LOW(1)
	RJMP _0x20000B7
_0x20000B6:
	LDI  R30,LOW(0)
_0x20000B7:
	RJMP _0x2100021
; .FEND
_disk_write:
; .FSTART _disk_write
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20000BA
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20000B9
_0x20000BA:
	LDI  R30,LOW(4)
	RJMP _0x2100021
_0x20000B9:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000BC
	LDI  R30,LOW(3)
	RJMP _0x2100021
_0x20000BC:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x4)
	BREQ _0x20000BD
	LDI  R30,LOW(2)
	RJMP _0x2100021
_0x20000BD:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x8)
	BRNE _0x20000BE
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20000BE:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20000BF
	LDI  R30,LOW(88)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000C0
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(254)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BREQ _0x20000C1
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20000C1:
_0x20000C0:
	RJMP _0x20000C2
_0x20000BF:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x6)
	BREQ _0x20000C3
	LDI  R30,LOW(215)
	ST   -Y,R30
	LDD  R26,Y+1
	CLR  R27
	CLR  R24
	CLR  R25
	RCALL _send_cmd_G100
_0x20000C3:
	LDI  R30,LOW(89)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000C4
_0x20000C6:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(252)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BREQ _0x20000C7
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20000C6
_0x20000C7:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(253)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BRNE _0x20000C9
	LDI  R30,LOW(1)
	ST   Y,R30
_0x20000C9:
_0x20000C4:
_0x20000C2:
	RCALL _deselect_card_G100
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000CA
	LDI  R30,LOW(1)
	RJMP _0x20000CB
_0x20000CA:
	LDI  R30,LOW(0)
_0x20000CB:
_0x2100021:
	ADIW R28,8
	RET
; .FEND
_disk_ioctl:
; .FSTART _disk_ioctl
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,16
	CALL __SAVELOCR4
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x20000CD
	LDI  R30,LOW(4)
	RJMP _0x2100020
_0x20000CD:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000CE
	LDI  R30,LOW(3)
	RJMP _0x2100020
_0x20000CE:
	LDI  R17,LOW(1)
	LDD  R30,Y+22
	CPI  R30,0
	BRNE _0x20000D2
	LDI  R30,LOW(1)
	STS  1606,R30
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BRNE _0x20000D3
	LDI  R17,LOW(0)
_0x20000D3:
	RJMP _0x20000D1
_0x20000D2:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x20000D4
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000D6
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BRNE _0x20000D7
_0x20000D6:
	RJMP _0x20000D5
_0x20000D7:
	LDD  R30,Y+4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0x1)
	BRNE _0x20000D8
	LDI  R30,0
	LDD  R31,Y+12
	LDD  R26,Y+13
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	LDI  R30,LOW(10)
	RJMP _0x2000104
_0x20000D8:
	LDD  R30,Y+9
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x80)
	ROL  R30
	LDI  R30,0
	ROL  R30
	ADD  R26,R30
	LDD  R30,Y+13
	ANDI R30,LOW(0x3)
	LSL  R30
	ADD  R30,R26
	SUBI R30,-LOW(2)
	MOV  R16,R30
	LDD  R30,Y+12
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	MOV  R26,R30
	LDD  R30,Y+11
	LDI  R31,0
	CALL __LSLW2
	LDI  R27,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+10
	ANDI R30,LOW(0x3)
	LDI  R31,0
	CALL __LSLW2
	MOV  R31,R30
	LDI  R30,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	MOV  R30,R16
	SUBI R30,LOW(9)
_0x2000104:
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000D5:
	RJMP _0x20000D1
_0x20000D4:
	CPI  R30,LOW(0x2)
	BRNE _0x20000DA
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	ST   X+,R30
	ST   X,R31
	LDI  R17,LOW(0)
	RJMP _0x20000D1
_0x20000DA:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x20000DB
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x4)
	BREQ _0x20000DC
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000DD
	LDI  R30,LOW(255)
	STS  2243,R30
_0x20000DE:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x20000DE
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000E1
	LDI  R16,LOW(48)
_0x20000E3:
	CPI  R16,0
	BREQ _0x20000E4
	LDI  R30,LOW(255)
	STS  2243,R30
_0x20000E5:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x20000E5
	SUBI R16,1
	RJMP _0x20000E3
_0x20000E4:
	LDD  R30,Y+14
	SWAP R30
	ANDI R30,0xF
	__GETD2N 0x10
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000E1:
_0x20000DD:
	RJMP _0x20000E8
_0x20000DC:
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ PC+2
	RJMP _0x20000E9
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20000EA
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x2)
	BREQ _0x20000EB
	LDD  R30,Y+14
	ANDI R30,LOW(0x3F)
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __LSLD1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x80)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(7)
	CALL __LSRD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	__ADDD1N 1
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+17
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	SUBI R30,LOW(1)
	CALL __LSLD12
	RJMP _0x2000105
_0x20000EB:
	LDD  R30,Y+14
	ANDI R30,LOW(0x7C)
	LSR  R30
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	__ADDD1N 1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x3)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(3)
	CALL __LSLD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+15
	ANDI R30,LOW(0xE0)
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ADDD12
	__ADDD1N 1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __MULD12U
_0x2000105:
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000EA:
_0x20000E9:
_0x20000E8:
	RJMP _0x20000D1
_0x20000DB:
	CPI  R30,LOW(0xA)
	BRNE _0x20000ED
	LDS  R30,_card_type_G100
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ST   X,R30
	LDI  R17,LOW(0)
	RJMP _0x20000D1
_0x20000ED:
	CPI  R30,LOW(0xB)
	BRNE _0x20000EE
	LDI  R16,LOW(73)
	RJMP _0x20000EF
_0x20000EE:
	CPI  R30,LOW(0xC)
	BRNE _0x20000F1
	LDI  R16,LOW(74)
_0x20000EF:
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F2
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000F3
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _crc7_G100
	MOV  R26,R30
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	LDD  R30,Z+15
	CP   R30,R26
	BRNE _0x20000F4
	LDI  R17,LOW(0)
_0x20000F4:
_0x20000F3:
_0x20000F2:
	RJMP _0x20000D1
_0x20000F1:
	CPI  R30,LOW(0xD)
	BRNE _0x20000F5
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F6
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL _rx_spi4_G100
	LDI  R17,LOW(0)
_0x20000F6:
	RJMP _0x20000D1
_0x20000F5:
	CPI  R30,LOW(0xE)
	BRNE _0x20000FD
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F8
	LDI  R30,LOW(255)
	STS  2243,R30
_0x20000F9:
	LDS  R30,2242
	ANDI R30,LOW(0x80)
	BREQ _0x20000F9
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(64)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000FC
	LDI  R17,LOW(0)
_0x20000FC:
_0x20000F8:
	RJMP _0x20000D1
_0x20000FD:
	LDI  R17,LOW(4)
_0x20000D1:
	RCALL _deselect_card_G100
	MOV  R30,R17
_0x2100020:
	CALL __LOADLOCR4
	ADIW R28,24
	RET
; .FEND
_disk_timerproc:
; .FSTART _disk_timerproc
	ST   -Y,R17
	LDS  R17,_timer1_G100
	CPI  R17,0
	BREQ _0x20000FE
	SUBI R17,LOW(1)
	STS  _timer1_G100,R17
_0x20000FE:
	LDS  R17,_timer2_G100
	CPI  R17,0
	BREQ _0x20000FF
	SUBI R17,LOW(1)
	STS  _timer2_G100,R17
_0x20000FF:
	LDS  R30,_status_G100
	ANDI R30,0xFB
	STS  _status_G100,R30
_0x210001F:
	LD   R17,Y+
	RET
; .FEND

	.CSEG
_get_fattime:
; .FSTART _get_fattime
	SBIW R28,7
	LDS  R26,_prtc_get_time
	LDS  R27,_prtc_get_time+1
	SBIW R26,0
	BREQ _0x2020004
	LDS  R26,_prtc_get_date
	LDS  R27,_prtc_get_date+1
	SBIW R26,0
	BRNE _0x2020003
_0x2020004:
	__GETD1N 0x3A210000
	RJMP _0x210001E
_0x2020003:
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,7
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	__CALL1MN _prtc_get_time,0
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,4
	__CALL1MN _prtc_get_date,0
	LD   R30,Y
	LDD  R31,Y+1
	SUBI R30,LOW(1980)
	SBCI R31,HIGH(1980)
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(25)
	CALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+2
	CALL SUBOPT_0xA5
	LDI  R30,LOW(21)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+3
	LDI  R31,0
	CALL __CWD1
	CALL __LSLD16
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+6
	CALL SUBOPT_0xA5
	LDI  R30,LOW(11)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+5
	CALL SUBOPT_0xA5
	LDI  R30,LOW(5)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+4
	LDI  R31,0
	ASR  R31
	ROR  R30
	CALL __CWD1
	CALL __ORD12
_0x210001E:
	ADIW R28,7
	RET
; .FEND
_chk_chrf_G101:
; .FSTART _chk_chrf_G101
	ST   -Y,R26
	ST   -Y,R17
_0x2020006:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020009
	LDD  R30,Y+1
	CP   R30,R17
	BRNE _0x202000A
_0x2020009:
	RJMP _0x2020008
_0x202000A:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x2020006
_0x2020008:
	MOV  R30,R17
	LDI  R31,0
	LDD  R17,Y+0
	ADIW R28,4
	RET
; .FEND
_move_window_G101:
; .FSTART _move_window_G101
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,46
	CALL SUBOPT_0xA6
	CALL SUBOPT_0xA7
	CALL SUBOPT_0xA8
	CALL __CPD12
	BRNE PC+2
	RJMP _0x202000B
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x202000C
	CALL SUBOPT_0xA9
	CPI  R30,0
	BRNE _0x210001D
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0xAA
	MOVW R0,R26
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	MOVW R26,R0
	CALL __ADDD12
	CALL SUBOPT_0xA8
	CALL __CPD21
	BRSH _0x202000E
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R17,Z+3
_0x2020010:
	CPI  R17,2
	BRLO _0x2020011
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	CALL SUBOPT_0xA8
	CALL __ADDD12
	__PUTD1S 1
	CALL SUBOPT_0xA9
	SUBI R17,1
	RJMP _0x2020010
_0x2020011:
_0x202000E:
_0x202000C:
	CALL SUBOPT_0xA7
	CALL __CPD10
	BREQ _0x2020012
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	CALL SUBOPT_0xAB
	BREQ _0x2020013
_0x210001D:
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	ADIW R28,11
	RET
_0x2020013:
	CALL SUBOPT_0xA7
	__PUTD1SNS 9,46
_0x2020012:
_0x202000B:
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x2100018
; .FEND
_sync_G101:
; .FSTART _sync_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0xAC
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2020014
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R26,X
	CPI  R26,LOW(0x3)
	BRNE _0x2020016
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R30,Z+5
	CPI  R30,0
	BRNE _0x2020017
_0x2020016:
	RJMP _0x2020015
_0x2020017:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,46
	CALL SUBOPT_0xAD
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	CALL SUBOPT_0x65
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	CALL _memset
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	LDI  R26,LOW(43605)
	LDI  R27,HIGH(43605)
	STD  Z+0,R26
	STD  Z+1,R27
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	__GETD2N 0x41615252
	CALL SUBOPT_0xAE
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	__GETD2N 0x61417272
	CALL SUBOPT_0xAE
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,14
	CALL SUBOPT_0xAF
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,10
	CALL SUBOPT_0xAF
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xB0
	RCALL _disk_write
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020015:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RCALL _disk_ioctl
	CPI  R30,0
	BREQ _0x2020018
	LDI  R17,LOW(1)
_0x2020018:
_0x2020014:
	MOV  R30,R17
_0x210001C:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_get_fat:
; .FSTART _get_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x41
	CALL SUBOPT_0xB1
	BRLO _0x202001A
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x41
	CALL __CPD21
	BRLO _0x2020019
_0x202001A:
	CALL SUBOPT_0x26
	RJMP _0x210001B
_0x2020019:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,34
	CALL SUBOPT_0xB2
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x202001F
	__GETWRS 18,19,8
	MOVW R30,R18
	LSR  R31
	ROR  R30
	__ADDWRR 18,19,30,31
	CALL SUBOPT_0xB3
	BREQ _0x2020020
	RJMP _0x202001E
_0x2020020:
	CALL SUBOPT_0xB4
	LD   R16,X
	CLR  R17
	__ADDWRN 18,19,1
	CALL SUBOPT_0xB3
	BRNE _0x202001E
	CALL SUBOPT_0xB4
	LD   R30,X
	MOV  R31,R30
	LDI  R30,0
	__ORWRR 16,17,30,31
	LDD  R30,Y+8
	ANDI R30,LOW(0x1)
	BREQ _0x2020022
	MOVW R30,R16
	CALL __LSRW4
	RJMP _0x202027A
_0x2020022:
	MOVW R30,R16
	ANDI R31,HIGH(0xFFF)
_0x202027A:
	CLR  R22
	CLR  R23
	RJMP _0x210001B
_0x202001F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2020025
	CALL SUBOPT_0xB5
	CALL SUBOPT_0xB6
	CALL SUBOPT_0xB7
	BRNE _0x202001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0xB8
	CALL SUBOPT_0xB9
	RJMP _0x210001B
_0x2020025:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x202001E
	CALL SUBOPT_0xB5
	CALL SUBOPT_0xBA
	CALL SUBOPT_0xB7
	BRNE _0x202001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0xB8
	CALL __GETD1P
	__ANDD1N 0xFFFFFFF
	RJMP _0x210001B
_0x202001E:
	CALL SUBOPT_0xBB
_0x210001B:
	CALL __LOADLOCR4
	ADIW R28,14
	RET
; .FEND
_put_fat:
; .FSTART _put_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR6
	CALL SUBOPT_0xBC
	CALL SUBOPT_0xB1
	BRLO _0x202002A
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0xBC
	CALL __CPD21
	BRLO _0x2020029
_0x202002A:
	LDI  R21,LOW(2)
	RJMP _0x202002C
_0x2020029:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,34
	CALL __GETD1P
	__PUTD1S 6
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x2020030
	__GETWRS 16,17,14
	MOVW R30,R16
	LSR  R31
	ROR  R30
	__ADDWRR 16,17,30,31
	CALL SUBOPT_0xBD
	BREQ _0x2020031
	RJMP _0x202002F
_0x2020031:
	CALL SUBOPT_0xBE
	BREQ _0x2020032
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+10
	LDI  R31,0
	CALL __LSLW4
	OR   R30,R26
	RJMP _0x2020033
_0x2020032:
	LDD  R30,Y+10
_0x2020033:
	MOVW R26,R18
	ST   X,R30
	__ADDWRN 16,17,1
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	CALL SUBOPT_0xBD
	BREQ _0x2020035
	RJMP _0x202002F
_0x2020035:
	CALL SUBOPT_0xBE
	BREQ _0x2020036
	CALL SUBOPT_0xBF
	LDI  R30,LOW(4)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	RJMP _0x2020037
_0x2020036:
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF0)
	MOV  R1,R30
	CALL SUBOPT_0xBF
	LDI  R30,LOW(8)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	ANDI R30,LOW(0xF)
	OR   R30,R1
_0x2020037:
	MOVW R26,R18
	ST   X,R30
	RJMP _0x202002F
_0x2020030:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2020039
	CALL SUBOPT_0xC0
	CALL SUBOPT_0xB6
	CALL SUBOPT_0xC1
	BRNE _0x202002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0xC2
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	STD  Z+0,R26
	STD  Z+1,R27
	RJMP _0x202002F
_0x2020039:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x202003D
	CALL SUBOPT_0xC0
	CALL SUBOPT_0xBA
	CALL SUBOPT_0xC1
	BRNE _0x202002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0xC2
	CALL SUBOPT_0xBF
	CALL __PUTDZ20
	RJMP _0x202002F
_0x202003D:
	LDI  R21,LOW(2)
_0x202002F:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
_0x202002C:
	MOV  R30,R21
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_remove_chain_G101:
; .FSTART _remove_chain_G101
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	CALL SUBOPT_0xC3
	CALL SUBOPT_0xB1
	BRLO _0x202003F
	CALL SUBOPT_0xC4
	BRLO _0x202003E
_0x202003F:
	LDI  R17,LOW(2)
	RJMP _0x2020041
_0x202003E:
	LDI  R17,LOW(0)
_0x2020042:
	CALL SUBOPT_0xC4
	BRLO PC+2
	RJMP _0x2020044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 7
	RCALL _get_fat
	__PUTD1S 1
	CALL SUBOPT_0xC5
	CALL __CPD10
	BREQ _0x2020044
	CALL SUBOPT_0xA8
	CALL SUBOPT_0xC6
	BRNE _0x2020046
	LDI  R17,LOW(2)
	RJMP _0x2020044
_0x2020046:
	CALL SUBOPT_0xA8
	CALL SUBOPT_0xC7
	BRNE _0x2020047
	LDI  R17,LOW(1)
	RJMP _0x2020044
_0x2020047:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 7
	CALL __PUTPARD1
	CALL SUBOPT_0xC8
	RCALL _put_fat
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x2020044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0xC9
	BREQ _0x2020049
	CALL SUBOPT_0xCA
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x2020049:
	CALL SUBOPT_0xC5
	CALL SUBOPT_0xCB
	RJMP _0x2020042
_0x2020044:
_0x2020041:
	MOV  R30,R17
	LDD  R17,Y+0
	RJMP _0x2100018
; .FEND
_create_chain_G101:
; .FSTART _create_chain_G101
	CALL __PUTPARD2
	SBIW R28,16
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x27
	CALL SUBOPT_0xCC
	BRNE _0x202004A
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,10
	CALL SUBOPT_0xB2
	CALL SUBOPT_0xCD
	CALL __CPD02
	BREQ _0x202004C
	CALL SUBOPT_0xCE
	CALL SUBOPT_0xCD
	CALL __CPD21
	BRLO _0x202004B
_0x202004C:
	CALL SUBOPT_0x26
	CALL SUBOPT_0x37
_0x202004B:
	RJMP _0x202004E
_0x202004A:
	CALL SUBOPT_0xCF
	CALL SUBOPT_0xD0
	RCALL _get_fat
	CALL SUBOPT_0x33
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xB1
	BRSH _0x202004F
	CALL SUBOPT_0x26
	RJMP _0x210001A
_0x202004F:
	CALL SUBOPT_0xCE
	CALL SUBOPT_0x3A
	CALL __CPD21
	BRSH _0x2020050
	CALL SUBOPT_0x42
	RJMP _0x210001A
_0x2020050:
	CALL SUBOPT_0x30
	CALL SUBOPT_0x37
_0x202004E:
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x36
_0x2020052:
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x29
	CALL SUBOPT_0x36
	CALL SUBOPT_0xCE
	CALL SUBOPT_0x41
	CALL __CPD21
	BRLO _0x2020054
	__GETD1N 0x2
	CALL SUBOPT_0x36
	CALL SUBOPT_0xD1
	BRSH _0x2020055
	CALL SUBOPT_0x1C
	RJMP _0x210001A
_0x2020055:
_0x2020054:
	CALL SUBOPT_0xCF
	CALL SUBOPT_0xBF
	RCALL _get_fat
	CALL SUBOPT_0xD2
	BREQ _0x2020053
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xC7
	BREQ _0x2020058
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xC6
	BRNE _0x2020057
_0x2020058:
	CALL SUBOPT_0x42
	RJMP _0x210001A
_0x2020057:
	CALL SUBOPT_0xD1
	BRNE _0x202005A
	CALL SUBOPT_0x1C
	RJMP _0x210001A
_0x202005A:
	RJMP _0x2020052
_0x2020053:
	CALL SUBOPT_0xCF
	CALL SUBOPT_0xD3
	CALL __PUTPARD1
	__GETD2N 0xFFFFFFF
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x202005B
	CALL SUBOPT_0xBB
	RJMP _0x210001A
_0x202005B:
	CALL SUBOPT_0xCC
	BREQ _0x202005C
	CALL SUBOPT_0xCF
	CALL SUBOPT_0xD4
	CALL __PUTPARD1
	CALL SUBOPT_0xBC
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x202005D
	CALL SUBOPT_0xBB
	RJMP _0x210001A
_0x202005D:
_0x202005C:
	CALL SUBOPT_0x3B
	__PUTD1SNS 20,10
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CALL SUBOPT_0xC9
	BREQ _0x202005E
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,14
	CALL __GETD1P_INC
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL __PUTDP1_DEC
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x202005E:
	CALL SUBOPT_0x3B
_0x210001A:
	ADIW R28,22
	RET
; .FEND
_clust2sect:
; .FSTART _clust2sect
	CALL __PUTPARD2
	CALL SUBOPT_0xCE
	__SUBD1N 2
	CALL SUBOPT_0x27
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	__GETD2Z 30
	__GETD1N 0x2
	CALL SUBOPT_0xD5
	CALL SUBOPT_0xD6
	CALL __CPD21
	BRLO _0x202005F
	CALL SUBOPT_0x1C
	RJMP _0x2100014
_0x202005F:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL SUBOPT_0xD6
	CALL __CWD1
	CALL __MULD12U
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,42
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	RJMP _0x2100014
; .FEND
_dir_seek_G101:
; .FSTART _dir_seek_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__PUTW1SNS 8,4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,6
	CALL SUBOPT_0xD7
	CALL SUBOPT_0xD8
	CALL SUBOPT_0xC6
	BREQ _0x2020061
	CALL SUBOPT_0xD9
	CALL SUBOPT_0xDA
	BRLO _0x2020060
_0x2020061:
	LDI  R30,LOW(2)
	RJMP _0x2100019
_0x2020060:
	CALL SUBOPT_0xDB
	BRNE _0x2020064
	CALL SUBOPT_0xD9
	LD   R26,Z
	CPI  R26,LOW(0x3)
	BREQ _0x2020065
_0x2020064:
	RJMP _0x2020063
_0x2020065:
	CALL SUBOPT_0xD9
	ADIW R30,38
	MOVW R26,R30
	CALL SUBOPT_0xD7
_0x2020063:
	CALL SUBOPT_0xDB
	BRNE _0x2020066
	CALL SUBOPT_0xDC
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2020067
	LDI  R30,LOW(2)
	RJMP _0x2100019
_0x2020067:
	CALL SUBOPT_0xD9
	ADIW R30,38
	MOVW R26,R30
	CALL __GETD1P
	RJMP _0x202027B
_0x2020066:
	CALL SUBOPT_0xD9
	LDD  R30,Z+2
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R16,R0
_0x2020069:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R16
	CPC  R27,R17
	BRLO _0x202006B
	CALL SUBOPT_0xD9
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xCD
	RCALL _get_fat
	CALL SUBOPT_0xDD
	CALL SUBOPT_0xD8
	CALL SUBOPT_0xC7
	BRNE _0x202006C
	LDI  R30,LOW(1)
	RJMP _0x2100019
_0x202006C:
	CALL SUBOPT_0xD8
	CALL SUBOPT_0xB1
	BRLO _0x202006E
	CALL SUBOPT_0xD9
	CALL SUBOPT_0xDA
	BRLO _0x202006D
_0x202006E:
	LDI  R30,LOW(2)
	RJMP _0x2100019
_0x202006D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUB  R30,R16
	SBC  R31,R17
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020069
_0x202006B:
	CALL SUBOPT_0xDC
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xCD
	RCALL _clust2sect
_0x202027B:
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __LSRW4
	CALL SUBOPT_0xDE
	__PUTD1SNS 8,14
	CALL SUBOPT_0xD9
	ADIW R30,50
	MOVW R26,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0xDF
	__PUTW1SNS 8,18
	LDI  R30,LOW(0)
_0x2100019:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_dir_next_G101:
; .FSTART _dir_next_G101
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	CALL __GETW1P
	ADIW R30,1
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2020071
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL SUBOPT_0xE0
	BRNE _0x2020070
_0x2020071:
	LDI  R30,LOW(4)
	RJMP _0x2100017
_0x2020070:
	MOVW R30,R16
	ANDI R30,LOW(0xF)
	BREQ PC+2
	RJMP _0x2020073
	CALL SUBOPT_0xCA
	ADIW R26,10
	CALL SUBOPT_0xE0
	BRNE _0x2020074
	CALL SUBOPT_0xE1
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	CP   R16,R30
	CPC  R17,R31
	BRLO _0x2020075
	LDI  R30,LOW(4)
	RJMP _0x2100017
_0x2020075:
	RJMP _0x2020076
_0x2020074:
	MOVW R30,R16
	CALL __LSRW4
	MOVW R0,R30
	CALL SUBOPT_0xE1
	LDD  R30,Z+2
	LDI  R31,0
	SBIW R30,1
	AND  R30,R0
	AND  R31,R1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2020077
	CALL SUBOPT_0xE1
	CALL SUBOPT_0xE2
	RCALL _get_fat
	CALL SUBOPT_0x37
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xB1
	BRSH _0x2020078
	LDI  R30,LOW(2)
	RJMP _0x2100017
_0x2020078:
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xC7
	BRNE _0x2020079
	LDI  R30,LOW(1)
	RJMP _0x2100017
_0x2020079:
	CALL SUBOPT_0xE1
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0xCD
	CALL __CPD21
	BRSH PC+2
	RJMP _0x202007A
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x202007B
	LDI  R30,LOW(4)
	RJMP _0x2100017
_0x202007B:
	CALL SUBOPT_0xE1
	CALL SUBOPT_0xE2
	RCALL _create_chain_G101
	CALL SUBOPT_0xE3
	CALL __CPD10
	BRNE _0x202007C
	LDI  R30,LOW(7)
	RJMP _0x2100017
_0x202007C:
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xC6
	BRNE _0x202007D
	LDI  R30,LOW(2)
	RJMP _0x2100017
_0x202007D:
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xC7
	BRNE _0x202007E
	LDI  R30,LOW(1)
	RJMP _0x2100017
_0x202007E:
	CALL SUBOPT_0xE1
	CALL SUBOPT_0xAC
	CPI  R30,0
	BREQ _0x202007F
	LDI  R30,LOW(1)
	RJMP _0x2100017
_0x202007F:
	CALL SUBOPT_0xE1
	ADIW R30,50
	CALL SUBOPT_0x65
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	CALL _memset
	CALL SUBOPT_0xE1
	MOVW R26,R30
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R30,R26
	CALL SUBOPT_0xE4
	POP  R26
	POP  R27
	CALL __PUTDP1
	LDI  R19,LOW(0)
_0x2020081:
	CALL SUBOPT_0xE1
	LDD  R30,Z+2
	CP   R19,R30
	BRSH _0x2020082
	CALL SUBOPT_0xE1
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0xE1
	CALL SUBOPT_0xAC
	CPI  R30,0
	BREQ _0x2020083
	LDI  R30,LOW(1)
	RJMP _0x2100017
_0x2020083:
	CALL SUBOPT_0xE1
	ADIW R30,46
	MOVW R26,R30
	CALL __GETD1P_INC
	CALL SUBOPT_0x29
	CALL __PUTDP1_DEC
	SUBI R19,-1
	RJMP _0x2020081
_0x2020082:
	CALL SUBOPT_0xE1
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R19
	LDI  R31,0
	CALL __CWD1
	CALL SUBOPT_0xD5
	POP  R26
	POP  R27
	CALL __PUTDP1
_0x202007A:
	CALL SUBOPT_0x3C
	__PUTD1SNS 9,10
	CALL SUBOPT_0xE1
	CALL SUBOPT_0xE4
	__PUTD1SNS 9,14
_0x2020077:
_0x2020076:
_0x2020073:
	MOVW R30,R16
	__PUTW1SNS 9,4
	CALL SUBOPT_0xE1
	ADIW R30,50
	MOVW R26,R30
	MOVW R30,R16
	CALL SUBOPT_0xDF
	__PUTW1SNS 9,18
	LDI  R30,LOW(0)
_0x2100017:
	CALL __LOADLOCR4
_0x2100018:
	ADIW R28,11
	RET
; .FEND
_dir_find_G101:
; .FSTART _dir_find_G101
	CALL SUBOPT_0xE5
	BREQ _0x2020084
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x2100014
_0x2020084:
_0x2020086:
	CALL SUBOPT_0xE6
	BRNE _0x2020087
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	LD   R16,X
	CPI  R16,0
	BRNE _0x2020089
	LDI  R17,LOW(4)
	RJMP _0x2020087
_0x2020089:
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x8)
	BRNE _0x202008B
	CALL SUBOPT_0xE7
	CALL _memcmp
	CPI  R30,0
	BREQ _0x202008C
_0x202008B:
	RJMP _0x202008A
_0x202008C:
	RJMP _0x2020087
_0x202008A:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _dir_next_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020086
_0x2020087:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x2100014
; .FEND
_dir_register_G101:
; .FSTART _dir_register_G101
	CALL SUBOPT_0xE5
	BRNE _0x2020099
_0x202009B:
	CALL SUBOPT_0xE6
	BRNE _0x202009C
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+18
	LDD  R27,Z+19
	LD   R16,X
	CPI  R16,229
	BREQ _0x202009F
	CPI  R16,0
	BRNE _0x202009E
_0x202009F:
	RJMP _0x202009C
_0x202009E:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _dir_next_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x202009B
_0x202009C:
_0x2020099:
	CPI  R17,0
	BRNE _0x20200A1
	CALL SUBOPT_0xE6
	BRNE _0x20200A2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	ST   -Y,R19
	ST   -Y,R18
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(32)
	LDI  R27,0
	CALL _memset
	CALL SUBOPT_0xE7
	CALL _memcpy
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x18)
	__PUTB1RNS 18,12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
_0x20200A2:
_0x20200A1:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x2100014
; .FEND
_create_name_G101:
; .FSTART _create_name_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,5
	CALL __SAVELOCR6
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	ADIW R26,20
	LD   R20,X+
	LD   R21,X
	ST   -Y,R21
	ST   -Y,R20
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(11)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOV  R17,R30
	MOV  R18,R30
	LDI  R30,LOW(8)
	STD  Y+10,R30
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL SUBOPT_0xE8
	CALL SUBOPT_0xE9
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x2E)
	BRNE _0x20200A5
_0x20200A7:
	CALL SUBOPT_0xEA
	CPI  R16,46
	BRNE _0x20200AA
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,3
	BRLT _0x20200A9
_0x20200AA:
	RJMP _0x20200A8
_0x20200A9:
	CALL SUBOPT_0xEB
	RJMP _0x20200A7
_0x20200A8:
	CPI  R16,47
	BREQ _0x20200AD
	CPI  R16,92
	BREQ _0x20200AD
	CPI  R16,33
	BRSH _0x20200AE
_0x20200AD:
	RJMP _0x20200AC
_0x20200AE:
	LDI  R30,LOW(6)
	RJMP _0x2100015
_0x20200AC:
	CALL SUBOPT_0xE9
	CALL SUBOPT_0xEC
	BRSH _0x20200AF
	LDI  R30,LOW(36)
	RJMP _0x20200B0
_0x20200AF:
	LDI  R30,LOW(32)
_0x20200B0:
	__PUTB1RNS 20,11
	RJMP _0x2100016
_0x20200A5:
_0x20200B3:
	CALL SUBOPT_0xEA
	CPI  R16,33
	BRLO _0x20200B6
	CPI  R16,47
	BREQ _0x20200B6
	CPI  R16,92
	BRNE _0x20200B5
_0x20200B6:
	RJMP _0x20200B4
_0x20200B5:
	CPI  R16,46
	BREQ _0x20200B9
	LDD  R30,Y+10
	CP   R18,R30
	BRLO _0x20200B8
_0x20200B9:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20200BC
	CPI  R16,46
	BREQ _0x20200BB
_0x20200BC:
	LDI  R30,LOW(6)
	RJMP _0x2100015
_0x20200BB:
	LDI  R18,LOW(8)
	LDI  R30,LOW(11)
	STD  Y+10,R30
	LSL  R17
	LSL  R17
	RJMP _0x20200B2
_0x20200B8:
	CPI  R16,128
	BRLO _0x20200BE
	ORI  R17,LOW(3)
	LDI  R30,LOW(6)
	RJMP _0x2100015
_0x20200BE:
	LDI  R30,LOW(_k1*2)
	LDI  R31,HIGH(_k1*2)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R16
	RCALL _chk_chrf_G101
	SBIW R30,0
	BREQ _0x20200C4
	LDI  R30,LOW(6)
	RJMP _0x2100015
_0x20200C4:
	CPI  R16,65
	BRLO _0x20200C6
	CPI  R16,91
	BRLO _0x20200C7
_0x20200C6:
	RJMP _0x20200C5
_0x20200C7:
	ORI  R17,LOW(2)
	RJMP _0x20200C8
_0x20200C5:
	CPI  R16,97
	BRLO _0x20200CA
	CPI  R16,123
	BRLO _0x20200CB
_0x20200CA:
	RJMP _0x20200C9
_0x20200CB:
	ORI  R17,LOW(1)
	SUBI R16,LOW(32)
_0x20200C9:
_0x20200C8:
	CALL SUBOPT_0xEB
_0x20200B2:
	RJMP _0x20200B3
_0x20200B4:
	CALL SUBOPT_0xE9
	CALL SUBOPT_0xEC
	BRSH _0x20200CC
	LDI  R30,LOW(4)
	RJMP _0x20200CD
_0x20200CC:
	LDI  R30,LOW(0)
_0x20200CD:
	MOV  R16,R30
	CPI  R18,0
	BRNE _0x20200CF
	LDI  R30,LOW(6)
	RJMP _0x2100015
_0x20200CF:
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0xE5)
	BRNE _0x20200D0
	MOVW R26,R20
	LDI  R30,LOW(5)
	ST   X,R30
_0x20200D0:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20200D1
	LSL  R17
	LSL  R17
_0x20200D1:
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x1)
	BRNE _0x20200D2
	ORI  R16,LOW(16)
_0x20200D2:
	MOV  R30,R17
	ANDI R30,LOW(0xC)
	CPI  R30,LOW(0x4)
	BRNE _0x20200D3
	ORI  R16,LOW(8)
_0x20200D3:
	MOVW R30,R20
	__PUTBZR 16,11
_0x2100016:
	LDI  R30,LOW(0)
_0x2100015:
	CALL __LOADLOCR6
	ADIW R28,15
	RET
; .FEND
_follow_path_G101:
; .FSTART _follow_path_G101
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
_0x20200E9:
	LDI  R30,LOW(1)
	CPI  R30,0
	BREQ _0x20200EC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x20)
	BREQ _0x20200ED
_0x20200EC:
	RJMP _0x20200EB
_0x20200ED:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	RJMP _0x20200E9
_0x20200EB:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x2F)
	BREQ _0x20200EF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x5C)
	BRNE _0x20200EE
_0x20200EF:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,6
	CALL SUBOPT_0xAD
	RJMP _0x20200F1
_0x20200EE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	ADIW R30,22
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0xED
_0x20200F1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CLR  R27
	SBIW R26,32
	BRSH _0x20200F2
	CALL SUBOPT_0xEE
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _dir_seek_G101
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	CALL SUBOPT_0xEF
	RJMP _0x20200F3
_0x20200F2:
_0x20200F5:
	CALL SUBOPT_0xEE
	MOVW R26,R28
	ADIW R26,6
	RCALL _create_name_G101
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x20200F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL _dir_find_G101
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x4)
	MOV  R16,R30
	CPI  R17,0
	BREQ _0x20200F8
	CPI  R17,4
	BRNE _0x20200FA
	CPI  R16,0
	BREQ _0x20200FB
_0x20200FA:
	RJMP _0x20200F9
_0x20200FB:
	LDI  R17,LOW(5)
_0x20200F9:
	RJMP _0x20200F6
_0x20200F8:
	CPI  R16,0
	BRNE _0x20200F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BRNE _0x20200FD
	LDI  R17,LOW(5)
	RJMP _0x20200F6
_0x20200FD:
	CALL SUBOPT_0xF0
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xF1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0xF2
	CALL SUBOPT_0xED
	RJMP _0x20200F5
_0x20200F6:
_0x20200F3:
	MOV  R30,R17
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; .FEND
_check_fs_G101:
; .FSTART _check_fs_G101
	CALL __PUTPARD2
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 3
	CALL SUBOPT_0xF3
	BREQ _0x20200FE
	LDI  R30,LOW(3)
	RJMP _0x2100014
_0x20200FE:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xF4
	BREQ _0x20200FF
	LDI  R30,LOW(2)
	RJMP _0x2100014
_0x20200FF:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUBI R26,LOW(-104)
	SBCI R27,HIGH(-104)
	CALL SUBOPT_0xF5
	BRNE _0x2020100
	LDI  R30,LOW(0)
	RJMP _0x2100014
_0x2020100:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,50
	SUBI R30,LOW(-82)
	SBCI R31,HIGH(-82)
	MOVW R26,R30
	CALL SUBOPT_0xF5
	BRNE _0x2020101
	LDI  R30,LOW(0)
	RJMP _0x2100014
_0x2020101:
	LDI  R30,LOW(1)
_0x2100014:
	ADIW R28,6
	RET
; .FEND
_chk_mounted:
; .FSTART _chk_mounted
	ST   -Y,R26
	SBIW R28,20
	CALL __SAVELOCR6
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	CALL __GETW1P
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LD   R30,X
	SUBI R30,LOW(48)
	MOV  R16,R30
	CPI  R16,10
	BRSH _0x2020103
	ADIW R26,1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BREQ _0x2020104
_0x2020103:
	RJMP _0x2020102
_0x2020104:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,2
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	ST   X+,R30
	ST   X,R31
	RJMP _0x2020105
_0x2020102:
	LDS  R16,_Drive_G101
_0x2020105:
	CPI  R16,1
	BRLO _0x2020106
	LDI  R30,LOW(11)
	RJMP _0x2100012
_0x2020106:
	MOV  R30,R16
	CALL SUBOPT_0xF6
	CALL SUBOPT_0xE8
	LDD  R26,Y+27
	LDD  R27,Y+27+1
	ST   X+,R30
	ST   X,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,0
	BRNE _0x2020107
	LDI  R30,LOW(12)
	RJMP _0x2100012
_0x2020107:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2020108
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_status
	MOV  R21,R30
	SBRC R21,0
	RJMP _0x2020109
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x202010B
	SBRC R21,2
	RJMP _0x202010C
_0x202010B:
	RJMP _0x202010A
_0x202010C:
	LDI  R30,LOW(10)
	RJMP _0x2100012
_0x202010A:
	RJMP _0x2100013
_0x2020109:
_0x2020108:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOV  R30,R16
	__PUTB1SNS 6,1
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_initialize
	MOV  R21,R30
	SBRS R21,0
	RJMP _0x202010D
	LDI  R30,LOW(3)
	RJMP _0x2100012
_0x202010D:
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x202010F
	SBRC R21,2
	RJMP _0x2020110
_0x202010F:
	RJMP _0x202010E
_0x2020110:
	LDI  R30,LOW(10)
	RJMP _0x2100012
_0x202010E:
	CALL SUBOPT_0xEE
	CALL SUBOPT_0x1C
	__PUTD1S 24
	MOVW R26,R30
	MOVW R24,R22
	RCALL _check_fs_G101
	MOV  R17,R30
	CPI  R17,1
	BRNE _0x2020111
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-446)
	SBCI R31,HIGH(-446)
	MOVW R18,R30
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x2020112
	MOVW R26,R18
	ADIW R26,8
	CALL __GETD1P
	__PUTD1S 22
	CALL SUBOPT_0xEE
	__GETD2S 24
	RCALL _check_fs_G101
	MOV  R17,R30
_0x2020112:
_0x2020111:
	CPI  R17,3
	BRNE _0x2020113
	LDI  R30,LOW(1)
	RJMP _0x2100012
_0x2020113:
	CPI  R17,0
	BRNE _0x2020115
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,61
	CALL __GETW1P
	CPI  R30,LOW(0x200)
	LDI  R26,HIGH(0x200)
	CPC  R31,R26
	BREQ _0x2020114
_0x2020115:
	LDI  R30,LOW(13)
	RJMP _0x2100012
_0x2020114:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-72)
	SBCI R27,HIGH(-72)
	CALL SUBOPT_0xB9
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xD4
	CALL __CPD10
	BRNE _0x2020117
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-86)
	SBCI R27,HIGH(-86)
	CALL __GETD1P
	CALL SUBOPT_0xF7
_0x2020117:
	CALL SUBOPT_0xD4
	__PUTD1SNS 6,26
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-66)
	SBCI R31,HIGH(-66)
	LD   R30,Z
	__PUTB1SNS 6,3
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+3
	LDI  R31,0
	CALL SUBOPT_0xD0
	CALL __CWD1
	CALL __MULD12U
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xF8
	CALL SUBOPT_0xF9
	__PUTD1SNS 6,34
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+63
	__PUTB1SNS 6,2
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-67)
	SBCI R27,HIGH(-67)
	CALL __GETW1P
	__PUTW1SNS 6,8
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-69)
	SBCI R27,HIGH(-69)
	CALL SUBOPT_0xB9
	__PUTD1S 14
	CALL __CPD10
	BRNE _0x2020118
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-82)
	SBCI R27,HIGH(-82)
	CALL __GETD1P
	__PUTD1S 14
_0x2020118:
	CALL SUBOPT_0xF8
	CALL SUBOPT_0xBC
	CLR  R22
	CLR  R23
	CALL SUBOPT_0xD5
	CALL SUBOPT_0xD0
	CALL __SUBD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xFA
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CLR  R22
	CLR  R23
	CALL __SUBD21
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	CALL __DIVD21U
	__ADDD1N 2
	CALL SUBOPT_0xFB
	__PUTD1SNS 6,30
	LDI  R17,LOW(1)
	CALL SUBOPT_0xBF
	__CPD2N 0xFF7
	BRLO _0x2020119
	LDI  R17,LOW(2)
_0x2020119:
	CALL SUBOPT_0xBF
	__CPD2N 0xFFF7
	BRLO _0x202011A
	LDI  R17,LOW(3)
_0x202011A:
	CPI  R17,3
	BRNE _0x202011B
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-94)
	SBCI R27,HIGH(-94)
	CALL __GETD1P
	RJMP _0x202027C
_0x202011B:
	CALL SUBOPT_0xFC
_0x202027C:
	__PUTD1SNS 6,38
	CALL SUBOPT_0xFC
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xFA
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0xDE
	__PUTD1SNS 6,42
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,14
	CALL SUBOPT_0xBB
	CALL __PUTDP1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	CPI  R17,3
	BREQ PC+2
	RJMP _0x202011D
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,5
	ST   X,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-98)
	SBCI R27,HIGH(-98)
	CALL __GETW1P
	CALL SUBOPT_0xF9
	__PUTD1SNS 6,18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0xB0
	CALL _disk_read
	CPI  R30,0
	BRNE _0x202011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0xF4
	BRNE _0x202011F
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,50
	CALL __GETD1P
	__CPD1N 0x41615252
	BRNE _0x202011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	MOVW R26,R30
	CALL __GETD1P
	__CPD1N 0x61417272
	BREQ _0x2020120
_0x202011F:
	RJMP _0x202011E
_0x2020120:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,10
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,14
_0x202011E:
_0x202011D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ST   X,R17
	ADIW R26,46
	CALL SUBOPT_0xAD
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,22
	CALL SUBOPT_0xAD
	LDS  R30,_Fsid_G101
	LDS  R31,_Fsid_G101+1
	ADIW R30,1
	STS  _Fsid_G101,R30
	STS  _Fsid_G101+1,R31
	__PUTW1SNS 6,6
_0x2100013:
	LDI  R30,LOW(0)
_0x2100012:
	CALL __LOADLOCR6
	ADIW R28,31
	RET
; .FEND
_validate_G101:
; .FSTART _validate_G101
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2020122
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2020122
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+6
	LDD  R27,Z+7
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x2020121
_0x2020122:
	LDI  R30,LOW(9)
	RJMP _0x2100011
_0x2020121:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+1
	CALL _disk_status
	ANDI R30,LOW(0x1)
	BREQ _0x2020124
	LDI  R30,LOW(3)
	RJMP _0x2100011
_0x2020124:
	LDI  R30,LOW(0)
_0x2100011:
	ADIW R28,4
	RET
; .FEND
_f_mount:
; .FSTART _f_mount
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x1)
	BRLO _0x2020125
	LDI  R30,LOW(11)
	RJMP _0x2100010
_0x2020125:
	LDD  R30,Y+4
	CALL SUBOPT_0xF6
	LD   R16,X+
	LD   R17,X
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2020126
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020126:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2020127
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020127:
	LDD  R30,Y+4
	LDI  R26,LOW(_FatFs_G101)
	LDI  R27,HIGH(_FatFs_G101)
	CALL SUBOPT_0x63
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	STD  Z+0,R26
	STD  Z+1,R27
	LDI  R30,LOW(0)
_0x2100010:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
_f_open:
; .FSTART _f_open
	ST   -Y,R26
	SBIW R28,34
	CALL __SAVELOCR4
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	CALL SUBOPT_0xEF
	LDD  R30,Y+38
	ANDI R30,LOW(0x1F)
	STD  Y+38,R30
	MOVW R30,R28
	ADIW R30,39
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,18
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+42
	ANDI R30,LOW(0x1E)
	MOV  R26,R30
	RCALL _chk_mounted
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020128
	RJMP _0x210000F
_0x2020128:
	MOVW R30,R28
	ADIW R30,4
	STD  Y+36,R30
	STD  Y+36+1,R31
	MOVW R30,R28
	ADIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	RCALL _follow_path_G101
	MOV  R17,R30
	LDD  R30,Y+38
	ANDI R30,LOW(0x1C)
	BRNE PC+2
	RJMP _0x2020129
	SBIW R28,8
	CPI  R17,0
	BREQ _0x202012A
	CPI  R17,4
	BRNE _0x202012B
	MOVW R26,R28
	ADIW R26,24
	RCALL _dir_register_G101
	MOV  R17,R30
_0x202012B:
	CPI  R17,0
	BREQ _0x202012C
	MOV  R30,R17
	ADIW R28,8
	RJMP _0x210000F
_0x202012C:
	LDD  R30,Y+46
	ORI  R30,8
	STD  Y+46,R30
	__GETWRS 18,19,42
	RJMP _0x202012D
_0x202012A:
	LDD  R30,Y+46
	ANDI R30,LOW(0x4)
	BREQ _0x202012E
	LDI  R30,LOW(8)
	ADIW R28,8
	RJMP _0x210000F
_0x202012E:
	__GETWRS 18,19,42
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x2020130
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x11)
	BREQ _0x202012F
_0x2020130:
	LDI  R30,LOW(7)
	ADIW R28,8
	RJMP _0x210000F
_0x202012F:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BRNE PC+2
	RJMP _0x2020132
	CALL SUBOPT_0xF0
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xF1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0xF2
	CALL SUBOPT_0x27
	MOVW R30,R18
	ADIW R30,20
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,26
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,28
	CALL SUBOPT_0xC8
	CALL __PUTDZ20
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,46
	CALL SUBOPT_0xB2
	CALL SUBOPT_0x2E
	BREQ _0x2020133
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xD8
	RCALL _remove_chain_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020134
	ADIW R28,8
	RJMP _0x210000F
_0x2020134:
	CALL SUBOPT_0xCE
	CALL SUBOPT_0x43
	__PUTD1SNS 24,10
_0x2020133:
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 6
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020135
	ADIW R28,8
	RJMP _0x210000F
_0x2020135:
_0x2020132:
_0x202012D:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BREQ _0x2020136
	MOVW R30,R18
	ADIW R30,11
	LDI  R26,LOW(0)
	STD  Z+0,R26
	CALL _get_fattime
	CALL SUBOPT_0xE3
	__PUTD1RNS 18,14
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R30,Y+46
	ORI  R30,0x20
	STD  Y+46,R30
_0x2020136:
	ADIW R28,8
	RJMP _0x2020137
_0x2020129:
	CPI  R17,0
	BREQ _0x2020138
	MOV  R30,R17
	RJMP _0x210000F
_0x2020138:
	__GETWRS 18,19,34
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x202013A
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BREQ _0x2020139
_0x202013A:
	LDI  R30,LOW(4)
	RJMP _0x210000F
_0x2020139:
	LDD  R30,Y+38
	ANDI R30,LOW(0x2)
	BREQ _0x202013D
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x1)
	BRNE _0x202013E
_0x202013D:
	RJMP _0x202013C
_0x202013E:
	LDI  R30,LOW(7)
	RJMP _0x210000F
_0x202013C:
_0x2020137:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,46
	CALL __GETD1P
	__PUTD1SNS 41,26
	LDD  R30,Y+34
	LDD  R31,Y+34+1
	__PUTW1SNS 41,30
	LDD  R30,Y+38
	__PUTB1SNS 41,4
	CALL SUBOPT_0xF0
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xF1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0xF2
	__PUTD1SNS 41,14
	MOVW R26,R18
	ADIW R26,28
	CALL __GETD1P
	__PUTD1SNS 41,10
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,6
	CALL SUBOPT_0xAD
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,22
	CALL SUBOPT_0xAD
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ST   X+,R30
	ST   X,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,6
	CALL __GETW1P
	__PUTW1SNS 41,2
	LDI  R30,LOW(0)
_0x210000F:
	CALL __LOADLOCR4
	ADIW R28,43
	RET
; .FEND
_f_write:
; .FSTART _f_write
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR6
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL SUBOPT_0xEF
	CALL SUBOPT_0xFD
	CALL SUBOPT_0xFE
	CALL SUBOPT_0xFF
	BREQ _0x2020159
	MOV  R30,R17
	RJMP _0x210000E
_0x2020159:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x202015A
	LDI  R30,LOW(2)
	RJMP _0x210000E
_0x202015A:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BRNE _0x202015B
	LDI  R30,LOW(7)
	RJMP _0x210000E
_0x202015B:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 10
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CALL SUBOPT_0xDE
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x100
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x202015C
	LDI  R30,LOW(0)
	STD  Y+18,R30
	STD  Y+18+1,R30
_0x202015C:
_0x202015E:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x202015F
	CALL SUBOPT_0x101
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2020160
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R0,Z+5
	CALL SUBOPT_0xFD
	LDD  R30,Z+2
	CP   R0,R30
	BRSH PC+2
	RJMP _0x2020161
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL SUBOPT_0xE0
	BRNE _0x2020162
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,14
	CALL __GETD1P
	CALL SUBOPT_0xD2
	BRNE _0x2020163
	CALL SUBOPT_0xFD
	CALL SUBOPT_0x102
	CALL SUBOPT_0x33
	__PUTD1SNS 22,14
_0x2020163:
	RJMP _0x2020164
_0x2020162:
	CALL SUBOPT_0xFD
	CALL SUBOPT_0xFE
	__GETD2Z 18
	CALL _create_chain_G101
	CALL SUBOPT_0x33
_0x2020164:
	CALL SUBOPT_0x42
	CALL __CPD10
	BRNE _0x2020165
	RJMP _0x202015F
_0x2020165:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xC6
	BRNE _0x2020166
	CALL SUBOPT_0x103
	LDI  R30,LOW(2)
	RJMP _0x210000E
_0x2020166:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xC7
	BRNE _0x2020167
	CALL SUBOPT_0x103
	LDI  R30,LOW(1)
	RJMP _0x210000E
_0x2020167:
	CALL SUBOPT_0x42
	__PUTD1SNS 22,18
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020161:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020168
	CALL SUBOPT_0xFD
	CALL SUBOPT_0x104
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	CALL SUBOPT_0x105
	CALL SUBOPT_0x106
	BREQ _0x2020169
	CALL SUBOPT_0x103
	LDI  R30,LOW(1)
	RJMP _0x210000E
_0x2020169:
	CALL SUBOPT_0x107
_0x2020168:
	CALL SUBOPT_0xFD
	CALL SUBOPT_0xFE
	__GETD2Z 18
	RCALL _clust2sect
	CALL SUBOPT_0x36
	CALL SUBOPT_0x3B
	CALL __CPD10
	BRNE _0x202016A
	CALL SUBOPT_0x103
	LDI  R30,LOW(2)
	RJMP _0x210000E
_0x202016A:
	CALL SUBOPT_0x108
	CALL SUBOPT_0x41
	CALL SUBOPT_0x59
	CALL SUBOPT_0x36
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	MOVW R20,R30
	MOV  R0,R20
	OR   R0,R21
	BRNE PC+2
	RJMP _0x202016B
	CALL SUBOPT_0x108
	ADD  R30,R20
	ADC  R31,R21
	MOVW R0,R30
	CALL SUBOPT_0xFD
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x202016C
	CALL SUBOPT_0xFD
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x108
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
_0x202016C:
	CALL SUBOPT_0xFD
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 11
	CALL __PUTPARD1
	MOV  R26,R20
	CALL _disk_write
	CPI  R30,0
	BREQ _0x202016D
	CALL SUBOPT_0x103
	LDI  R30,LOW(1)
	RJMP _0x210000E
_0x202016D:
	CALL SUBOPT_0x109
	CALL __SUBD21
	MOVW R30,R20
	CLR  R22
	CLR  R23
	CALL __CPD21
	BRSH _0x202016E
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0xFE
	CALL SUBOPT_0x105
	CALL SUBOPT_0xD3
	CALL __SUBD21
	__GETD1N 0x200
	CALL __MULD12U
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	CALL _memcpy
	CALL SUBOPT_0x107
_0x202016E:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LD   R30,X
	ADD  R30,R20
	ST   X,R30
	MOVW R30,R20
	LSL  R30
	ROL  R31
	MOV  R31,R30
	LDI  R30,0
	MOVW R18,R30
	RJMP _0x202015D
_0x202016B:
	CALL SUBOPT_0x109
	CALL __CPD12
	BREQ _0x202016F
	CALL SUBOPT_0x101
	MOVW R0,R26
	CALL SUBOPT_0x100
	MOVW R26,R0
	CALL __CPD21
	BRSH _0x2020171
	CALL SUBOPT_0xFD
	CALL SUBOPT_0x104
	__GETD1S 11
	CALL SUBOPT_0xF3
	BRNE _0x2020172
_0x2020171:
	RJMP _0x2020170
_0x2020172:
	CALL SUBOPT_0x103
	LDI  R30,LOW(1)
	RJMP _0x210000E
_0x2020170:
_0x202016F:
	CALL SUBOPT_0x3B
	__PUTD1SNS 22,22
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
_0x2020160:
	CALL SUBOPT_0x10A
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CP   R30,R18
	CPC  R31,R19
	BRSH _0x2020173
	__GETWRS 18,19,18
_0x2020173:
	CALL SUBOPT_0x10A
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x10B
	MOVW R26,R18
	CALL _memcpy
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x40
	ST   X,R30
_0x202015D:
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	CALL SUBOPT_0x10C
	MOVW R26,R30
	MOVW R24,R22
	MOVW R30,R18
	CALL SUBOPT_0xDE
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL __GETW1P
	ADD  R30,R18
	ADC  R31,R19
	ST   X+,R30
	ST   X,R31
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SUB  R30,R18
	SBC  R31,R19
	STD  Y+18,R30
	STD  Y+18+1,R31
	RJMP _0x202015E
_0x202015F:
	CALL SUBOPT_0x101
	MOVW R0,R26
	CALL SUBOPT_0x100
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x2020174
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL __GETD1P
	__PUTD1SNS 22,10
_0x2020174:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDI  R30,LOW(0)
_0x210000E:
	CALL __LOADLOCR6
	ADIW R28,24
	RET
; .FEND
_f_sync:
; .FSTART _f_sync
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0xD9
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL SUBOPT_0xFF
	BREQ PC+2
	RJMP _0x2020175
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x20)
	BRNE PC+2
	RJMP _0x2020176
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020177
	CALL SUBOPT_0xD9
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x105
	CALL SUBOPT_0x106
	BREQ _0x2020178
	LDI  R30,LOW(1)
	RJMP _0x210000D
_0x2020178:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
_0x2020177:
	CALL SUBOPT_0xD9
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	__GETD2Z 26
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2020179
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,30
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	ADIW R26,11
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,10
	CALL __GETD1P
	__PUTD1RNS 18,28
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,14
	CALL __GETW1P
	__PUTW1RNS 18,26
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	__GETD2Z 14
	MOVW R30,R26
	MOVW R22,R24
	CALL __LSRD16
	__PUTW1RNS 18,20
	CALL _get_fattime
	CALL SUBOPT_0xE3
	__PUTD1RNS 18,22
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xDF
	ST   X,R30
	CALL SUBOPT_0xD9
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0xD9
	MOVW R26,R30
	CALL _sync_G101
	MOV  R17,R30
_0x2020179:
_0x2020176:
_0x2020175:
	MOV  R30,R17
_0x210000D:
	CALL __LOADLOCR4
	ADIW R28,10
	RET
; .FEND
_f_close:
; .FSTART _f_close
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _f_sync
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x202017A
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0xEF
_0x202017A:
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_f_lseek:
; .FSTART _f_lseek
	CALL __PUTPARD2
	SBIW R28,16
	ST   -Y,R17
	CALL SUBOPT_0x10D
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	CALL SUBOPT_0xFF
	BREQ _0x2020183
	RJMP _0x210000C
_0x2020183:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x2020184
	LDI  R30,LOW(2)
	RJMP _0x210000B
_0x2020184:
	CALL SUBOPT_0x10E
	CALL SUBOPT_0x10F
	CALL __CPD12
	BRSH _0x2020186
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BREQ _0x2020187
_0x2020186:
	RJMP _0x2020185
_0x2020187:
	CALL SUBOPT_0x10E
	CALL SUBOPT_0x110
_0x2020185:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL SUBOPT_0xA6
	CALL SUBOPT_0x1C
	CALL SUBOPT_0xCB
	CALL SUBOPT_0x111
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	CALL SUBOPT_0x10F
	CALL __CPD02
	BRLO PC+2
	RJMP _0x2020188
	CALL SUBOPT_0x10D
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	__GETD2N 0x200
	CALL __MULD12U
	CALL SUBOPT_0x112
	CALL SUBOPT_0xA8
	CALL __CPD02
	BRSH _0x202018A
	CALL SUBOPT_0x113
	CALL SUBOPT_0x114
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xC5
	CALL SUBOPT_0x114
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x202018B
_0x202018A:
	RJMP _0x2020189
_0x202018B:
	CALL SUBOPT_0xC5
	CALL SUBOPT_0x43
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x115
	CALL SUBOPT_0x43
	CALL __COMD1
	CALL __ANDD12
	CALL SUBOPT_0x111
	ADIW R26,6
	CALL __GETD1P
	CALL SUBOPT_0x10F
	CALL __SUBD21
	__PUTD2S 17
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,18
	CALL SUBOPT_0x116
	RJMP _0x202018C
_0x2020189:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,14
	CALL SUBOPT_0x116
	CALL SUBOPT_0x117
	CALL __CPD10
	BRNE _0x202018D
	CALL SUBOPT_0x10D
	CALL SUBOPT_0x102
	CALL SUBOPT_0x118
	CALL SUBOPT_0x119
	CALL SUBOPT_0xC6
	BRNE _0x202018E
	CALL SUBOPT_0x11A
	LDI  R30,LOW(2)
	RJMP _0x210000B
_0x202018E:
	CALL SUBOPT_0x119
	CALL SUBOPT_0xC7
	BRNE _0x202018F
	CALL SUBOPT_0x11A
	LDI  R30,LOW(1)
	RJMP _0x210000B
_0x202018F:
	CALL SUBOPT_0x117
	__PUTD1SNS 21,14
_0x202018D:
	CALL SUBOPT_0x11B
_0x202018C:
	CALL SUBOPT_0x117
	CALL __CPD10
	BRNE PC+2
	RJMP _0x2020190
_0x2020191:
	CALL SUBOPT_0x115
	CALL SUBOPT_0x10F
	CALL __CPD12
	BRLO PC+2
	RJMP _0x2020193
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BREQ _0x2020194
	CALL SUBOPT_0x10D
	CALL SUBOPT_0x11C
	CALL _create_chain_G101
	CALL SUBOPT_0x118
	CALL SUBOPT_0x117
	CALL __CPD10
	BRNE _0x2020195
	CALL SUBOPT_0x115
	CALL SUBOPT_0x110
	RJMP _0x2020193
_0x2020195:
	RJMP _0x2020196
_0x2020194:
	CALL SUBOPT_0x10D
	CALL SUBOPT_0x11C
	CALL _get_fat
	CALL SUBOPT_0x118
_0x2020196:
	CALL SUBOPT_0x119
	CALL SUBOPT_0xC7
	BRNE _0x2020197
	CALL SUBOPT_0x11A
	LDI  R30,LOW(1)
	RJMP _0x210000B
_0x2020197:
	CALL SUBOPT_0x119
	CALL SUBOPT_0xB1
	BRLO _0x2020199
	CALL SUBOPT_0x10D
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x119
	CALL __CPD21
	BRLO _0x2020198
_0x2020199:
	CALL SUBOPT_0x11A
	LDI  R30,LOW(2)
	RJMP _0x210000B
_0x2020198:
	CALL SUBOPT_0x11B
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	CALL SUBOPT_0x10C
	CALL SUBOPT_0x11D
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	CALL SUBOPT_0x11D
	CALL SUBOPT_0x113
	CALL __SUBD12
	CALL SUBOPT_0x110
	RJMP _0x2020191
_0x2020193:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	CALL SUBOPT_0x10C
	CALL SUBOPT_0x10F
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	CALL SUBOPT_0x10F
	__GETD1N 0x200
	CALL __DIVD21U
	__PUTB1SNS 21,5
	CALL SUBOPT_0x113
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ _0x202019B
	CALL SUBOPT_0x10D
	CALL SUBOPT_0x11C
	CALL _clust2sect
	CALL SUBOPT_0xCB
	CALL SUBOPT_0xA7
	CALL __CPD10
	BRNE _0x202019C
	CALL SUBOPT_0x11A
	LDI  R30,LOW(2)
	RJMP _0x210000B
_0x202019C:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R30,Z+5
	LDI  R31,0
	CALL SUBOPT_0xC3
	CALL SUBOPT_0x59
	CALL SUBOPT_0xCB
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,5
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
_0x202019B:
_0x2020190:
_0x2020188:
	CALL SUBOPT_0x11E
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ _0x202019E
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,22
	CALL __GETD1P
	CALL SUBOPT_0xC3
	CALL __CPD12
	BRNE _0x202019F
_0x202019E:
	RJMP _0x202019D
_0x202019F:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x20201A0
	CALL SUBOPT_0x10D
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0xFE
	CALL SUBOPT_0x105
	CALL SUBOPT_0x106
	BREQ _0x20201A1
	CALL SUBOPT_0x11A
	LDI  R30,LOW(1)
	RJMP _0x210000B
_0x20201A1:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
_0x20201A0:
	CALL SUBOPT_0x10D
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0xAB
	BREQ _0x20201A2
	CALL SUBOPT_0x11A
	LDI  R30,LOW(1)
	RJMP _0x210000B
_0x20201A2:
	CALL SUBOPT_0xA7
	__PUTD1SNS 21,22
_0x202019D:
	CALL SUBOPT_0x11E
	MOVW R0,R26
	CALL SUBOPT_0x10E
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x20201A3
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL __GETD1P
	__PUTD1SNS 21,10
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
_0x20201A3:
_0x210000C:
	MOV  R30,R17
_0x210000B:
	LDD  R17,Y+0
	ADIW R28,23
	RET
; .FEND

	.CSEG
_put_buff_G102:
; .FSTART _put_buff_G102
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2040027
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2040029
	__CPWRN 16,17,2
	BRLO _0x204002A
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2040029:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0x11F
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x204002A:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x204002B
	CALL SUBOPT_0x11F
_0x204002B:
	RJMP _0x204002C
_0x2040027:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x204002C:
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2100006
; .FEND
__ftoe_G102:
; .FSTART __ftoe_G102
	CALL SUBOPT_0x120
	LDI  R30,LOW(128)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	CALL __SAVELOCR4
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x2040034
	CALL SUBOPT_0x10B
	__POINTW2FN _0x2040000,0
	CALL _strcpyf
	RJMP _0x210000A
_0x2040034:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x2040033
	CALL SUBOPT_0x10B
	__POINTW2FN _0x2040000,1
	CALL _strcpyf
	RJMP _0x210000A
_0x2040033:
	LDD  R26,Y+11
	CPI  R26,LOW(0x7)
	BRLO _0x2040036
	LDI  R30,LOW(6)
	STD  Y+11,R30
_0x2040036:
	LDD  R17,Y+11
_0x2040037:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2040039
	CALL SUBOPT_0x121
	CALL SUBOPT_0x37
	RJMP _0x2040037
_0x2040039:
	CALL SUBOPT_0x42
	CALL __CPD10
	BRNE _0x204003A
	LDI  R19,LOW(0)
	CALL SUBOPT_0x121
	CALL SUBOPT_0x37
	RJMP _0x204003B
_0x204003A:
	LDD  R19,Y+11
	CALL SUBOPT_0x122
	BREQ PC+2
	BRCC PC+2
	RJMP _0x204003C
	CALL SUBOPT_0x121
	CALL SUBOPT_0x37
_0x204003D:
	CALL SUBOPT_0x122
	BRLO _0x204003F
	CALL SUBOPT_0x123
	RJMP _0x204003D
_0x204003F:
	RJMP _0x2040040
_0x204003C:
_0x2040041:
	CALL SUBOPT_0x122
	BRSH _0x2040043
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xA2
	CALL SUBOPT_0x33
	SUBI R19,LOW(1)
	RJMP _0x2040041
_0x2040043:
	CALL SUBOPT_0x121
	CALL SUBOPT_0x37
_0x2040040:
	CALL SUBOPT_0x42
	CALL SUBOPT_0x124
	CALL SUBOPT_0x33
	CALL SUBOPT_0x122
	BRLO _0x2040044
	CALL SUBOPT_0x123
_0x2040044:
_0x204003B:
	LDI  R17,LOW(0)
_0x2040045:
	LDD  R30,Y+11
	CP   R30,R17
	BRLO _0x2040047
	CALL SUBOPT_0xCD
	CALL SUBOPT_0x125
	CALL SUBOPT_0x124
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	CALL SUBOPT_0xE3
	CALL SUBOPT_0x3A
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x126
	CALL SUBOPT_0x127
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL SUBOPT_0xCD
	CALL __MULF12
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x128
	CALL SUBOPT_0x33
	MOV  R30,R17
	SUBI R17,-1
	CPI  R30,0
	BRNE _0x2040045
	CALL SUBOPT_0x126
	LDI  R30,LOW(46)
	ST   X,R30
	RJMP _0x2040045
_0x2040047:
	CALL SUBOPT_0x129
	SBIW R30,1
	LDD  R26,Y+10
	STD  Z+0,R26
	CPI  R19,0
	BRGE _0x2040049
	NEG  R19
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(45)
	RJMP _0x2040136
_0x2040049:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(43)
_0x2040136:
	ST   X,R30
	CALL SUBOPT_0x129
	CALL SUBOPT_0x129
	SBIW R30,1
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __DIVB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	CALL SUBOPT_0x129
	SBIW R30,1
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __MODB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x210000A:
	CALL __LOADLOCR4
	ADIW R28,16
	RET
; .FEND
__print_G102:
; .FSTART __print_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,17
	CALL __SAVELOCR6
	LDI  R17,0
	__GETW1SX 88
	STD  Y+8,R30
	STD  Y+8+1,R31
	__GETW1SX 86
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL SUBOPT_0xEF
_0x204004B:
	MOVW R26,R28
	SUBI R26,LOW(-(92))
	SBCI R27,HIGH(-(92))
	CALL SUBOPT_0x11F
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x204004D
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2040051
	CPI  R18,37
	BRNE _0x2040052
	LDI  R17,LOW(1)
	RJMP _0x2040053
_0x2040052:
	CALL SUBOPT_0x12A
_0x2040053:
	RJMP _0x2040050
_0x2040051:
	CPI  R30,LOW(0x1)
	BRNE _0x2040054
	CPI  R18,37
	BRNE _0x2040055
	CALL SUBOPT_0x12A
	RJMP _0x2040137
_0x2040055:
	LDI  R17,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+21,R30
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2040056
	LDI  R16,LOW(1)
	RJMP _0x2040050
_0x2040056:
	CPI  R18,43
	BRNE _0x2040057
	LDI  R30,LOW(43)
	STD  Y+21,R30
	RJMP _0x2040050
_0x2040057:
	CPI  R18,32
	BRNE _0x2040058
	LDI  R30,LOW(32)
	STD  Y+21,R30
	RJMP _0x2040050
_0x2040058:
	RJMP _0x2040059
_0x2040054:
	CPI  R30,LOW(0x2)
	BRNE _0x204005A
_0x2040059:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x204005B
	ORI  R16,LOW(128)
	RJMP _0x2040050
_0x204005B:
	RJMP _0x204005C
_0x204005A:
	CPI  R30,LOW(0x3)
	BRNE _0x204005D
_0x204005C:
	CPI  R18,48
	BRLO _0x204005F
	CPI  R18,58
	BRLO _0x2040060
_0x204005F:
	RJMP _0x204005E
_0x2040060:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2040050
_0x204005E:
	LDI  R20,LOW(0)
	CPI  R18,46
	BRNE _0x2040061
	LDI  R17,LOW(4)
	RJMP _0x2040050
_0x2040061:
	RJMP _0x2040062
_0x204005D:
	CPI  R30,LOW(0x4)
	BRNE _0x2040064
	CPI  R18,48
	BRLO _0x2040066
	CPI  R18,58
	BRLO _0x2040067
_0x2040066:
	RJMP _0x2040065
_0x2040067:
	ORI  R16,LOW(32)
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x2040050
_0x2040065:
_0x2040062:
	CPI  R18,108
	BRNE _0x2040068
	ORI  R16,LOW(2)
	LDI  R17,LOW(5)
	RJMP _0x2040050
_0x2040068:
	RJMP _0x2040069
_0x2040064:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x2040050
_0x2040069:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x204006E
	CALL SUBOPT_0x12B
	CALL SUBOPT_0x12C
	CALL SUBOPT_0x12B
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x12D
	RJMP _0x204006F
_0x204006E:
	CPI  R30,LOW(0x45)
	BREQ _0x2040072
	CPI  R30,LOW(0x65)
	BRNE _0x2040073
_0x2040072:
	RJMP _0x2040074
_0x2040073:
	CPI  R30,LOW(0x66)
	BREQ PC+2
	RJMP _0x2040075
_0x2040074:
	MOVW R30,R28
	ADIW R30,22
	STD  Y+14,R30
	STD  Y+14+1,R31
	CALL SUBOPT_0x12E
	CALL __GETD1P
	CALL SUBOPT_0xFB
	CALL SUBOPT_0x12F
	LDD  R26,Y+13
	TST  R26
	BRMI _0x2040076
	LDD  R26,Y+21
	CPI  R26,LOW(0x2B)
	BREQ _0x2040078
	CPI  R26,LOW(0x20)
	BREQ _0x204007A
	RJMP _0x204007B
_0x2040076:
	CALL SUBOPT_0xD3
	CALL __ANEGF1
	CALL SUBOPT_0xFB
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x2040078:
	SBRS R16,7
	RJMP _0x204007C
	LDD  R30,Y+21
	ST   -Y,R30
	CALL SUBOPT_0x12D
	RJMP _0x204007D
_0x204007C:
_0x204007A:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ADIW R30,1
	STD  Y+14,R30
	STD  Y+14+1,R31
	SBIW R30,1
	LDD  R26,Y+21
	STD  Z+0,R26
_0x204007D:
_0x204007B:
	SBRS R16,5
	LDI  R20,LOW(6)
	CPI  R18,102
	BRNE _0x204007F
	CALL SUBOPT_0xD3
	CALL __PUTPARD1
	ST   -Y,R20
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	CALL _ftoa
	RJMP _0x2040080
_0x204007F:
	CALL SUBOPT_0xD3
	CALL __PUTPARD1
	ST   -Y,R20
	ST   -Y,R18
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL __ftoe_G102
_0x2040080:
	MOVW R30,R28
	ADIW R30,22
	CALL SUBOPT_0x130
	RJMP _0x2040081
_0x2040075:
	CPI  R30,LOW(0x73)
	BRNE _0x2040083
	CALL SUBOPT_0x12F
	CALL SUBOPT_0x131
	CALL SUBOPT_0x130
	RJMP _0x2040084
_0x2040083:
	CPI  R30,LOW(0x70)
	BRNE _0x2040086
	CALL SUBOPT_0x12F
	CALL SUBOPT_0x131
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2040084:
	ANDI R16,LOW(127)
	CPI  R20,0
	BREQ _0x2040088
	CP   R20,R17
	BRLO _0x2040089
_0x2040088:
	RJMP _0x2040087
_0x2040089:
	MOV  R17,R20
_0x2040087:
_0x2040081:
	LDI  R20,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+20,R30
	LDI  R19,LOW(0)
	RJMP _0x204008A
_0x2040086:
	CPI  R30,LOW(0x64)
	BREQ _0x204008D
	CPI  R30,LOW(0x69)
	BRNE _0x204008E
_0x204008D:
	ORI  R16,LOW(4)
	RJMP _0x204008F
_0x204008E:
	CPI  R30,LOW(0x75)
	BRNE _0x2040090
_0x204008F:
	LDI  R30,LOW(10)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x2040091
	__GETD1N 0x3B9ACA00
	CALL SUBOPT_0x31
	LDI  R17,LOW(10)
	RJMP _0x2040092
_0x2040091:
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x31
	LDI  R17,LOW(5)
	RJMP _0x2040092
_0x2040090:
	CPI  R30,LOW(0x58)
	BRNE _0x2040094
	ORI  R16,LOW(8)
	RJMP _0x2040095
_0x2040094:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x20400D3
_0x2040095:
	LDI  R30,LOW(16)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x2040097
	__GETD1N 0x10000000
	CALL SUBOPT_0x31
	LDI  R17,LOW(8)
	RJMP _0x2040092
_0x2040097:
	__GETD1N 0x1000
	CALL SUBOPT_0x31
	LDI  R17,LOW(4)
_0x2040092:
	CPI  R20,0
	BREQ _0x2040098
	ANDI R16,LOW(127)
	RJMP _0x2040099
_0x2040098:
	LDI  R20,LOW(1)
_0x2040099:
	SBRS R16,1
	RJMP _0x204009A
	CALL SUBOPT_0x12F
	CALL SUBOPT_0x12E
	ADIW R26,4
	CALL __GETD1P
	RJMP _0x2040138
_0x204009A:
	SBRS R16,2
	RJMP _0x204009C
	CALL SUBOPT_0x12F
	CALL SUBOPT_0x131
	CALL __CWD1
	RJMP _0x2040138
_0x204009C:
	CALL SUBOPT_0x12F
	CALL SUBOPT_0x12E
	ADIW R26,4
	CALL SUBOPT_0xB9
_0x2040138:
	__PUTD1S 10
	SBRS R16,2
	RJMP _0x204009E
	LDD  R26,Y+13
	TST  R26
	BRPL _0x204009F
	CALL SUBOPT_0xD3
	CALL __ANEGD1
	CALL SUBOPT_0xFB
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x204009F:
	LDD  R30,Y+21
	CPI  R30,0
	BREQ _0x20400A0
	SUBI R17,-LOW(1)
	SUBI R20,-LOW(1)
	RJMP _0x20400A1
_0x20400A0:
	ANDI R16,LOW(251)
_0x20400A1:
_0x204009E:
	MOV  R19,R20
_0x204008A:
	SBRC R16,0
	RJMP _0x20400A2
_0x20400A3:
	CP   R17,R21
	BRSH _0x20400A6
	CP   R19,R21
	BRLO _0x20400A7
_0x20400A6:
	RJMP _0x20400A5
_0x20400A7:
	SBRS R16,7
	RJMP _0x20400A8
	SBRS R16,2
	RJMP _0x20400A9
	ANDI R16,LOW(251)
	LDD  R18,Y+21
	SUBI R17,LOW(1)
	RJMP _0x20400AA
_0x20400A9:
	LDI  R18,LOW(48)
_0x20400AA:
	RJMP _0x20400AB
_0x20400A8:
	LDI  R18,LOW(32)
_0x20400AB:
	CALL SUBOPT_0x12A
	SUBI R21,LOW(1)
	RJMP _0x20400A3
_0x20400A5:
_0x20400A2:
_0x20400AC:
	CP   R17,R20
	BRSH _0x20400AE
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20400AF
	CALL SUBOPT_0x132
	BREQ _0x20400B0
	SUBI R21,LOW(1)
_0x20400B0:
	SUBI R17,LOW(1)
	SUBI R20,LOW(1)
_0x20400AF:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL SUBOPT_0x12D
	CPI  R21,0
	BREQ _0x20400B1
	SUBI R21,LOW(1)
_0x20400B1:
	SUBI R20,LOW(1)
	RJMP _0x20400AC
_0x20400AE:
	MOV  R19,R17
	LDD  R30,Y+20
	CPI  R30,0
	BRNE _0x20400B2
_0x20400B3:
	CPI  R19,0
	BREQ _0x20400B5
	SBRS R16,3
	RJMP _0x20400B6
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	LPM  R18,Z+
	STD  Y+14,R30
	STD  Y+14+1,R31
	RJMP _0x20400B7
_0x20400B6:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LD   R18,X+
	STD  Y+14,R26
	STD  Y+14+1,R27
_0x20400B7:
	CALL SUBOPT_0x12A
	CPI  R21,0
	BREQ _0x20400B8
	SUBI R21,LOW(1)
_0x20400B8:
	SUBI R19,LOW(1)
	RJMP _0x20400B3
_0x20400B5:
	RJMP _0x20400B9
_0x20400B2:
_0x20400BB:
	CALL SUBOPT_0x30
	CALL SUBOPT_0xBF
	CALL __DIVD21U
	MOV  R18,R30
	CPI  R18,10
	BRLO _0x20400BD
	SBRS R16,3
	RJMP _0x20400BE
	SUBI R18,-LOW(55)
	RJMP _0x20400BF
_0x20400BE:
	SUBI R18,-LOW(87)
_0x20400BF:
	RJMP _0x20400C0
_0x20400BD:
	SUBI R18,-LOW(48)
_0x20400C0:
	SBRC R16,4
	RJMP _0x20400C2
	CPI  R18,49
	BRSH _0x20400C4
	CALL SUBOPT_0x45
	CALL SUBOPT_0xC6
	BRNE _0x20400C3
_0x20400C4:
	RJMP _0x20400C6
_0x20400C3:
	CP   R20,R19
	BRSH _0x2040139
	CP   R21,R19
	BRLO _0x20400C9
	SBRS R16,0
	RJMP _0x20400CA
_0x20400C9:
	RJMP _0x20400C8
_0x20400CA:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x20400CB
_0x2040139:
	LDI  R18,LOW(48)
_0x20400C6:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20400CC
	CALL SUBOPT_0x132
	BREQ _0x20400CD
	SUBI R21,LOW(1)
_0x20400CD:
_0x20400CC:
_0x20400CB:
_0x20400C2:
	CALL SUBOPT_0x12A
	CPI  R21,0
	BREQ _0x20400CE
	SUBI R21,LOW(1)
_0x20400CE:
_0x20400C8:
	SUBI R19,LOW(1)
	CALL SUBOPT_0x30
	CALL SUBOPT_0xBF
	CALL __MODD21U
	CALL SUBOPT_0xFB
	LDD  R30,Y+20
	CALL SUBOPT_0x45
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __DIVD21U
	CALL SUBOPT_0x31
	CALL SUBOPT_0xCC
	BREQ _0x20400BC
	RJMP _0x20400BB
_0x20400BC:
_0x20400B9:
	SBRS R16,0
	RJMP _0x20400CF
_0x20400D0:
	CPI  R21,0
	BREQ _0x20400D2
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x12D
	RJMP _0x20400D0
_0x20400D2:
_0x20400CF:
_0x20400D3:
_0x204006F:
_0x2040137:
	LDI  R17,LOW(0)
_0x2040050:
	RJMP _0x204004B
_0x204004D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,31
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	SBIW R30,0
	BRNE _0x20400D4
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2100009
_0x20400D4:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL SUBOPT_0xE8
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G102)
	LDI  R31,HIGH(_put_buff_G102)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G102
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2100009:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG
_memcmp:
; .FSTART _memcmp
	ST   -Y,R27
	ST   -Y,R26
    clr  r22
    clr  r23
    ld   r24,y+
    ld   r25,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
memcmp0:
    adiw r24,0
    breq memcmp1
    sbiw r24,1
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    breq memcmp0
memcmp1:
    sub  r22,r23
    brcc memcmp2
    ldi  r30,-1
    ret
memcmp2:
    ldi  r30,0
    breq memcmp3
    inc  r30
memcmp3:
    ret
; .FEND
_memcpy:
; .FSTART _memcpy
	ST   -Y,R27
	ST   -Y,R26
    ldd  r25,y+1
    ld   r24,y
    adiw r24,0
    breq memcpy1
    ldd  r27,y+5
    ldd  r26,y+4
    ldd  r31,y+3
    ldd  r30,y+2
memcpy0:
    ld   r22,z+
    st   x+,r22
    sbiw r24,1
    brne memcpy0
memcpy1:
    ldd  r31,y+5
    ldd  r30,y+4
	JMP  _0x2100005
; .FEND
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	JMP  _0x2100006
; .FEND
_strcpyf:
; .FSTART _strcpyf
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_ftoa:
; .FSTART _ftoa
	CALL SUBOPT_0x120
	LDI  R30,LOW(0)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x208000D
	CALL SUBOPT_0xEE
	__POINTW2FN _0x2080000,0
	CALL _strcpyf
	RJMP _0x2100008
_0x208000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x208000C
	CALL SUBOPT_0xEE
	__POINTW2FN _0x2080000,1
	CALL _strcpyf
	RJMP _0x2100008
_0x208000C:
	LDD  R26,Y+12
	TST  R26
	BRPL _0x208000F
	CALL SUBOPT_0x115
	CALL __ANEGF1
	CALL SUBOPT_0x112
	CALL SUBOPT_0x133
	LDI  R30,LOW(45)
	ST   X,R30
_0x208000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRLO _0x2080010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x2080010:
	LDD  R17,Y+8
_0x2080011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2080013
	CALL SUBOPT_0xD8
	CALL SUBOPT_0x125
	CALL SUBOPT_0xDD
	RJMP _0x2080011
_0x2080013:
	CALL SUBOPT_0x134
	CALL __ADDF12
	CALL SUBOPT_0x112
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	CALL SUBOPT_0xDD
_0x2080014:
	CALL SUBOPT_0x134
	CALL __CMPF12
	BRLO _0x2080016
	CALL SUBOPT_0xD8
	CALL SUBOPT_0xA2
	CALL SUBOPT_0xDD
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x2080017
	CALL SUBOPT_0xEE
	__POINTW2FN _0x2080000,5
	CALL _strcpyf
	RJMP _0x2100008
_0x2080017:
	RJMP _0x2080014
_0x2080016:
	CPI  R17,0
	BRNE _0x2080018
	CALL SUBOPT_0x133
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x2080019
_0x2080018:
_0x208001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x208001C
	CALL SUBOPT_0xD8
	CALL SUBOPT_0x125
	CALL SUBOPT_0x124
	MOVW R26,R30
	MOVW R24,R22
	CALL _floor
	CALL SUBOPT_0xDD
	CALL SUBOPT_0x134
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x133
	CALL SUBOPT_0x127
	LDI  R31,0
	CALL SUBOPT_0xD8
	CALL __CWD1
	CALL __CDF1
	CALL __MULF12
	CALL SUBOPT_0x11D
	CALL SUBOPT_0x128
	CALL SUBOPT_0x112
	RJMP _0x208001A
_0x208001C:
_0x2080019:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x2100007
	CALL SUBOPT_0x133
	LDI  R30,LOW(46)
	ST   X,R30
_0x208001E:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BREQ _0x2080020
	CALL SUBOPT_0x11D
	CALL SUBOPT_0xA2
	CALL SUBOPT_0x112
	CALL SUBOPT_0x115
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x133
	CALL SUBOPT_0x127
	LDI  R31,0
	CALL SUBOPT_0x11D
	CALL __CWD1
	CALL __CDF1
	CALL SUBOPT_0x128
	CALL SUBOPT_0x112
	RJMP _0x208001E
_0x2080020:
_0x2100007:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2100008:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND

	.DSEG

	.CSEG

	.CSEG
_twi_init:
; .FSTART _twi_init
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	ANDI R30,LOW(0xFC)
	MOV  R17,R30
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x20A0003
	ORI  R17,LOW(1)
_0x20A0003:
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x20A0004
	ORI  R17,LOW(2)
_0x20A0004:
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ST   X,R17
	LDD  R17,Y+0
_0x2100006:
	ADIW R28,5
	RET
; .FEND
_twi_master_init:
; .FSTART _twi_master_init
	ST   -Y,R26
	LDD  R30,Y+1
	ORI  R30,LOW(0x38)
	__PUTB1SNS 2,1
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,2
	LDI  R26,LOW(0)
	STD  Z+0,R26
	LD   R30,Y
	__PUTB1SNS 2,5
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,9
	ST   X,R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,11
	ST   X,R30
_0x2100005:
	ADIW R28,6
	RET
; .FEND
_twi_master_int_handler:
; .FSTART _twi_master_int_handler
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,2
	CALL __SAVELOCR6
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LD   R16,X+
	LD   R17,X
	MOVW R30,R16
	LDD  R19,Z+4
	ADIW R30,3
	MOVW R20,R30
	SBRS R19,3
	RJMP _0x20A0005
	LDI  R18,LOW(3)
	RJMP _0x20A0006
_0x20A0005:
	SBRS R19,2
	RJMP _0x20A0007
	LDI  R18,LOW(4)
_0x20A0006:
	MOVW R30,R16
	__PUTBZR 19,4
	RJMP _0x20A0008
_0x20A0007:
	MOVW R30,R16
	ADIW R30,7
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBRS R19,6
	RJMP _0x20A0009
	SBRS R19,4
	RJMP _0x20A000A
	LDI  R18,LOW(5)
_0x20A0008:
	MOVW R26,R20
	LDI  R30,LOW(3)
	ST   X,R30
	RJMP _0x20A000B
_0x20A000A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R18,Z+6
	LDD  R30,Z+5
	CP   R18,R30
	BRSH _0x20A000C
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+3
	LDD  R27,Z+4
	MOV  R30,R18
	SUBI R18,-1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ST   X,R30
	MOV  R30,R18
	__PUTB1SNS 8,6
	RJMP _0x2100004
_0x20A000C:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+10
	LDD  R30,Z+9
	CP   R26,R30
	BRSH _0x20A000D
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+2
	LDI  R30,LOW(1)
	OR   R30,R26
	__PUTB1RNS 16,6
	RJMP _0x2100004
_0x20A000D:
	MOVW R26,R20
	LDI  R30,LOW(3)
	RJMP _0x20A0033
_0x20A0009:
	SBRS R19,7
	RJMP _0x20A000F
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R18,Z+10
	LDD  R30,Z+9
	CP   R18,R30
	BRLO _0x20A0010
	MOVW R26,R20
	LDI  R30,LOW(3)
	ST   X,R30
	LDI  R18,LOW(2)
	RJMP _0x20A000B
_0x20A0010:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+7
	LDD  R27,Z+8
	MOV  R30,R18
	SUBI R18,-1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	MOV  R30,R18
	__PUTB1SNS 8,10
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R30,Z+9
	CP   R18,R30
	BRSH _0x20A0011
	MOVW R26,R20
	LDI  R30,LOW(2)
	ST   X,R30
	RJMP _0x2100004
_0x20A0011:
	MOVW R26,R20
	LDI  R30,LOW(7)
_0x20A0033:
	ST   X,R30
	LDI  R18,LOW(1)
	RJMP _0x20A000B
_0x20A000F:
	LDI  R18,LOW(6)
_0x20A000B:
	MOV  R30,R18
	__PUTB1SNS 8,11
_0x2100004:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
_twi_master_trans:
; .FSTART _twi_master_trans
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+11
	ANDI R26,LOW(0x80)
	BREQ PC+2
	RJMP _0x20A0012
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,11
	LDI  R30,LOW(128)
	ST   X,R30
	LDD  R30,Y+8
	LSL  R30
	STD  Y+8,R30
	__PUTB1SNS 9,2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__PUTW1SNS 9,3
	LDD  R30,Y+5
	__PUTB1SNS 9,5
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,6
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	__PUTW1SNS 9,7
	LDD  R30,Y+2
	__PUTB1SNS 9,9
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,10
	LDI  R30,LOW(0)
	ST   X,R30
	CALL SUBOPT_0xE1
	ADIW R30,6
	MOVW R16,R30
	LDD  R30,Y+5
	CPI  R30,0
	BREQ _0x20A0013
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,0
	BREQ _0x2100003
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x20A0016
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	SBIW R26,0
	BREQ _0x20A0017
_0x20A0016:
	RJMP _0x20A0015
_0x20A0017:
	RJMP _0x2100003
_0x20A0015:
	LDD  R30,Y+8
	RJMP _0x20A0034
_0x20A0013:
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x20A0019
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	SBIW R30,0
	BREQ _0x2100003
	LDD  R30,Y+8
	ORI  R30,1
_0x20A0034:
	MOVW R26,R16
	ST   X,R30
_0x20A0019:
_0x20A001B:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+11
	ANDI R26,LOW(0x80)
	BRNE _0x20A001B
	LDD  R26,Z+11
	LDI  R30,LOW(1)
	CALL __EQB12
	RJMP _0x2100002
_0x20A0012:
_0x2100003:
	LDI  R30,LOW(0)
_0x2100002:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,11
	RET
; .FEND

	.CSEG

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL __PUTPARD2
	CALL SUBOPT_0xD6
	CALL _ftrunc
	RCALL SUBOPT_0x27
    brne __floor1
__floor0:
	CALL SUBOPT_0xCE
	RJMP _0x2100001
__floor1:
    brtc __floor0
	CALL SUBOPT_0xCE
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x2100001:
	ADIW R28,4
	RET
; .FEND

	.DSEG
_prtc_get_time:
	.BYTE 0x2
_prtc_get_date:
	.BYTE 0x2
_fNAME:
	.BYTE 0xF
_potok1:
	.BYTE 0x24
_rx_buffer_usartc0:
	.BYTE 0x1E
_nn:
	.BYTE 0x1
_adcb_store:
	.BYTE 0x8
_adca_store:
	.BYTE 0x8
_adcb_SD:
	.BYTE 0x8
_adca_SD:
	.BYTE 0x8
_B5upr:
	.BYTE 0x1
_A0:
	.BYTE 0x6
_AF:
	.BYTE 0x12
_AA:
	.BYTE 0x4
_A1:
	.BYTE 0x1B
_AD:
	.BYTE 0x6
_A7:
	.BYTE 0x3
_p77:
	.BYTE 0x4
_p76:
	.BYTE 0x4
_ch:
	.BYTE 0x1
_l:
	.BYTE 0x1
_AB:
	.BYTE 0xC
_A2:
	.BYTE 0x4
_AE:
	.BYTE 0xA
_p6A:
	.BYTE 0x6
_A4:
	.BYTE 0x6
_p58:
	.BYTE 0x6
_A6:
	.BYTE 0x6
_check_sum:
	.BYTE 0x1
_info:
	.BYTE 0x1E
_status:
	.BYTE 0x1
_data:
	.BYTE 0x1
_S0:
	.BYTE 0x17
_S1:
	.BYTE 0x1E
_send:
	.BYTE 0x1
_Mx:
	.BYTE 0x1
_B5buf:
	.BYTE 0x4
_X:
	.BYTE 0x4
_date1:
	.BYTE 0x4
_newdate:
	.BYTE 0x1
_newtime:
	.BYTE 0x1
_time1:
	.BYTE 0x4

	.ESEG
_Xsave:
	.BYTE 0x4

	.DSEG
_bufdt:
	.BYTE 0x5
_res:
	.BYTE 0x1
_nbytes:
	.BYTE 0x2
_fat:
	.BYTE 0x232
_file:
	.BYTE 0x220
_path:
	.BYTE 0xC
_SD_IN:
	.BYTE 0x1
_buffer:
	.BYTE 0x24
_SD:
	.BYTE 0xF
_SD1:
	.BYTE 0xF
_twie_master:
	.BYTE 0xC
_AC1:
	.BYTE 0x2
_AC2:
	.BYTE 0x2
_AC3:
	.BYTE 0x2
_AC4:
	.BYTE 0x2
_AC5:
	.BYTE 0x2
_AC6:
	.BYTE 0x2
_B1:
	.BYTE 0x2
_B2:
	.BYTE 0x2
_MB:
	.BYTE 0x2
_MC:
	.BYTE 0x2
_MD:
	.BYTE 0x2
_UT:
	.BYTE 0x4
_oss:
	.BYTE 0x1
_UP:
	.BYTE 0x4
_X1:
	.BYTE 0x4
_X2:
	.BYTE 0x4
_B5:
	.BYTE 0x4
_Temp:
	.BYTE 0x4
_B6:
	.BYTE 0x4
_X3:
	.BYTE 0x4
_B3:
	.BYTE 0x4
_p:
	.BYTE 0x4
_B4:
	.BYTE 0x4
_B7:
	.BYTE 0x4
_Tempf:
	.BYTE 0x4
_p1:
	.BYTE 0x4
_twi_bmp085_reg:
	.BYTE 0x16
_twi_bmp085_data:
	.BYTE 0x16
_read_temp_please:
	.BYTE 0x2
_read_temp_adr:
	.BYTE 0x2
_read_temp_data:
	.BYTE 0x2
_read_pres_please:
	.BYTE 0x2
_read_pres_adr:
	.BYTE 0x3
_read_pres_data:
	.BYTE 0x3
_U1in:
	.BYTE 0x2
_U1out:
	.BYTE 0x2
_U1io:
	.BYTE 0x2
_U1ne_invert:
	.BYTE 0x2
_U2in:
	.BYTE 0x2
_U2out:
	.BYTE 0x2
_U2io:
	.BYTE 0x2
_U2ne_invert:
	.BYTE 0x2
_U3in:
	.BYTE 0x2
_U3out:
	.BYTE 0x2
_U3io:
	.BYTE 0x2
_U3ne_invert:
	.BYTE 0x2
_chan:
	.BYTE 0x1
_RESULT:
	.BYTE 0x2
_RESULT_buf:
	.BYTE 0x2
_RESULT_sr:
	.BYTE 0x4
_RESULT_count:
	.BYTE 0x1
_status_G100:
	.BYTE 0x1
_timer1_G100:
	.BYTE 0x1
_timer2_G100:
	.BYTE 0x1
_card_type_G100:
	.BYTE 0x1
_FatFs_G101:
	.BYTE 0x2
_Fsid_G101:
	.BYTE 0x2
_Drive_G101:
	.BYTE 0x1
__seed_G104:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	CALL __LSLW3
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
	MOVW R26,R16
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:85 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(6)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	LDS  R30,_l
	LDI  R31,0
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 78 TIMES, CODE SIZE REDUCTION:151 WORDS
SUBOPT_0x2:
	LDS  R30,_l
	LDI  R31,0
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 30 TIMES, CODE SIZE REDUCTION:84 WORDS
SUBOPT_0x3:
	LDS  R26,_ch
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x4:
	SUBI R30,LOW(-_A0)
	SBCI R31,HIGH(-_A0)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A0)
	SBCI R31,HIGH(-_A0)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 58 TIMES, CODE SIZE REDUCTION:168 WORDS
SUBOPT_0x5:
	LDS  R30,_ch
	SUBI R30,-LOW(1)
	STS  _ch,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(18)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x7:
	SUBI R30,LOW(-_AF)
	SBCI R31,HIGH(-_AF)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AF)
	SBCI R31,HIGH(-_AF)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(4)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x9:
	SUBI R30,LOW(-_AA)
	SBCI R31,HIGH(-_AA)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AA)
	SBCI R31,HIGH(-_AA)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xA:
	SUBI R30,LOW(-_A2)
	SBCI R31,HIGH(-_A2)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A2)
	SBCI R31,HIGH(-_A2)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xB:
	SUBI R30,LOW(-_AD)
	SBCI R31,HIGH(-_AD)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AD)
	SBCI R31,HIGH(-_AD)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xC:
	SUBI R30,LOW(-_A6)
	SBCI R31,HIGH(-_A6)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A6)
	SBCI R31,HIGH(-_A6)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(27)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	SUBI R30,LOW(-_A1)
	SBCI R31,HIGH(-_A1)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A1)
	SBCI R31,HIGH(-_A1)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDI  R30,LOW(3)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x10:
	SUBI R30,LOW(-_A7)
	SBCI R31,HIGH(-_A7)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A7)
	SBCI R31,HIGH(-_A7)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x11:
	SUBI R30,LOW(-_p77)
	SBCI R31,HIGH(-_p77)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p77)
	SBCI R31,HIGH(-_p77)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	LDI  R30,LOW(12)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x13:
	SUBI R30,LOW(-_AB)
	SBCI R31,HIGH(-_AB)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AB)
	SBCI R31,HIGH(-_AB)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	LDI  R30,LOW(10)
	STS  _l,R30
	LDI  R30,LOW(1)
	STS  _ch,R30
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x15:
	SUBI R30,LOW(-_AE)
	SBCI R31,HIGH(-_AE)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_AE)
	SBCI R31,HIGH(-_AE)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x16:
	SUBI R30,LOW(-_A4)
	SBCI R31,HIGH(-_A4)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_A4)
	SBCI R31,HIGH(-_A4)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x17:
	SUBI R30,LOW(-_p58)
	SBCI R31,HIGH(-_p58)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p58)
	SBCI R31,HIGH(-_p58)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x18:
	SUBI R30,LOW(-_p76)
	SBCI R31,HIGH(-_p76)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p76)
	SBCI R31,HIGH(-_p76)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x19:
	SUBI R30,LOW(-_p6A)
	SBCI R31,HIGH(-_p6A)
	MOVW R0,R30
	LD   R26,Z
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_p6A)
	SBCI R31,HIGH(-_p6A)
	LD   R30,Z
	ADD  R30,R26
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(24)
	STS  1604,R30
	LDI  R30,LOW(185)
	STS  1600,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1B:
	__GETD1N 0xFFFFFFFF
	STS  1064,R30
	STS  1064+1,R31
	STS  1064+2,R22
	STS  1064+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x1C:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x1D:
	LDS  R30,_X
	LDS  R31,_X+1
	LDS  R22,_X+2
	LDS  R23,_X+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	STS  1060,R30
	STS  1060+1,R31
	STS  1060+2,R22
	STS  1060+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x1F:
	__GETD2N 0xE10
	CALL __MULD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x20:
	__GETD2SX 92
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x21:
	__GETD1S 20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x22:
	__GETD2N 0x3
	CALL __MANDD12
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x23:
	__GETD2S 20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x24:
	__GETD1N 0x64
	CALL __MODD21
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x25:
	RCALL SUBOPT_0x23
	__GETD1N 0x190
	CALL __MODD21
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x26:
	__GETD1N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x27:
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x28:
	CALL __GETD2S0
	__ADDD2N 365
	__GETD1N 0x18
	CALL __MULD12
	RJMP SUBOPT_0x1F

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x29:
	__SUBD1N -1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2A:
	__PUTD1S 20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2B:
	__GETD1SX 92
	CALL __SUBD12
	__PUTD1SX 92
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	RCALL SUBOPT_0x21
	RJMP SUBOPT_0x22

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	RCALL SUBOPT_0x23
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2E:
	CALL __GETD1S0
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2F:
	CALL __LSLW2
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	__GETD2N 0x18
	CALL __MULD12
	RJMP SUBOPT_0x1F

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x30:
	__GETD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x31:
	__PUTD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	RCALL SUBOPT_0x20
	__GETD1N 0x15180
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x33:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x34:
	CALL __MODD21
	__PUTD1SX 92
	RJMP SUBOPT_0x20

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	__GETD1N 0xE10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x36:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x37:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x38:
	__GETD2N 0x2710
	CALL __MULD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	__GETD2N 0x64
	CALL __MULD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x3A:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3B:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x3C:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3D:
	__GETD2SX 86
	__GETD1N 0x2710
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x3E:
	CALL __MODD21U
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x64
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3F:
	__GETD1N 0x64
	CALL __MODD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x40:
	__GETD2SX 82
	__GETD1N 0x2710
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x41:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x42:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x43:
	__SUBD1N 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x44:
	__GETW2SX 76
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x45:
	__GETD2S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:41 WORDS
SUBOPT_0x46:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:63 WORDS
SUBOPT_0x47:
	LDI  R30,LOW(255)
	STS  _Mx,R30
	LDI  R30,LOW(1)
	MOV  R11,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x48:
	STS  _Mx,R30
	LDI  R30,LOW(2)
	MOV  R11,R30
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x49:
	STS  _Mx,R30
	LDI  R30,LOW(4)
	MOV  R11,R30
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4A:
	STS  _Mx,R30
	LDI  R30,LOW(7)
	MOV  R11,R30
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4B:
	STS  _Mx,R30
	LDI  R30,LOW(3)
	MOV  R11,R30
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4C:
	STS  _Mx,R30
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x4D:
	LDI  R30,LOW(255)
	STS  _rx_buffer_usartc0,R30
	CLR  R10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x4E:
	LDS  R30,_l
	LDS  R26,_ch
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x4F:
	LDI  R30,LOW(0)
	STS  _l,R30
	LDI  R30,LOW(255)
	STS  _Mx,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x50:
	LDI  R26,LOW(202)
	CALL _putchar
	LDI  R26,LOW(202)
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x51:
	CALL _putchar
	RJMP SUBOPT_0x47

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x52:
	LDI  R30,LOW(0)
	STS  _ch,R30
	STS  _check_sum,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x53:
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_usartc0)
	SBCI R31,HIGH(-_rx_buffer_usartc0)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x54:
	LDS  R26,_check_sum
	ADD  R30,R26
	STS  _check_sum,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x55:
	CLR  R10
	LDI  R30,LOW(0)
	STS  _check_sum,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x56:
	LDS  R26,_rx_buffer_usartc0
	LDI  R30,LOW(100)
	MUL  R30,R26
	MOVW R30,R0
	MOVW R26,R30
	__GETB1MN _rx_buffer_usartc0,1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x57:
	STS  _date1,R30
	STS  _date1+1,R31
	STS  _date1+2,R22
	STS  _date1+3,R23
	__GETD2N 0x64
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x58:
	__GETB1MN _rx_buffer_usartc0,2
	LDI  R31,0
	CALL __CWD1
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x59:
	CALL __CWD1
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5A:
	STS  _time1,R30
	STS  _time1+1,R31
	STS  _time1+2,R22
	STS  _time1+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5B:
	LDS  R30,_time1
	LDS  R31,_time1+1
	LDS  R22,_time1+2
	LDS  R23,_time1+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x5C:
	LDI  R26,LOW(_X)
	LDI  R27,HIGH(_X)
	CALL _get_CNTRTC
	RCALL SUBOPT_0x1D
	CALL __PUTPARD1
	RCALL SUBOPT_0x1C
	CALL __PUTPARD1
	LDI  R30,LOW(_date1)
	LDI  R31,HIGH(_date1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_time1)
	LDI  R27,HIGH(_time1)
	JMP  _calcDateTime

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5D:
	LDS  R26,_date1
	LDS  R27,_date1+1
	LDS  R24,_date1+2
	LDS  R25,_date1+3
	__GETD1N 0xF4240
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5E:
	__GETD1N 0x2710
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5F:
	LDS  R26,_date1
	LDS  R27,_date1+1
	LDS  R24,_date1+2
	LDS  R25,_date1+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x60:
	LDS  R30,_ch
	LDI  R31,0
	SUBI R30,LOW(-_bufdt)
	SBCI R31,HIGH(-_bufdt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x61:
	LDS  R26,_time1
	LDS  R27,_time1+1
	LDS  R24,_time1+2
	LDS  R25,_time1+3
	RJMP SUBOPT_0x5E

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:31 WORDS
SUBOPT_0x62:
	LDI  R30,LOW(_info)
	LDI  R31,HIGH(_info)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x63:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x64:
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	JMP  _monitor

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x65:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 30 TIMES, CODE SIZE REDUCTION:55 WORDS
SUBOPT_0x66:
	LDI  R30,LOW(_twie_master)
	LDI  R31,HIGH(_twie_master)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x67:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x68:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(2)
	CALL _twi_master_trans
	RJMP SUBOPT_0x66

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x69:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _twi_master_trans
	LDI  R26,LOW(26)
	LDI  R27,0
	CALL _delay_ms
	RJMP SUBOPT_0x66

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6B:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _twi_master_trans
	RJMP SUBOPT_0x66

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x6C:
	STS  _UP,R30
	STS  _UP+1,R31
	STS  _UP+2,R22
	STS  _UP+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x6D:
	LDS  R26,_UP
	LDS  R27,_UP+1
	LDS  R24,_UP+2
	LDS  R25,_UP+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6E:
	CALL __MULD12
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6F:
	CALL __ASRD12
	STS  _X1,R30
	STS  _X1+1,R31
	STS  _X1+2,R22
	STS  _X1+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x70:
	LDS  R26,_X1
	LDS  R27,_X1+1
	LDS  R24,_X1+2
	LDS  R25,_X1+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x71:
	STS  _X2,R30
	STS  _X2+1,R31
	STS  _X2+2,R22
	STS  _X2+3,R23
	RCALL SUBOPT_0x70
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x72:
	LDS  R30,_B5
	LDS  R31,_B5+1
	LDS  R22,_B5+2
	LDS  R23,_B5+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x73:
	__GETD1N 0x41200000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x74:
	LDS  R30,_B6
	LDS  R31,_B6+1
	LDS  R22,_B6+2
	LDS  R23,_B6+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x75:
	LDS  R26,_B6
	LDS  R27,_B6+1
	LDS  R24,_B6+2
	LDS  R25,_B6+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x76:
	CALL __CWD2
	RJMP SUBOPT_0x6E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x77:
	STS  _X3,R30
	STS  _X3+1,R31
	STS  _X3+2,R22
	STS  _X3+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x78:
	__ADDD1N 2
	CALL __ASRD1
	CALL __ASRD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x79:
	CALL __MULD12
	CALL __ASRD16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7A:
	LDS  R26,_B7
	LDS  R27,_B7+1
	LDS  R24,_B7+2
	LDS  R25,_B7+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7B:
	LDS  R30,_B4
	LDS  R31,_B4+1
	LDS  R22,_B4+2
	LDS  R23,_B4+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7C:
	LDS  R26,_p
	LDS  R27,_p+1
	LDS  R24,_p+2
	LDS  R25,_p+3
	LDI  R30,LOW(8)
	CALL __ASRD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7D:
	STS  _X1,R30
	STS  _X1+1,R31
	STS  _X1+2,R22
	STS  _X1+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7E:
	LDS  R30,_p
	LDS  R31,_p+1
	LDS  R22,_p+2
	LDS  R23,_p+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7F:
	LDS  R26,_p
	LDS  R27,_p+1
	LDS  R24,_p+2
	LDS  R25,_p+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x80:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _twi_master_trans
	LDI  R30,LOW(3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x81:
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(16)
	ST   -Y,R30
	LDI  R26,LOW(64)
	JMP  _ad7705_init

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x82:
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,219
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_date1
	LDS  R31,_date1+1
	LDS  R22,_date1+2
	LDS  R23,_date1+3
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x83:
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,2
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x84:
	LDI  R30,LOW(_file)
	LDI  R31,HIGH(_file)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_fNAME)
	LDI  R31,HIGH(_fNAME)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x85:
	CALL _f_open
	STS  _res,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x86:
	CALL _f_close
	STS  _res,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x87:
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x88:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x89:
	CALL _monitor
	LDI  R26,LOW(100)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8A:
	LDS  R26,_res
	JMP  _error

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8B:
	LDI  R30,LOW(_file)
	LDI  R31,HIGH(_file)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8C:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_path)
	LDI  R31,HIGH(_path)
	RJMP SUBOPT_0x64

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x8D:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(14)
	LDI  R31,HIGH(14)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_nbytes)
	LDI  R27,HIGH(_nbytes)
	CALL _f_write
	STS  _res,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x8E:
	__POINTW1FN _0x0,299
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_nbytes
	LDS  R31,_nbytes+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETD1N 0xE
	CALL __PUTPARD1
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
	JMP  _monitor

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8F:
	LDI  R26,LOW(_file)
	LDI  R27,HIGH(_file)
	RJMP SUBOPT_0x86

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x90:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_fNAME)
	LDI  R31,HIGH(_fNAME)
	RJMP SUBOPT_0x64

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x91:
	LDI  R30,LOW(_buffer)
	LDI  R31,HIGH(_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(36)
	LDI  R31,HIGH(36)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_nbytes)
	LDI  R27,HIGH(_nbytes)
	CALL _f_write
	STS  _res,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x92:
	LDS  R26,_RESULT_sr
	LDS  R27,_RESULT_sr+1
	LDS  R24,_RESULT_sr+2
	LDS  R25,_RESULT_sr+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x93:
	ST   X+,R30
	ST   X,R31
	LDS  R30,_nn
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x94:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ADD  R30,R0
	ADC  R31,R1
	MOVW R26,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x95:
	LDS  R30,_nn
	SUBI R30,-LOW(1)
	STS  _nn,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x96:
	SUBI R30,LOW(993)
	SBCI R31,HIGH(993)
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x419ECCCD
	CALL __DIVF21
	__GETD2N 0x43888000
	CALL __ADDF12
	__GETD2N 0x41200000
	CALL __MULF12
	CALL __CFD1U
	MOVW R4,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x97:
	LDS  R30,_RESULT
	LDS  R31,_RESULT+1
	CALL __ASRW8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x98:
	LDS  R30,_nn
	LDI  R26,LOW(_adca_SD)
	LDI  R27,HIGH(_adca_SD)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x99:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	CALL __LSRW4
	MOVW R26,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9A:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x9B:
	LDI  R26,LOW(50)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9C:
	CALL _monitor
	RJMP SUBOPT_0x9B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9D:
	LDI  R27,0
	CALL _delay_ms
	LDS  R30,1668
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x9E:
	LDS  R30,1668
	ANDI R30,0xEF
	STS  1668,R30
	RJMP SUBOPT_0x9B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9F:
	LDS  R30,1668
	ORI  R30,0x10
	STS  1668,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA0:
	LDI  R30,LOW(1)
	STS  1541,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA1:
	LDS  R26,_Tempf
	LDS  R27,_Tempf+1
	LDS  R24,_Tempf+2
	LDS  R25,_Tempf+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xA2:
	RCALL SUBOPT_0x73
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA3:
	RCALL SUBOPT_0x7F
	__GETD1N 0xA
	CALL __DIVD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA4:
	__GETB1MN _U1out,1
	ANDI R30,LOW(0x3F)
	__PUTB1MN _U1out,1
	__GETB1MN _U1out,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA5:
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA6:
	CALL __GETD1P
	__PUTD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA7:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA8:
	__GETD2S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xA9:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x3C
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	JMP  _disk_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xAA:
	__GETD2Z 34
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xAB:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x3B
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xAC:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2N 0x0
	JMP  _move_window_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xAD:
	RCALL SUBOPT_0x1C
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xAE:
	CALL __PUTDZ20
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xAF:
	CALL __GETD1P
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB0:
	__GETD2Z 18
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0xB1:
	__CPD2N 0x2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB2:
	CALL __GETD1P
	RJMP SUBOPT_0x37

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xB3:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	__GETD2S 6
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G101
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB4:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	MOVW R30,R18
	ANDI R31,HIGH(0x1FF)
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB5:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB6:
	__GETD1N 0x100
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xB7:
	__GETD2S 6
	CALL __ADDD21
	CALL _move_window_G101
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB8:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB9:
	CALL __GETW1P
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xBA:
	__GETD1N 0x80
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xBB:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xBC:
	__GETD2S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xBD:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	RCALL SUBOPT_0x41
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G101
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xBE:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	MOVW R30,R16
	ANDI R31,HIGH(0x1FF)
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xBF:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC0:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x45

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC1:
	RCALL SUBOPT_0x41
	CALL __ADDD21
	CALL _move_window_G101
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC2:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC3:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC4:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,30
	CALL __GETD1P
	RCALL SUBOPT_0xC3
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC5:
	__GETD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0xC6:
	__CPD2N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0xC7:
	__CPD2N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC8:
	__GETD2N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC9:
	__GETD2Z 14
	RJMP SUBOPT_0xC7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xCA:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL __GETD1P_INC
	RCALL SUBOPT_0x29
	CALL __PUTDP1_DEC
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xCB:
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xCC:
	RCALL SUBOPT_0x30
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xCD:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xCE:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xCF:
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD0:
	__GETD2S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD1:
	RCALL SUBOPT_0x3C
	RCALL SUBOPT_0x41
	CALL __CPD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD2:
	RCALL SUBOPT_0x33
	RCALL SUBOPT_0x42
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD3:
	__GETD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD4:
	__GETD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD5:
	CALL __SWAPD12
	CALL __SUBD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD6:
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD7:
	CALL __GETD1P
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xD8:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xD9:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xDA:
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	RCALL SUBOPT_0xD8
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xDB:
	__GETD1S 2
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xDC:
	__GETD1S 2
	__PUTD1SNS 8,10
	RJMP SUBOPT_0xD9

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xDD:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xDE:
	CLR  R22
	CLR  R23
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xDF:
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	LSL  R30
	CALL __LSLW4
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE0:
	CALL __GETD1P
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0xE1:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE2:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	__GETD2Z 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE3:
	RCALL SUBOPT_0x37
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE4:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 6
	JMP  _clust2sect

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xE5:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _dir_seek_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xE6:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__GETD2Z 14
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xE7:
	ST   -Y,R19
	ST   -Y,R18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+20
	LDD  R27,Z+21
	ST   -Y,R27
	ST   -Y,R26
	LDI  R26,LOW(11)
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE8:
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE9:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xEA:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	SBIW R30,1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R16,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xEB:
	MOV  R30,R18
	SUBI R18,-1
	LDI  R31,0
	ADD  R30,R20
	ADC  R31,R21
	ST   Z,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xEC:
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	ST   X+,R30
	ST   X,R31
	CPI  R16,33
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xED:
	__PUTD1SNS 6,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xEE:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xEF:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF0:
	MOVW R26,R18
	ADIW R26,20
	RJMP SUBOPT_0xB9

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF1:
	MOVW R26,R18
	ADIW R26,26
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF2:
	CLR  R22
	CLR  R23
	CALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF3:
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xF4:
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	MOVW R26,R30
	CALL __GETW1P
	CPI  R30,LOW(0xAA55)
	LDI  R26,HIGH(0xAA55)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xF5:
	CALL __GETD1P
	__ANDD1N 0xFFFFFF
	__CPD1N 0x544146
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF6:
	LDI  R26,LOW(_FatFs_G101)
	LDI  R27,HIGH(_FatFs_G101)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF7:
	__PUTD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF8:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-64)
	SBCI R27,HIGH(-64)
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF9:
	__GETD2S 22
	RJMP SUBOPT_0xDE

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xFA:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+8
	LDD  R27,Z+9
	MOVW R30,R26
	CALL __LSRW4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xFB:
	__PUTD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xFC:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0xAA
	RCALL SUBOPT_0xD4
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xFD:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xFE:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xFF:
	LDD  R26,Z+2
	LDD  R27,Z+3
	CALL _validate_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x100:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x101:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x102:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0xC8
	JMP  _create_chain_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x103:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x104:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x105:
	__GETD2Z 22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x106:
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	CALL _disk_write
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x107:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x108:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x109:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	RCALL SUBOPT_0x105
	RJMP SUBOPT_0x3B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10A:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL __GETW1P
	ANDI R31,HIGH(0x1FF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10C:
	ADIW R30,6
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x10D:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10E:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10F:
	__GETD2S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x110:
	__PUTD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x111:
	__PUTD1SNS 21,6
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x112:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x113:
	__GETD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x114:
	RCALL SUBOPT_0x43
	MOVW R26,R30
	MOVW R24,R22
	__GETD1S 9
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x115:
	__GETD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x116:
	CALL __GETD1P
	__PUTD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x117:
	__GETD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x118:
	__PUTD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x119:
	__GETD2S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x11A:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11B:
	RCALL SUBOPT_0x117
	__PUTD1SNS 21,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x11C:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x11D:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11E:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11F:
	CALL __GETW1P
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x120:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x121:
	RCALL SUBOPT_0xCD
	RJMP SUBOPT_0xA2

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x122:
	RCALL SUBOPT_0x3C
	RCALL SUBOPT_0x3A
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x123:
	RCALL SUBOPT_0x3A
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RCALL SUBOPT_0x33
	SUBI R19,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x124:
	__GETD2N 0x3F000000
	CALL __ADDF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x125:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x126:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,1
	STD  Y+8,R26
	STD  Y+8+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x127:
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x128:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x129:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x12A:
	ST   -Y,R18
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x12B:
	__GETW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x12C:
	SBIW R30,4
	__PUTW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x12D:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x12E:
	__GETW2SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x12F:
	RCALL SUBOPT_0x12B
	RJMP SUBOPT_0x12C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x130:
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	CALL _strlen
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x131:
	RCALL SUBOPT_0x12E
	ADIW R26,4
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x132:
	ANDI R16,LOW(251)
	LDD  R30,Y+21
	ST   -Y,R30
	__GETW2SX 87
	__GETW1SX 89
	ICALL
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x133:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x134:
	__GETD1S 2
	RJMP SUBOPT_0x11D


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1F40
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ANDD12:
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	RET

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__ASRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __ASRD12R
__ASRD12L:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRD12L
__ASRD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRD1:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	RET

__LSRW4:
	LSR  R31
	ROR  R30
__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__LSLD1:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__ASRD16:
	MOV  R30,R22
	MOV  R31,R23
	CLR  R22
	SBRC R31,7
	SER  R22
	MOV  R23,R22
	RET

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__LSLD16:
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__COMD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__MULD12:
	RCALL __CHKSIGND
	RCALL __MULD12U
	BRTC __MULD121
	RCALL __ANEGD1
__MULD121:
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVB21:
	RCALL __CHKSIGNB
	RCALL __DIVB21U
	BRTC __DIVB211
	NEG  R30
__DIVB211:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODB21:
	CLT
	SBRS R26,7
	RJMP __MODB211
	NEG  R26
	SET
__MODB211:
	SBRC R30,7
	NEG  R30
	RCALL __DIVB21U
	MOV  R30,R26
	BRTC __MODB212
	NEG  R30
__MODB212:
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__MODD21:
	CLT
	SBRS R25,7
	RJMP __MODD211
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	SUBI R26,-1
	SBCI R27,-1
	SBCI R24,-1
	SBCI R25,-1
	SET
__MODD211:
	SBRC R23,7
	RCALL __ANEGD1
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	BRTC __MODD212
	RCALL __ANEGD1
__MODD212:
	RET

__MANDD12:
	CLT
	SBRS R23,7
	RJMP __MANDD121
	RCALL __ANEGD1
	SET
__MANDD121:
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	BRTC __MANDD122
	RCALL __ANEGD1
__MANDD122:
	RET

__CHKSIGNB:
	CLT
	SBRS R30,7
	RJMP __CHKSB1
	NEG  R30
	SET
__CHKSB1:
	SBRS R26,7
	RJMP __CHKSB2
	NEG  R26
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSB2:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTDZ20:
	ST   Z,R26
	STD  Z+1,R27
	STD  Z+2,R24
	STD  Z+3,R25
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDD:
	WDR
	LDS  R30,NVM_STATUS
	SBRC R30,7
	RJMP __EEPROMRDD
	SUBI R27,-0x10
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SUBI R26,LOW(0x1003)
	SBCI R27,HIGH(0x1003)
	RET

__EEPROMWRD:
	RCALL __EEPROMWRW
	ADIW R26,2
	MOVW R0,R30
	MOVW R30,R22
	RCALL __EEPROMWRW
	MOVW R30,R0
	SBIW R26,2
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
	RCALL __NVMREADY
	SUBI R27,-0x10
	LD   R24,X
	CP   R24,R30
	BRNE __EEPROMWRB1
	SUBI R27,0x10
	RET
__EEPROMWRB1:
	MOV  R25,R30

__EEPROMWRA:
	RCALL __NVMREADY
	PUSH R23
	IN   R23,SREG
	CLI
	ST   X,R25
	SUBI R27,0x10
	STS  NVM_ADDR0,R26
	STS  NVM_ADDR1,R27
	LDI  R24,0
	STS  NVM_ADDR2,R24
	LDI  R24,0x35
	STS  NVM_CMD,R24
	LDI  R24,0xD8
	LDI  R25,0x01
	OUT  CCP,R24
	STS  NVM_CTRLA,R25
	RCALL __NVMREADY
	LDI  R24,0
	STS  NVM_CMD,R24
	OUT  SREG,R23
	POP  R23
	RET

__NVMREADY:
	WDR
	LDS  R24,NVM_STATUS
	SBRC R24,7
	RJMP __NVMREADY
	RET

__CPD01:
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	CPC  R0,R22
	CPC  R0,R23
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
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

__LOADLOCR6:
	LDD  R21,Y+5
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

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
