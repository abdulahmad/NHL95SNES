; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC8025
DATA8_CC8025:						; raw frame tiles for transfer index $3B2; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$25..$225
DATA8_CC8225:						; raw frame tiles for transfer index $3B3; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$225..$425
DATA8_CC8425:						; raw frame tiles for transfer index $3B4; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$425..$6A5
DATA8_CC86A5:						; raw frame tiles for transfer index $3B5; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$6A5..$925
DATA8_CC8925:						; raw frame tiles for transfer index $3B6; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$925..$BA5
DATA8_CC8BA5:						; raw frame tiles for transfer index $3B7; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$BA5..$E25
DATA8_CC8E25:						; raw frame tiles for transfer index $3B8; pose not traced
	incbin "../Extracted/segments/bankCC_8000.bin":$E25..$1000
	incbin "../Extracted/segments/bankCC_9000.bin":$0..$A5
