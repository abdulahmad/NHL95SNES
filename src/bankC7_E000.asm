; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7E0BE
DATA8_C7E0BE:						; raw frame tiles for transfer index $0F4; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$BE..$33E
DATA8_C7E33E:						; raw frame tiles for transfer index $0F5; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$33E..$5BE
DATA8_C7E5BE:						; raw frame tiles for transfer index $0F6; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$5BE..$7DE
DATA8_C7E7DE:						; raw frame tiles for transfer index $0F7; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$7DE..$A3E
DATA8_C7EA3E:						; raw frame tiles for transfer index $0F8; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$A3E..$C3E
DATA8_C7EC3E:						; raw frame tiles for transfer index $0F9; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$C3E..$E9E
DATA8_C7EE9E:						; raw frame tiles for transfer index $0FA; pose not traced
	incbin "../Extracted/segments/bankC7_E000.bin":$E9E..$1000
	incbin "../Extracted/segments/bankC7_F000.bin":$0..$9E
