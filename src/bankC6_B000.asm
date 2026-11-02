; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C6B108
DATA8_C6B108:						; raw frame tiles for transfer index $056; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$108..$348
DATA8_C6B348:						; raw frame tiles for transfer index $057; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$348..$5A8
DATA8_C6B5A8:						; raw frame tiles for transfer index $058; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$5A8..$808
DATA8_C6B808:						; raw frame tiles for transfer index $06F; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$808..$A08
DATA8_C6BA08:						; raw frame tiles for transfer index $072; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$A08..$C48
DATA8_C6BC48:						; raw frame tiles for transfer index $07B; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$C48..$EA8
DATA8_C6BEA8:						; raw frame tiles for transfer index $07C; pose not traced
	incbin "../Extracted/segments/bankC6_B000.bin":$EA8..$1000
	incbin "../Extracted/segments/bankC6_C000.bin":$0..$A8
