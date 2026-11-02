; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C990AB
DATA8_C990AB:						; raw frame tiles for transfer index $213; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$AB..$30B
DATA8_C9930B:						; raw frame tiles for transfer index $214; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$30B..$58B
DATA8_C9958B:						; raw frame tiles for transfer index $215; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$58B..$80B
DATA8_C9980B:						; raw frame tiles for transfer index $216; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$80B..$A8B
DATA8_C99A8B:						; raw frame tiles for transfer index $217; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$A8B..$D0B
DATA8_C99D0B:						; raw frame tiles for transfer index $218; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$D0B..$F8B
DATA8_C99F8B:						; raw frame tiles for transfer index $219; pose not traced
	incbin "../Extracted/segments/bankC9_9000.bin":$F8B..$1000
	incbin "../Extracted/segments/bankC9_A000.bin":$0..$20B
