; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C69088
DATA8_C69088:						; raw frame tiles for transfer index $047; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$88..$288
DATA8_C69288:						; raw frame tiles for transfer index $048; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$288..$488
DATA8_C69488:						; raw frame tiles for transfer index $049; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$488..$688
DATA8_C69688:						; raw frame tiles for transfer index $04A; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$688..$888
DATA8_C69888:						; raw frame tiles for transfer index $04B; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$888..$A88
DATA8_C69A88:						; raw frame tiles for transfer index $04C; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$A88..$CE8
DATA8_C69CE8:						; raw frame tiles for transfer index $04D; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$CE8..$F48
DATA8_C69F48:						; raw frame tiles for transfer index $04E; pose not traced
	incbin "../Extracted/segments/bankC6_9000.bin":$F48..$1000
	incbin "../Extracted/segments/bankC6_A000.bin":$0..$1A8
