; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBE035
DATA8_CBE035:						; raw frame tiles for transfer index $36D; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$35..$235
DATA8_CBE235:						; raw frame tiles for transfer index $36E; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$235..$435
DATA8_CBE435:						; raw frame tiles for transfer index $36F; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$435..$695
DATA8_CBE695:						; raw frame tiles for transfer index $370; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$695..$895
DATA8_CBE895:						; raw frame tiles for transfer index $371; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$895..$AF5
DATA8_CBEAF5:						; raw frame tiles for transfer index $372; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$AF5..$CF5
DATA8_CBECF5:						; raw frame tiles for transfer index $373; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$CF5..$F75
DATA8_CBEF75:						; raw frame tiles for transfer index $374; pose not traced
	incbin "../Extracted/segments/bankCB_E000.bin":$F75..$1000
	incbin "../Extracted/segments/bankCB_F000.bin":$0..$175
