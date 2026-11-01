; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C861B9
DATA8_C861B9:						; raw frame tiles for transfer index $144; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$1B9..$439
DATA8_C86439:						; raw frame tiles for transfer index $145; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$439..$6B9
DATA8_C866B9:						; raw frame tiles for transfer index $146; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$6B9..$8F9
DATA8_C868F9:						; raw frame tiles for transfer index $14C; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$8F9..$B59
DATA8_C86B59:						; raw frame tiles for transfer index $14D; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$B59..$DB9
DATA8_C86DB9:						; raw frame tiles for transfer index $150; pose not traced
	incbin "../Extracted/segments/bankC8_6000.bin":$DB9..$1000
	incbin "../Extracted/segments/bankC8_7000.bin":$0..$19
