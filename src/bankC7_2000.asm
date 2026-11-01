; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7219E
DATA8_C7219E:						; raw frame tiles for transfer index $0A5; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$19E..$39E
DATA8_C7239E:						; raw frame tiles for transfer index $0A6; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$39E..$61E
DATA8_C7261E:						; raw frame tiles for transfer index $0A7; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$61E..$81E
DATA8_C7281E:						; raw frame tiles for transfer index $0A8; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$81E..$A7E
DATA8_C72A7E:						; raw frame tiles for transfer index $0A9; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$A7E..$C7E
DATA8_C72C7E:						; raw frame tiles for transfer index $0AA; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$C7E..$EDE
DATA8_C72EDE:						; raw frame tiles for transfer index $0AB; pose not traced
	incbin "../Extracted/segments/bankC7_2000.bin":$EDE..$1000
	incbin "../Extracted/segments/bankC7_3000.bin":$0..$15E
