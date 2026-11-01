; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA7199
DATA8_CA7199:						; raw frame tiles for transfer index $26F; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$199..$419
DATA8_CA7419:						; raw frame tiles for transfer index $270; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$419..$679
DATA8_CA7679:						; raw frame tiles for transfer index $271; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$679..$8D9
DATA8_CA78D9:						; raw frame tiles for transfer index $272; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$8D9..$B39
DATA8_CA7B39:						; raw frame tiles for transfer index $273; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$B39..$D99
DATA8_CA7D99:						; raw frame tiles for transfer index $274; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$D99..$F99
DATA8_CA7F99:						; raw frame tiles for transfer index $275; pose not traced
	incbin "../Extracted/segments/bankCA_7000.bin":$F99..$1000
	incbin "../Extracted/segments/bankCA_8000.bin":$0..$1F9
