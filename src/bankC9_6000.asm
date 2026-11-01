; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9620B
DATA8_C9620B:						; raw frame tiles for transfer index $1FD; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$20B..$38B
DATA8_C9638B:						; raw frame tiles for transfer index $1FE; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$38B..$50B
DATA8_C9650B:						; raw frame tiles for transfer index $1FF; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$50B..$68B
DATA8_C9668B:						; raw frame tiles for transfer index $200; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$68B..$80B
DATA8_C9680B:						; raw frame tiles for transfer index $201; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$80B..$98B
DATA8_C9698B:						; raw frame tiles for transfer index $202; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$98B..$B8B
DATA8_C96B8B:						; raw frame tiles for transfer index $203; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$B8B..$D8B
DATA8_C96D8B:						; raw frame tiles for transfer index $204; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$D8B..$F8B
DATA8_C96F8B:						; raw frame tiles for transfer index $205; pose not traced
	incbin "../Extracted/segments/bankC9_6000.bin":$F8B..$1000
	incbin "../Extracted/segments/bankC9_7000.bin":$0..$18B
