; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C66188
DATA8_C66188:						; raw frame tiles for transfer index $02A; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$188..$3E8
DATA8_C663E8:						; raw frame tiles for transfer index $02B; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$3E8..$5E8
DATA8_C665E8:						; raw frame tiles for transfer index $02E; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$5E8..$848
DATA8_C66848:						; raw frame tiles for transfer index $02F; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$848..$AA8
DATA8_C66AA8:						; raw frame tiles for transfer index $030; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$AA8..$CA8
DATA8_C66CA8:						; raw frame tiles for transfer index $032; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$CA8..$F08
DATA8_C66F08:						; raw frame tiles for transfer index $033; pose not traced
	incbin "../Extracted/segments/bankC6_6000.bin":$F08..$1000
	incbin "../Extracted/segments/bankC6_7000.bin":$0..$168
