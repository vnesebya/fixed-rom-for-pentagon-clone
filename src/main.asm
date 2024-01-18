;=========================================== Конфиг =================================================

; Позиция меню
MENU_HEAD_POS			EQU 9
; Цвет полоски меню

							;FBGRBgrb
MENU_ATTR   			EQU %00111000  		; (Flash)
    
                        ; DEFINE PENTAGON_1024


;====================================================================================================


                        IFDEF   PENTAGON_1024
                            INCLUDE "tr-dos611q.asm"
                        ENDIF
                        
                        INCLUDE "const.asm"

                        DEVICE  	ZXSPECTRUM48

                        ORG    0
BANK0:
                        ORG     ROM_PAGE_BANK0_ADDR
                        INCBIN "incbin/empty.bin"			
TRDOS:
                        ORG     ROM_PAGE_TRDOS_ADDR
                        IFDEF   PENTAGON_1024
                            INCBIN "incbin/trdos-6.11q.bin"
                        ELSE
                            INCBIN "incbin/trdos-5.03.bin"
                        ENDIF
SOS128k:
                        ORG     ROM_PAGE_128k_ADDR
                        INCBIN	"incbin/sos-128.bin"
SOS_48k:
                        ORG     ROM_PAGE_48k_ADDR
                        INCBIN	"incbin/sos-48.bin"

;========================================== Патчи ===================================================
BEGIN:
                        IFDEF   PENTAGON_1024
                            ; В Пентагоне 1024
                            ; Ничего не патчим в TR-DOS 6.11q 
                        ELSE
                            ; В Пентагоне 128к
                            ; патчим TR-DOS 5.03 
                            INCLUDE "tr-dos503-patch.asm"
                        ENDIF

                            ; Патчим меню
                        INCLUDE "sos-128-patch.asm"
;====================================================================================================
END:

                        SAVEBIN	"build/pent.rom",0,0x10000


