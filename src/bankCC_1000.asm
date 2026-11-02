; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC11A5
DATA8_CC11A5:						; raw frame tiles for transfer index $380; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$1A5..$405
DATA8_CC1405:						; raw frame tiles for transfer index $381; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$405..$685
DATA8_CC1685:						; raw frame tiles for transfer index $382; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$685..$8E5
DATA8_CC18E5:						; raw frame tiles for transfer index $383; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$8E5..$B45
DATA8_CC1B45:						; raw frame tiles for transfer index $384; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$B45..$D45
DATA8_CC1D45:						; raw frame tiles for transfer index $385; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$D45..$FA5
DATA8_CC1FA5:						; raw frame tiles for transfer index $386; pose not traced
	incbin "../Extracted/segments/bankCC_1000.bin":$FA5..$1000
	incbin "../Extracted/segments/bankCC_2000.bin":$0..$225
