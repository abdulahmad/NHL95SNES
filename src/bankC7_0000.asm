; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7053E
DATA8_C7053E:						; raw frame tiles for transfer index $098; pose not traced
	incbin "../Extracted/segments/bankC7_0000.bin":$53E..$7BE
DATA8_C707BE:						; raw frame tiles for transfer index $099; pose not traced
	incbin "../Extracted/segments/bankC7_0000.bin":$7BE..$A3E
DATA8_C70A3E:						; raw frame tiles for transfer index $09A; pose not traced
	incbin "../Extracted/segments/bankC7_0000.bin":$A3E..$CBE
DATA8_C70CBE:						; raw frame tiles for transfer index $09B; pose not traced
	incbin "../Extracted/segments/bankC7_0000.bin":$CBE..$EBE
DATA8_C70EBE:						; raw frame tiles for transfer index $09C; pose not traced
	incbin "../Extracted/segments/bankC7_0000.bin":$EBE..$1000
	incbin "../Extracted/segments/bankC7_1000.bin":$0..$BE
