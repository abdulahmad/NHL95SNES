; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C710BE
DATA8_C710BE:						; raw frame tiles for transfer index $09D; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$BE..$2BE
DATA8_C712BE:						; raw frame tiles for transfer index $09E; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$2BE..$4BE
DATA8_C714BE:						; raw frame tiles for transfer index $09F; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$4BE..$6BE
DATA8_C716BE:						; raw frame tiles for transfer index $0A0; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$6BE..$8BE
DATA8_C718BE:						; raw frame tiles for transfer index $0A1; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$8BE..$ABE
DATA8_C71ABE:						; raw frame tiles for transfer index $0A2; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$ABE..$D1E
DATA8_C71D1E:						; raw frame tiles for transfer index $0A3; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$D1E..$F1E
DATA8_C71F1E:						; raw frame tiles for transfer index $0A4; pose not traced
	incbin "../Extracted/segments/bankC7_1000.bin":$F1E..$1000
	incbin "../Extracted/segments/bankC7_2000.bin":$0..$19E
