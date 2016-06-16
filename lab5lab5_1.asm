;
;TJ16 接 LJ12
;TJ21 接 LJ11
;PJ13 接 LPJ7
;
#include "tx3703.inc"

	RS_LCM	BIT		P3.5	;LCM的RS訊號
	RW_LCM	BIT		P3.6	;LCM的RW訊號
	EN_LCM	BIT		P3.7	;LCM的EN訊號

	CC0		DATA 	20H
	CC1		DATA 	21H

		ORG		000H
		LJMP	START
		ORG		400H
		
START:
		;設定I/O  //P3=7.EN 6.RW 5.RS   //   P0=DB7~DB0		
		MOV		P0OE,#11111111B		;7~0 OUTPUT
		MOV		P3MODH,#10101000B		;7~5 OUTPUT
		MOV		P0,#0
		MOV		P3,#0

		;初始化LCM
		; 進行三次命令寫入動作及等候適當時間延遲，讓系統穩定，LCM開機後都需要一段時間等待LCM穩定(各LCM的DATASHEET大多都會註明)
		;此處的LCM控制碼詳細資料可參考文字型LCM介紹

		LCALL		Delay	;等候LCM啟動
		LCALL		Delay	;等候LCM啟動
		MOV	        A,#0x30	; 功能設定：設定DL=N=F=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x30	; 功能設定：設定DL=N=F=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x30	; 功能設定：設定DL=N=F=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

    	LCALL		Delay	;

		MOV	        A,#0x38	; 功能設定：設定DL=N=1,F=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x08	; 顯示器控制：D=C=B=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x01	; 清除顯示  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x06	; 模式設定：I/D=1, S=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		MOV	        A,#0x0e	; 顯示器控制：D=C=1, B=0  將命令碼放於A
		LCALL		WriteIR	; 將命令碼寫到LCM

		;游標移到第一行開頭
		MOV			A,#0x80			; 設定DD RAM位址為00H
		ACALL		WriteIR			; 將命令碼寫到LCM
		;第一行秀字
		MOV			A,#' '
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'D'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'0'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'3'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'6'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'8'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'7'
		ACALL		WriteDR	
		MOV			A,#'2'
		ACALL		WriteDR	
		MOV			A,#'2'
		ACALL		WriteDR	

		;游標移到第二行開頭
		MOV			A,#0xC0			; 設定DD RAM位址為00H
		ACALL		WriteIR			; 將命令碼寫到LCM
		;第二行秀字
		MOV			A,#' '
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#' '
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#' '
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'1'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'9'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'9'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'3'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'.'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'1'
		ACALL		WriteDR			; 將字元的ASCII Code寫入LCM記憶體
		MOV			A,#'1'
		ACALL		WriteDR
		MOV			A,#'.'
		ACALL		WriteDR
		MOV			A,#'0'
		ACALL		WriteDR
		MOV			A,#'6'
		ACALL		WriteDR
		
		
		
		
		
		JMP		$

;將"控制命令碼"寫入LCM指令暫存器的副程式
WriteIR:
		CLR		RS_LCM		; RS=0 選擇指令暫存器
		CLR		RW_LCM		; RW=0 選擇進行寫入動作
		SETB	EN_LCM		; EN=1 開啟LCM讀寫功能
		MOV	    P0,A		; 將A的值由P0送出 = 送出命令碼	
		LCALL	Delay		; 等候一段時間，讓資料完成寫入動作
		CLR		EN_LCM		; EN=0 關閉LCM讀寫功能
		RET					; 返回呼叫函式

;將"資料"寫入LCM記憶體的副程式	
WriteDR:
		SETB	RS_LCM		; RS=1 選擇資料記憶體
		CLR		RW_LCM		; RW=0 選擇進行寫入動作
		SETB	EN_LCM		; EN=1 開啟LCM讀寫功能
		MOV		P0,A		; 將A的值由P0送出 = 送出資料
		LCALL	Delay		; 等候一段時間，讓資料完成寫入動作
		CLR		EN_LCM		; EN=0 關閉LCM讀寫功能
		RET					; 返回呼叫函式

Delay:
		MOV		CC0,#10
CC:		MOV		CC1,#100
		DJNZ	CC1,$
		DJNZ	CC0,CC
		RET

		END