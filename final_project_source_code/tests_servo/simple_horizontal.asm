.EQU SERVO_PORT_H = 0x49
.EQU SERVO_PORT_V = 0x50
.EQU LED_PORT   = 0x40
.EQU SEG_PORT   = 0x81
.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.EQU COUNT = 0xFF;0xFF
.EQU COUNT_3 = 0x5E	; 94
.EQU COUNT_5 = 0x9A	; 154
.EQU COUNT_6 = 0x4B	; 74

.CSEG
.ORG 0x01

start:	MOV R6,0x00
		OUT R6, LED_PORT
		MOV R5,0x01		; horizontal servo command
		MOV R4,0x00
		MOV R3,0x01		; vertical servo command
		MOV R2,0x00
main:	CMP R2,0x28
		BREQ end
R:		OUT R4, SEG_PORT
		CMP R4,0x50		; 80 times
		BREQ L
		ADD R4,0x01
		OUT R5,SERVO_PORT_H
		CALL DELAY	
		BRN R
L:		OUT R4, SEG_PORT		
		CMP R4,0x00
		BREQ D
		MOV R5,0x04
		SUB R4,0x01
		OUT R5,SERVO_PORT_H
		CALL DELAY		
		BRN L
D:		ADD R2,0x01
		OUT R3, SERVO_PORT_V
		CALL DELAY		
		BRN main
end:	MOV R6,0x01
		OUT R6,LED_PORT
FINAL:	BRN FINAL

DELAY:
		MOV R1, COUNT
loop1:	MOV R2, COUNT
loop2:	MOV R3, COUNT_3
loop3:	SUB R3, 1		; count3--
		BRNE loop3
		SUB R2, 1		; count2--
		BRNE loop2
		SUB R1, 1		; count1--
		BRNE loop1
		MOV R1, COUNT
loop4:	MOV R2, COUNT_5
loop5:	SUB R2, 1		; count5--
		BRNE loop5
		SUB R1, 1		; count4--
		BRNE loop4
		MOV R1, COUNT_6
loop6:	SUB R1, 1		; count6--
		BRNE loop6
		RET
