; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAC219
DATA8_CAC219:						; raw frame tiles for transfer index $29A; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$219..$479
DATA8_CAC479:						; raw frame tiles for transfer index $29B; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$479..$679
DATA8_CAC679:						; raw frame tiles for transfer index $29D; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$679..$8D9
DATA8_CAC8D9:						; raw frame tiles for transfer index $29E; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$8D9..$AD9
DATA8_CACAD9:						; raw frame tiles for transfer index $29F; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$AD9..$CD9
DATA8_CACCD9:						; raw frame tiles for transfer index $2A0; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$CD9..$ED9
DATA8_CACED9:						; raw frame tiles for transfer index $2A1; pose not traced
	incbin "../Extracted/segments/bankCA_C000.bin":$ED9..$1000
	incbin "../Extracted/segments/bankCA_D000.bin":$0..$D9
