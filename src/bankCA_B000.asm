; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAB219
DATA8_CAB219:						; raw frame tiles for transfer index $28F; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$219..$419
DATA8_CAB419:						; raw frame tiles for transfer index $291; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$419..$699
DATA8_CAB699:						; raw frame tiles for transfer index $292; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$699..$899
DATA8_CAB899:						; raw frame tiles for transfer index $294; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$899..$AF9
DATA8_CABAF9:						; raw frame tiles for transfer index $295; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$AF9..$D59
DATA8_CABD59:						; raw frame tiles for transfer index $297; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$D59..$FB9
DATA8_CABFB9:						; raw frame tiles for transfer index $298; pose not traced
	incbin "../Extracted/segments/bankCA_B000.bin":$FB9..$1000
	incbin "../Extracted/segments/bankCA_C000.bin":$0..$219
