; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9E04B
DATA8_C9E04B:						; raw frame tiles for transfer index $234; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$4B..$2CB
DATA8_C9E2CB:						; raw frame tiles for transfer index $235; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$2CB..$52B
DATA8_C9E52B:						; raw frame tiles for transfer index $236; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$52B..$78B
DATA8_C9E78B:						; raw frame tiles for transfer index $237; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$78B..$A0B
DATA8_C9EA0B:						; raw frame tiles for transfer index $238; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$A0B..$C8B
DATA8_C9EC8B:						; raw frame tiles for transfer index $239; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$C8B..$EEB
DATA8_C9EEEB:						; raw frame tiles for transfer index $23A; pose not traced
	incbin "../Extracted/segments/bankC9_E000.bin":$EEB..$1000
	incbin "../Extracted/segments/bankC9_F000.bin":$0..$14B
