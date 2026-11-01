; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9216B
DATA8_C9216B:						; raw frame tiles for transfer index $1E0; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$16B..$3CB
DATA8_C923CB:						; raw frame tiles for transfer index $1E1; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$3CB..$62B
DATA8_C9262B:						; raw frame tiles for transfer index $1E2; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$62B..$8AB
DATA8_C928AB:						; raw frame tiles for transfer index $1E3; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$8AB..$B2B
DATA8_C92B2B:						; raw frame tiles for transfer index $1E4; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$B2B..$DAB
DATA8_C92DAB:						; raw frame tiles for transfer index $1E5; pose not traced
	incbin "../Extracted/segments/bankC9_2000.bin":$DAB..$1000
	incbin "../Extracted/segments/bankC9_3000.bin":$0..$2B
