; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC90A5
DATA8_CC90A5:						; raw frame tiles for transfer index $3B9; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$A5..$325
DATA8_CC9325:						; raw frame tiles for transfer index $3BA; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$325..$525
DATA8_CC9525:						; raw frame tiles for transfer index $3BB; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$525..$725
DATA8_CC9725:						; raw frame tiles for transfer index $3BC; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$725..$925
DATA8_CC9925:						; raw frame tiles for transfer index $3BD; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$925..$B25
DATA8_CC9B25:						; raw frame tiles for transfer index $3BE; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$B25..$D25
DATA8_CC9D25:						; raw frame tiles for transfer index $3BF; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$D25..$F25
DATA8_CC9F25:						; raw frame tiles for transfer index $3C0; pose not traced
	incbin "../Extracted/segments/bankCC_9000.bin":$F25..$1000
	incbin "../Extracted/segments/bankCC_A000.bin":$0..$125
