; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C910CB
DATA8_C910CB:						; raw frame tiles for transfer index $1D9; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$CB..$34B
DATA8_C9134B:						; raw frame tiles for transfer index $1DA; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$34B..$5AB
DATA8_C915AB:						; raw frame tiles for transfer index $1DB; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$5AB..$7AB
DATA8_C917AB:						; raw frame tiles for transfer index $1DC; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$7AB..$A0B
DATA8_C91A0B:						; raw frame tiles for transfer index $1DD; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$A0B..$C6B
DATA8_C91C6B:						; raw frame tiles for transfer index $1DE; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$C6B..$EEB
DATA8_C91EEB:						; raw frame tiles for transfer index $1DF; pose not traced
	incbin "../Extracted/segments/bankC9_1000.bin":$EEB..$1000
	incbin "../Extracted/segments/bankC9_2000.bin":$0..$16B
