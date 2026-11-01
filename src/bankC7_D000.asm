; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7D1DE
DATA8_C7D1DE:						; raw frame tiles for transfer index $0EE; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$1DE..$45E
DATA8_C7D45E:						; raw frame tiles for transfer index $0EF; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$45E..$6BE
DATA8_C7D6BE:						; raw frame tiles for transfer index $0F0; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$6BE..$93E
DATA8_C7D93E:						; raw frame tiles for transfer index $0F1; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$93E..$BBE
DATA8_C7DBBE:						; raw frame tiles for transfer index $0F2; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$BBE..$E3E
DATA8_C7DE3E:						; raw frame tiles for transfer index $0F3; pose not traced
	incbin "../Extracted/segments/bankC7_D000.bin":$E3E..$1000
	incbin "../Extracted/segments/bankC7_E000.bin":$0..$BE
