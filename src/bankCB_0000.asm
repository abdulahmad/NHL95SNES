; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB08B5
DATA8_CB08B5:						; raw frame tiles for transfer index $2D6; pose not traced
	incbin "../Extracted/segments/bankCB_0000.bin":$8B5..$B15
DATA8_CB0B15:						; raw frame tiles for transfer index $2D7; pose not traced
	incbin "../Extracted/segments/bankCB_0000.bin":$B15..$D15
DATA8_CB0D15:						; raw frame tiles for transfer index $2D8; pose not traced
	incbin "../Extracted/segments/bankCB_0000.bin":$D15..$F75
DATA8_CB0F75:						; raw frame tiles for transfer index $2D9; pose not traced
	incbin "../Extracted/segments/bankCB_0000.bin":$F75..$1000
	incbin "../Extracted/segments/bankCB_1000.bin":$0..$175
