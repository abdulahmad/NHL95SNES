; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7C0FE
DATA8_C7C0FE:						; raw frame tiles for transfer index $0E7; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$FE..$31E
DATA8_C7C31E:						; raw frame tiles for transfer index $0E8; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$31E..$59E
DATA8_C7C59E:						; raw frame tiles for transfer index $0E9; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$59E..$7FE
DATA8_C7C7FE:						; raw frame tiles for transfer index $0EA; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$7FE..$A5E
DATA8_C7CA5E:						; raw frame tiles for transfer index $0EB; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$A5E..$CDE
DATA8_C7CCDE:						; raw frame tiles for transfer index $0EC; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$CDE..$F5E
DATA8_C7CF5E:						; raw frame tiles for transfer index $0ED; pose not traced
	incbin "../Extracted/segments/bankC7_C000.bin":$F5E..$1000
	incbin "../Extracted/segments/bankC7_D000.bin":$0..$1DE
