.EQU SERVO_PORT_H = 0x49
.EQU SERVO_PORT_V = 0x50
.EQU LED_PORT   = 0x40
.EQU SEG_PORT   = 0x81
.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.EQU COUNT = 0xFF	;0xFF
.EQU COUNT_3 = 0x5E	; 94
.EQU COUNT_5 = 0x9A	; 154
.EQU COUNT_6 = 0x4B	; 74

.CSEG
.ORG 0x01

		MOV R6,0x00
		OUT R6, LED_PORT
		MOV R5,0x04		; Reset CCW
		MOV R9,0x00		; H counter
		MOV R8,0x01		; Move CW
		MOV R7,0x00		; V counter
main:	
		CMP R7,0x0A		; 0x28 40 times
		BREQ end
R:		
		OUT R9,SEG_PORT
		CMP R9,0x0A		; 0x50 80 times
		BREQ L
		ADD R9,0x01
		OUT R8,SERVO_PORT_H
		CALL DELAY	
		BRN R
L:
		OUT R9,SEG_PORT
		MOV R9,0x00	
		OUT R5,SERVO_PORT_H
		CALL DELAY
D:		
		ADD R7,0x01
		OUT R8,SERVO_PORT_V
		CALL DELAY		
		BRN main
end:	
		MOV R6,0x01
		OUT R6,LED_PORT
FINAL:	BRN FINAL

; Uses R1, R2, R3
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
