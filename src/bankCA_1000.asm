; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA1099
DATA8_CA1099:						; raw frame tiles for transfer index $244; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$99..$2F9
DATA8_CA12F9:						; raw frame tiles for transfer index $245; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$2F9..$579
DATA8_CA1579:						; raw frame tiles for transfer index $246; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$579..$7F9
DATA8_CA17F9:						; raw frame tiles for transfer index $247; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$7F9..$A79
DATA8_CA1A79:						; raw frame tiles for transfer index $248; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$A79..$C79
DATA8_CA1C79:						; raw frame tiles for transfer index $249; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$C79..$EF9
DATA8_CA1EF9:						; raw frame tiles for transfer index $24A; pose not traced
	incbin "../Extracted/segments/bankCA_1000.bin":$EF9..$1000
	incbin "../Extracted/segments/bankCA_2000.bin":$0..$159
