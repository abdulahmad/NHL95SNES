; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA2159
DATA8_CA2159:						; raw frame tiles for transfer index $24B; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$159..$3D9
DATA8_CA23D9:						; raw frame tiles for transfer index $24C; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$3D9..$639
DATA8_CA2639:						; raw frame tiles for transfer index $24D; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$639..$839
DATA8_CA2839:						; raw frame tiles for transfer index $24E; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$839..$AB9
DATA8_CA2AB9:						; raw frame tiles for transfer index $24F; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$AB9..$D19
DATA8_CA2D19:						; raw frame tiles for transfer index $250; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$D19..$F99
DATA8_CA2F99:						; raw frame tiles for transfer index $251; pose not traced
	incbin "../Extracted/segments/bankCA_2000.bin":$F99..$1000
	incbin "../Extracted/segments/bankCA_3000.bin":$0..$219
