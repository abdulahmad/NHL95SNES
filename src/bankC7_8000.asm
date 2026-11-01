; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7811E
DATA8_C7811E:						; raw frame tiles for transfer index $0CD; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$11E..$31E
DATA8_C7831E:						; raw frame tiles for transfer index $0CE; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$31E..$59E
DATA8_C7859E:						; raw frame tiles for transfer index $0CF; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$59E..$81E
DATA8_C7881E:						; raw frame tiles for transfer index $0D0; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$81E..$A7E
DATA8_C78A7E:						; raw frame tiles for transfer index $0D1; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$A7E..$CFE
DATA8_C78CFE:						; raw frame tiles for transfer index $0D2; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$CFE..$F7E
DATA8_C78F7E:						; raw frame tiles for transfer index $0D3; pose not traced
	incbin "../Extracted/segments/bankC7_8000.bin":$F7E..$1000
	incbin "../Extracted/segments/bankC7_9000.bin":$0..$1FE
