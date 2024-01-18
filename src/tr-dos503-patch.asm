BRIGHTBIT			EQU 0
FLASHBIT			EQU 128

TRDOS_RAINBOW_SHIFT	EQU 2
TRDOS_RAINBOW_SIZE	EQU 11


                    DEVICE  	ZXSPECTRUM48

					; Надпись в внизу
					ORG		ROM_PAGE_TRDOS_ADDR + #0360
					;                              " 1986 Sinclair Research Ltd"
					; 								  Внимание !!! 26 символов
					DB	    #16, 1, 6
					DB	    "* TR-DOS Ver 5.03 *"
					DB      #0D,#0D
					DB      COPYRIGHT_SYMBOL, " 1986 Technology Research Ltd."
					
					DB	    #16, 5,13
					DB      "(U.K.)"
					
					DB	    #16, 7, 5 + TRDOS_RAINBOW_SHIFT
					DB      "BETA 128"



					; Надпись в внизу
					ORG		ROM_PAGE_TRDOS_ADDR + #106E
x106E       		LD      HL,#58E5 + TRDOS_RAINBOW_SHIFT   ;адрес линии атрибутов
            		LD      B, TRDOS_RAINBOW_SIZE        ;(VELESOFT - black attributes size)
x1073   			LD      (HL),#7 
					INC     HL
					DJNZ    x1073
					LD      (HL),#2 + BRIGHTBIT
					INC     HL
					LD      (HL),#16 + BRIGHTBIT
					INC     HL
					LD      (HL),#34 + BRIGHTBIT
					INC     HL
					LD      (HL),#25 + BRIGHTBIT
					INC     HL
					LD      (HL),#28 + BRIGHTBIT
					INC     HL
					LD      (HL),7 + BRIGHTBIT

					; ; LD      HL,#40EE    ;адрес верхней линии пикселей
            		; LD      HL,#40F2    ;(VELESOFT - new position for rainbow)

					ORG		ROM_PAGE_TRDOS_ADDR + #108A
					;                              " 1986 Sinclair Research Ltd"
					; 								  Внимание !!! 26 символов
					DW	    #40EE + TRDOS_RAINBOW_SHIFT + TRDOS_RAINBOW_SIZE - 10