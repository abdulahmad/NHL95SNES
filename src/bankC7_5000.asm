; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7513E
DATA8_C7513E:						; raw frame tiles for transfer index $0B9; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$13E..$39E
DATA8_C7539E:						; raw frame tiles for transfer index $0BA; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$39E..$61E
DATA8_C7561E:						; raw frame tiles for transfer index $0BB; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$61E..$87E
DATA8_C7587E:						; raw frame tiles for transfer index $0BC; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$87E..$AFE
DATA8_C75AFE:						; raw frame tiles for transfer index $0BD; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$AFE..$D7E
DATA8_C75D7E:						; raw frame tiles for transfer index $0BE; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$D7E..$F9E
DATA8_C75F9E:						; raw frame tiles for transfer index $0BF; pose not traced
	incbin "../Extracted/segments/bankC7_5000.bin":$F9E..$1000
	incbin "../Extracted/segments/bankC7_6000.bin":$0..$21E
