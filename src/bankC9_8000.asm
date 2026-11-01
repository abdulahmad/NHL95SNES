; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9800B
DATA8_C9800B:						; raw frame tiles for transfer index $20C; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$B..$26B
DATA8_C9826B:						; raw frame tiles for transfer index $20D; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$26B..$4CB
DATA8_C984CB:						; raw frame tiles for transfer index $20E; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$4CB..$72B
DATA8_C9872B:						; raw frame tiles for transfer index $20F; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$72B..$98B
DATA8_C9898B:						; raw frame tiles for transfer index $210; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$98B..$BEB
DATA8_C98BEB:						; raw frame tiles for transfer index $211; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$BEB..$E4B
DATA8_C98E4B:						; raw frame tiles for transfer index $212; pose not traced
	incbin "../Extracted/segments/bankC9_8000.bin":$E4B..$1000
	incbin "../Extracted/segments/bankC9_9000.bin":$0..$AB
