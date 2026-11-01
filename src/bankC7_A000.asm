; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7A07E
DATA8_C7A07E:						; raw frame tiles for transfer index $0DA; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$7E..$2FE
DATA8_C7A2FE:						; raw frame tiles for transfer index $0DB; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$2FE..$57E
DATA8_C7A57E:						; raw frame tiles for transfer index $0DC; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$57E..$7FE
DATA8_C7A7FE:						; raw frame tiles for transfer index $0DD; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$7FE..$A7E
DATA8_C7AA7E:						; raw frame tiles for transfer index $0DE; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$A7E..$CFE
DATA8_C7ACFE:						; raw frame tiles for transfer index $0DF; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$CFE..$F7E
DATA8_C7AF7E:						; raw frame tiles for transfer index $0E0; pose not traced
	incbin "../Extracted/segments/bankC7_A000.bin":$F7E..$1000
	incbin "../Extracted/segments/bankC7_B000.bin":$0..$1FE
