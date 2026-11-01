; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7315E
DATA8_C7315E:						; raw frame tiles for transfer index $0AC; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$15E..$3DE
DATA8_C733DE:						; raw frame tiles for transfer index $0AD; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$3DE..$65E
DATA8_C7365E:						; raw frame tiles for transfer index $0AE; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$65E..$8BE
DATA8_C738BE:						; raw frame tiles for transfer index $0AF; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$8BE..$B3E
DATA8_C73B3E:						; raw frame tiles for transfer index $0B0; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$B3E..$D7E
DATA8_C73D7E:						; raw frame tiles for transfer index $0B1; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$D7E..$FDE
DATA8_C73FDE:						; raw frame tiles for transfer index $0B2; pose not traced
	incbin "../Extracted/segments/bankC7_3000.bin":$FDE..$1000
	incbin "../Extracted/segments/bankC7_4000.bin":$0..$23E
