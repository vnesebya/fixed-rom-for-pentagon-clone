; Меню


; Заголовок меню
TEXT_HEADER_MENU_ADDR		EQU #2755

; Список меню
ITEMS_MENU_ADDR				EQU #2744
TEXT_ITEMS_MENU_ADDR		EQU #275E

; Адреса обработчиков списка меню
TR_DOS_HANDLER				EQU #2816
TAPE_LOADER_HANDLER			EQU #2831
BASIC_128_HANDLER			EQU #286C
CALCULATOR_HANDLER			EQU #2885
BASIC_48_HANDLER	 		EQU #1B47

; Банеры с косыми полосками 
; Адреса c текстом банеров
SHIFT_FOR_BANNER_ADDR		EQU 6
TAPE_LOADER_BANNER_ADDR		EQU #275e
BASIC_128_BANNER_ADDR		EQU #2769
CALCULATOR_BANNER_ADDR		EQU #2772 
BASIC_48_BANNER_ADDR		EQU #277C ; не используется походу
TR_DOS_BANER_ADDR		EQU #2784 ; тоже не видел

; Адреса рутин печати надписей в баннерах
TAPE_LOADER_BANNER_ROUTINE_ADDR	EQU #3852 
BASIC_128_BANNER_ROUTINE_ADDR	EQU #3848
CALCULATOR_BANNER_ROUTINE_ADDR	EQU #384d



				DEVICE  	ZXSPECTRUM48

				;Кастомизация ---------------------------
				; Цвет полоски селектора меню
				ORG	ROM_PAGE_128k_ADDR + #37E0
				DB	MENU_ATTR			

				; Фискс позиции меню на экране
				; Сдвиг позиции шапки меню
				ORG	ROM_PAGE_128k_ADDR + #37EE
				DB	MENU_HEAD_POS		

				; Сдвиг позиции полоски селектора меню 
				ORG	ROM_PAGE_128k_ADDR + #37CE
				DB	MENU_HEAD_POS  		

				; Сдвиг позиции пунктов меню
				ORG	ROM_PAGE_128k_ADDR + #36CC
				DB	MENU_HEAD_POS   	

				; Сдвиг рамки меню
				ORG	ROM_PAGE_128k_ADDR + #36F1
				DB	MENU_HEAD_POS*8 	

				; Фикс процедуры стирания / восстановления меню
				; Сдвиг позиции сохранения меню
				ORG	ROM_PAGE_128k_ADDR + #375D
				DB	MENU_HEAD_POS		

				; Фикс стирания меню
				ORG	ROM_PAGE_128k_ADDR+#377F
				DB	MENU_HEAD_POS+7		


				; Напись в шапке меню ---------------------------------
				ORG	ROM_PAGE_128k_ADDR + TEXT_HEADER_MENU_ADDR
				;	"        " ; Внимание !!! 8 символов	
				
				
				IFDEF   PENTAGON_1024
					DB	"Pent1024" ; Внимание !!! 8 символов
				ELSE
					DB	"Pent128 " ; Внимание !!! 8 символов
				ENDIF

				; Пункты меню  указатели обработчиков -----------------
				ORG	ROM_PAGE_128k_ADDR + ITEMS_MENU_ADDR
				DB	5					; Количество пунтов меню

				DB	0					; Пункт меню  
				DW	TR_DOS_HANDLER		; Адрес вызова

				DB	1					; Пункт меню
				DW	TAPE_LOADER_HANDLER	; Адрес обработчика

				DB	2					; Пункт меню
				DW	BASIC_128_HANDLER	; Адрес обработчика 

				DB	3					; Пункт меню
				DW	CALCULATOR_HANDLER	; Адрес обработчика

				DB	4					; Пункт меню
				DW	BASIC_48_HANDLER	; Адрес обработчика



				; Текст меню ----------------------------------------
				ORG		ROM_PAGE_128k_ADDR + TEXT_ITEMS_MENU_ADDR 
				DC	 "TR-DOS"
				DC	"Tape Loader"
				DC	"128 Basic"
				DC	"Calculator"
				DC	"48 Basic"


				; Банеры --------------------------------------------  
				; Tape Loader
				ORG		ROM_PAGE_128k_ADDR + TAPE_LOADER_BANNER_ROUTINE_ADDR + 1
				DW 		TAPE_LOADER_BANNER_ADDR + SHIFT_FOR_BANNER_ADDR

				; Basic 128
				ORG		ROM_PAGE_128k_ADDR + BASIC_128_BANNER_ROUTINE_ADDR + 1	
				DW 		BASIC_128_BANNER_ADDR + SHIFT_FOR_BANNER_ADDR

				; Calculator
				ORG		ROM_PAGE_128k_ADDR + CALCULATOR_BANNER_ROUTINE_ADDR + 1
				DW 		CALCULATOR_BANNER_ADDR + SHIFT_FOR_BANNER_ADDR


				; Текст внизу экрана
				ORG		ROM_PAGE_128k_ADDR+#0561
				; DB    COPYRIGHT_SYMBOL					; Знак копирайта
				; DC     " 1986 Sinclair Research Ltd"		; Старая надпись

				;               Экран ZX-SPECTRUM
				;        01234567890123456789012345678901
				;       |================================|
				;    0  |                                |
				;    1  |                                |
				;    2  |                                |
				;    3  |                                |
				;    4  |                                |
				;    5  |                                |
				;    7  |        |PENT 128 //// |        |
				;    8  |        | TR-DOS       |        |
				;    9  |        | Tape Loader  |        |
				;   10  |        | 128 Basic    |        |
				;   11  |        | Calculator   |        |
				;   12  |        | 48 Basic     |        |
				;   13  |        |              |        |                    
				;   14  |        ----------------        |            
				;   15  |                                |
				;   16  |                                |
				;   17  |                                |
				;   18  |                                |
				;   19  |                                |
				;   20  |                                |
				;   21  |                                |
				;   22  |                                |

				IFDEF   PENTAGON_1024
				DC	    "   1991-2024 Pentagon 1024k ";  | Ограничение строки в 28 байт !
				ELSE
				DC	    "   1991 ATM128/Pentagon-128K";  | Ограничение строки в 28 байт !
				ENDIF
				;	    |================================|