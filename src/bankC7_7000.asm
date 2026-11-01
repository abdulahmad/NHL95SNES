; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C770FE
DATA8_C770FE:						; raw frame tiles for transfer index $0C6; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$FE..$37E
DATA8_C7737E:						; raw frame tiles for transfer index $0C7; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$37E..$5FE
DATA8_C775FE:						; raw frame tiles for transfer index $0C8; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$5FE..$87E
DATA8_C7787E:						; raw frame tiles for transfer index $0C9; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$87E..$AFE
DATA8_C77AFE:						; raw frame tiles for transfer index $0CA; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$AFE..$D1E
DATA8_C77D1E:						; raw frame tiles for transfer index $0CB; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$D1E..$F1E
DATA8_C77F1E:						; raw frame tiles for transfer index $0CC; pose not traced
	incbin "../Extracted/segments/bankC7_7000.bin":$F1E..$1000
	incbin "../Extracted/segments/bankC7_8000.bin":$0..$11E
