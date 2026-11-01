; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBD035
DATA8_CBD035:						; raw frame tiles for transfer index $365; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$35..$235
DATA8_CBD235:						; raw frame tiles for transfer index $366; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$235..$435
DATA8_CBD435:						; raw frame tiles for transfer index $367; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$435..$635
DATA8_CBD635:						; raw frame tiles for transfer index $368; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$635..$835
DATA8_CBD835:						; raw frame tiles for transfer index $369; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$835..$A35
DATA8_CBDA35:						; raw frame tiles for transfer index $36A; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$A35..$C35
DATA8_CBDC35:						; raw frame tiles for transfer index $36B; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$C35..$E35
DATA8_CBDE35:						; raw frame tiles for transfer index $36C; pose not traced
	incbin "../Extracted/segments/bankCB_D000.bin":$E35..$1000
	incbin "../Extracted/segments/bankCB_E000.bin":$0..$35
