; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CCA125
DATA8_CCA125:						; raw frame tiles for transfer index $3C1; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$125..$325
DATA8_CCA325:						; raw frame tiles for transfer index $3C2; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$325..$525
DATA8_CCA525:						; raw frame tiles for transfer index $3C3; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$525..$725
DATA8_CCA725:						; raw frame tiles for transfer index $3C4; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$725..$925
DATA8_CCA925:						; raw frame tiles for transfer index $3C5; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$925..$B25
DATA8_CCAB25:						; raw frame tiles for transfer index $3C6; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$B25..$D25
DATA8_CCAD25:						; raw frame tiles for transfer index $3C7; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$D25..$F25
DATA8_CCAF25:						; raw frame tiles for transfer index $3C8; pose not traced
	incbin "../Extracted/segments/bankCC_A000.bin":$F25..$1000
	incbin "../Extracted/segments/bankCC_B000.bin":$0..$125
