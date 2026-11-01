; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9718B
DATA8_C9718B:						; raw frame tiles for transfer index $206; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$18B..$40B
DATA8_C9740B:						; raw frame tiles for transfer index $207; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$40B..$68B
DATA8_C9768B:						; raw frame tiles for transfer index $208; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$68B..$8EB
DATA8_C978EB:						; raw frame tiles for transfer index $209; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$8EB..$B4B
DATA8_C97B4B:						; raw frame tiles for transfer index $20A; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$B4B..$DAB
DATA8_C97DAB:						; raw frame tiles for transfer index $20B; pose not traced
	incbin "../Extracted/segments/bankC9_7000.bin":$DAB..$1000
	incbin "../Extracted/segments/bankC9_8000.bin":$0..$B
