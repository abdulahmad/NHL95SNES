; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C8A0F9
DATA8_C8A0F9:						; raw frame tiles for transfer index $172; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$F9..$359
DATA8_C8A359:						; raw frame tiles for transfer index $174; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$359..$5D9
DATA8_C8A5D9:						; raw frame tiles for transfer index $175; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$5D9..$859
DATA8_C8A859:						; raw frame tiles for transfer index $178; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$859..$AB9
DATA8_C8AAB9:						; raw frame tiles for transfer index $179; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$AB9..$D19
DATA8_C8AD19:						; raw frame tiles for transfer index $17A; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$D19..$F19
DATA8_C8AF19:						; raw frame tiles for transfer index $17C; pose not traced
	incbin "../Extracted/segments/bankC8_A000.bin":$F19..$1000
	incbin "../Extracted/segments/bankC8_B000.bin":$0..$199
