; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7423E
DATA8_C7423E:						; raw frame tiles for transfer index $0B3; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$23E..$4BE
DATA8_C744BE:						; raw frame tiles for transfer index $0B4; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$4BE..$73E
DATA8_C7473E:						; raw frame tiles for transfer index $0B5; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$73E..$9BE
DATA8_C749BE:						; raw frame tiles for transfer index $0B6; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$9BE..$C3E
DATA8_C74C3E:						; raw frame tiles for transfer index $0B7; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$C3E..$EBE
DATA8_C74EBE:						; raw frame tiles for transfer index $0B8; pose not traced
	incbin "../Extracted/segments/bankC7_4000.bin":$EBE..$1000
	incbin "../Extracted/segments/bankC7_5000.bin":$0..$13E
