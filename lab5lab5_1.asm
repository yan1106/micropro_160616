;
;TJ16 �� LJ12
;TJ21 �� LJ11
;PJ13 �� LPJ7
;
#include "tx3703.inc"

	RS_LCM	BIT		P3.5	;LCM��RS�T��
	RW_LCM	BIT		P3.6	;LCM��RW�T��
	EN_LCM	BIT		P3.7	;LCM��EN�T��

	CC0		DATA 	20H
	CC1		DATA 	21H

		ORG		000H
		LJMP	START
		ORG		400H
		
START:
		;�]�wI/O  //P3=7.EN 6.RW 5.RS   //   P0=DB7~DB0		
		MOV		P0OE,#11111111B		;7~0 OUTPUT
		MOV		P3MODH,#10101000B		;7~5 OUTPUT
		MOV		P0,#0
		MOV		P3,#0

		;��l��LCM
		; �i��T���R�O�g�J�ʧ@�ε��ԾA��ɶ�����A���t��í�w�ALCM�}���᳣�ݭn�@�q�ɶ�����LCMí�w(�ULCM��DATASHEET�j�h���|����)
		;���B��LCM����X�ԲӸ�ƥi�ѦҤ�r��LCM����

		LCALL		Delay	;����LCM�Ұ�
		LCALL		Delay	;����LCM�Ұ�
		MOV	        A,#0x30	; �\��]�w�G�]�wDL=N=F=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x30	; �\��]�w�G�]�wDL=N=F=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x30	; �\��]�w�G�]�wDL=N=F=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

    	LCALL		Delay	;

		MOV	        A,#0x38	; �\��]�w�G�]�wDL=N=1,F=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x08	; ��ܾ�����GD=C=B=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x01	; �M�����  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x06	; �Ҧ��]�w�GI/D=1, S=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		MOV	        A,#0x0e	; ��ܾ�����GD=C=1, B=0  �N�R�O�X���A
		LCALL		WriteIR	; �N�R�O�X�g��LCM

		;��в���Ĥ@��}�Y
		MOV			A,#0x80			; �]�wDD RAM��}��00H
		ACALL		WriteIR			; �N�R�O�X�g��LCM
		;�Ĥ@��q�r
		MOV			A,#' '
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'D'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'0'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'3'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'6'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'8'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'7'
		ACALL		WriteDR	
		MOV			A,#'2'
		ACALL		WriteDR	
		MOV			A,#'2'
		ACALL		WriteDR	

		;��в���ĤG��}�Y
		MOV			A,#0xC0			; �]�wDD RAM��}��00H
		ACALL		WriteIR			; �N�R�O�X�g��LCM
		;�ĤG��q�r
		MOV			A,#' '
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#' '
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#' '
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'1'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'9'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'9'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'3'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'.'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'1'
		ACALL		WriteDR			; �N�r����ASCII Code�g�JLCM�O����
		MOV			A,#'1'
		ACALL		WriteDR
		MOV			A,#'.'
		ACALL		WriteDR
		MOV			A,#'0'
		ACALL		WriteDR
		MOV			A,#'6'
		ACALL		WriteDR
		
		
		
		
		
		JMP		$

;�N"����R�O�X"�g�JLCM���O�Ȧs�����Ƶ{��
WriteIR:
		CLR		RS_LCM		; RS=0 ��ܫ��O�Ȧs��
		CLR		RW_LCM		; RW=0 ��ܶi��g�J�ʧ@
		SETB	EN_LCM		; EN=1 �}��LCMŪ�g�\��
		MOV	    P0,A		; �NA���ȥ�P0�e�X = �e�X�R�O�X	
		LCALL	Delay		; ���Ԥ@�q�ɶ��A����Ƨ����g�J�ʧ@
		CLR		EN_LCM		; EN=0 ����LCMŪ�g�\��
		RET					; ��^�I�s�禡

;�N"���"�g�JLCM�O���骺�Ƶ{��	
WriteDR:
		SETB	RS_LCM		; RS=1 ��ܸ�ưO����
		CLR		RW_LCM		; RW=0 ��ܶi��g�J�ʧ@
		SETB	EN_LCM		; EN=1 �}��LCMŪ�g�\��
		MOV		P0,A		; �NA���ȥ�P0�e�X = �e�X���
		LCALL	Delay		; ���Ԥ@�q�ɶ��A����Ƨ����g�J�ʧ@
		CLR		EN_LCM		; EN=0 ����LCMŪ�g�\��
		RET					; ��^�I�s�禡

Delay:
		MOV		CC0,#10
CC:		MOV		CC1,#100
		DJNZ	CC1,$
		DJNZ	CC0,CC
		RET

		END