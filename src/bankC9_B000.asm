; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9B10B
DATA8_C9B10B:						; raw frame tiles for transfer index $220; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$10B..$38B
DATA8_C9B38B:						; raw frame tiles for transfer index $221; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$38B..$5EB
DATA8_C9B5EB:						; raw frame tiles for transfer index $222; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$5EB..$84B
DATA8_C9B84B:						; raw frame tiles for transfer index $223; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$84B..$AAB
DATA8_C9BAAB:						; raw frame tiles for transfer index $224; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$AAB..$D2B
DATA8_C9BD2B:						; raw frame tiles for transfer index $225; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$D2B..$F8B
DATA8_C9BF8B:						; raw frame tiles for transfer index $226; pose not traced
	incbin "../Extracted/segments/bankC9_B000.bin":$F8B..$1000
	incbin "../Extracted/segments/bankC9_C000.bin":$0..$18B
