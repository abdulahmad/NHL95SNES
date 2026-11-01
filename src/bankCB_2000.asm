; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB2155
DATA8_CB2155:						; raw frame tiles for transfer index $2E1; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$155..$3B5
DATA8_CB23B5:						; raw frame tiles for transfer index $2E2; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$3B5..$615
DATA8_CB2615:						; raw frame tiles for transfer index $2E3; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$615..$815
DATA8_CB2815:						; raw frame tiles for transfer index $2E4; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$815..$A75
DATA8_CB2A75:						; raw frame tiles for transfer index $2E5; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$A75..$C75
DATA8_CB2C75:						; raw frame tiles for transfer index $2E6; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$C75..$ED5
DATA8_CB2ED5:						; raw frame tiles for transfer index $2E7; pose not traced
	incbin "../Extracted/segments/bankCB_2000.bin":$ED5..$1000
	incbin "../Extracted/segments/bankCB_3000.bin":$0..$D5
