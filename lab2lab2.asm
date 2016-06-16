#include "tx3703.inc"

	Rozero 	 EQU 0E0H  ;11100000b
	Rtzero   EQU 0D0H  ;11010001b
	Lozero 	 EQU 0B0H  ;10110000b
	Ltthree	 EQU 073H  ;01110011b			
	Rthree   EQU 0D3H  	
	Ltzero	 EQU 070H  
	
	
	
	TEN 	EQU 0EAH  ;11101010b
	THR     EQU 0D3H  ;11010011b
	CON     EQU 000H
	TEN_L 	EQU 0BAH  ;10111010b
	THL     EQU 073H
	   
	
	
	ROne	EQU 62H	  ;Memory address,??????????????????*???
	RTen	EQU 63H	  ;Memory address,??????????????????*???		
	LOne	EQU 60H	  ;Memory address,??????????????????*???
	LTen	EQU 61H	  ;Memory address,??????????????????*???
	
	
	ROne_2	EQU 62H	  ;Memory address,??????????????????*???
	RTen_2	EQU 63H	  ;Memory address,??????????????????*???		
	LOne_2	EQU 60H	  ;Memory address,??????????????????*???
	LTen_2	EQU 61H	  ;Memory address,??????????????????*???
	
	
	ORG 000h
	AJMP Start
	ORG 400h
Start:

	MOV P0OE,#11111111b;
	MOV P0,#11111111b;
	
	MOV ROne,#Rozero 	;Memory address ROne ??4 
	MOV RTen,#Rtzero 	;Memory address RTen ??1
	MOV LOne,#Lozero  	;Memory address LOne ??0
	MOV LTen,#Ltthree  	;Memory address LTen ??2
	
	
S1:
	MOV R2,#20 ;為了讓四個七段同時顯示
S2:
	MOV P0,ROne
	ACALL delay_1s
	
	MOV P0,RTen
	ACALL delay_1s
	
	MOV P0,LOne
	ACALL delay_1s
	
	MOV P0,LTen
	ACALL delay_1s

	DJNZ R2,S2 ;每次減一,若不為0則跳S2
	
	MOV A,LOne
	CJNE A,#Lozero,S5 ;不相等才會跳
	AJMP S6
	
	
S6: DEC LTen
	MOV LOne,#0BAH
	AJMP S5


S5:	INC ROne
	DEC LOne
	MOV A,ROne
	CJNE A,#TEN,S1      ;01111010b
	MOV ROne,#Rozero	;initialize Digit Four	
	INC RTen
	MOV A,RTen
	CJNE A,#THR,S1
	MOV ROne,#0E0H
	MOV RTen,#0D3H
	MOV LOne,#0B0H
	MOV LTen,#070H
	MOV R3,#20
	
S3:	MOV P0,ROne
	ACALL delay_1s
	
	MOV P0,RTen
	ACALL delay_1s
	
	MOV P0,LOne
	ACALL delay_1s
	
	MOV P0,LTen
	ACALL delay_1s
	DJNZ R3,S3
	MOV R3,#20
	
S4: MOV P0,ROne
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,RTen
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,LOne
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,LTen
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	DJNZ R3,S4
	AJMP Start_2

Start_2:

	MOV ROne_2,#Rozero  	;Memory address ROne ??4 
	MOV RTen_2,#Rthree	  ;Memory address RTen ??1
	MOV LOne_2,#Lozero	  ;Memory address LOne ??0
	MOV LTen_2,#Ltzero	  ;Memory address LTen ??2	


Sch_1:
	 MOV R1,#20	 
		
S_temp:
	MOV P0,ROne_2
	ACALL delay_1s
		
	MOV P0,RTen_2
	ACALL delay_1s
		
	MOV P0,LOne_2
	ACALL delay_1s
		
	MOV P0,LTen_2
	ACALL delay_1s	
	DJNZ R1,S_temp

	MOV  A,ROne_2 ;用左邊判斷
	CJNE A,#RoZero,S5_2 ;當A與Lozero_2不相等跳至S5_2
	AJMP S6_2
			

S6_2: 
	DEC RTen_2
	MOV ROne_2,#0EAH
	AJMP S5_2

	
	
S5_2:
    INC LOne_2
	DEC ROne_2
	MOV A,LOne_2
	CJNE A,#TEN_L,Sch_1
	MOV LOne_2,#Lozero	;initialize Digit Four	
	INC LTen_2
	MOV A,LTen_2
	CJNE A,#THL,Sch_1
	MOV ROne_2,#0E0H
	MOV RTen_2,#0D0H
	MOV LOne_2,#0B0H
	MOV LTen_2,#073H
	MOV R3,#20



	

Sf:	MOV P0,ROne_2
	ACALL delay_1s
	
	MOV P0,RTen_2
	ACALL delay_1s
	
	MOV P0,LOne_2
	ACALL delay_1s
	
	MOV P0,LTen_2
	ACALL delay_1s
	DJNZ R3,Sf
	MOV R3,#20
S4_2: 
	MOV P0,ROne_2
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,RTen_2
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,LOne_2
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,LTen_2
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	ACALL delay_1s
	MOV P0,#0F0H
	ACALL delay_1s
	DJNZ R3,S4_2
	AJMP Start


	
	

delay_1s:
	MOV R5,#10
	D1:
	MOV  R6,#10
	DJNZ R6,$
	DJNZ R5,D1
	RET
	
	END