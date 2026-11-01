; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C840F9
DATA8_C840F9:						; raw frame tiles for transfer index $126; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$F9..$319
DATA8_C84319:						; raw frame tiles for transfer index $12B; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$319..$579
DATA8_C84579:						; raw frame tiles for transfer index $12C; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$579..$7D9
DATA8_C847D9:						; raw frame tiles for transfer index $12D; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$7D9..$A39
DATA8_C84A39:						; raw frame tiles for transfer index $12E; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$A39..$C99
DATA8_C84C99:						; raw frame tiles for transfer index $133; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$C99..$EF9
DATA8_C84EF9:						; raw frame tiles for transfer index $134; pose not traced
	incbin "../Extracted/segments/bankC8_4000.bin":$EF9..$1000
	incbin "../Extracted/segments/bankC8_5000.bin":$0..$179
