; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C67168
DATA8_C67168:						; raw frame tiles for transfer index $036; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$168..$368
DATA8_C67368:						; raw frame tiles for transfer index $037; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$368..$5C8
DATA8_C675C8:						; raw frame tiles for transfer index $038; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$5C8..$828
DATA8_C67828:						; raw frame tiles for transfer index $03A; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$828..$AA8
DATA8_C67AA8:						; raw frame tiles for transfer index $03B; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$AA8..$D08
DATA8_C67D08:						; raw frame tiles for transfer index $03E; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$D08..$F88
DATA8_C67F88:						; raw frame tiles for transfer index $03F; pose not traced
	incbin "../Extracted/segments/bankC6_7000.bin":$F88..$1000
	incbin "../Extracted/segments/bankC6_8000.bin":$0..$1E8
