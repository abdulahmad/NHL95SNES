; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB1175
DATA8_CB1175:						; raw frame tiles for transfer index $2DA; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$175..$3D5
DATA8_CB13D5:						; raw frame tiles for transfer index $2DB; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$3D5..$635
DATA8_CB1635:						; raw frame tiles for transfer index $2DC; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$635..$895
DATA8_CB1895:						; raw frame tiles for transfer index $2DD; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$895..$AF5
DATA8_CB1AF5:						; raw frame tiles for transfer index $2DE; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$AF5..$D55
DATA8_CB1D55:						; raw frame tiles for transfer index $2DF; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$D55..$F55
DATA8_CB1F55:						; raw frame tiles for transfer index $2E0; pose not traced
	incbin "../Extracted/segments/bankCB_1000.bin":$F55..$1000
	incbin "../Extracted/segments/bankCB_2000.bin":$0..$155
