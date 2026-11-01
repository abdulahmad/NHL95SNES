; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7B1FE
DATA8_C7B1FE:						; raw frame tiles for transfer index $0E1; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$1FE..$47E
DATA8_C7B47E:						; raw frame tiles for transfer index $0E2; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$47E..$6FE
DATA8_C7B6FE:						; raw frame tiles for transfer index $0E3; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$6FE..$97E
DATA8_C7B97E:						; raw frame tiles for transfer index $0E4; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$97E..$BFE
DATA8_C7BBFE:						; raw frame tiles for transfer index $0E5; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$BFE..$E7E
DATA8_C7BE7E:						; raw frame tiles for transfer index $0E6; pose not traced
	incbin "../Extracted/segments/bankC7_B000.bin":$E7E..$1000
	incbin "../Extracted/segments/bankC7_C000.bin":$0..$FE
