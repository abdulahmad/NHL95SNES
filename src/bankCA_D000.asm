; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAD0D9
DATA8_CAD0D9:						; raw frame tiles for transfer index $2A2; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$D9..$339
DATA8_CAD339:						; raw frame tiles for transfer index $2A3; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$339..$539
DATA8_CAD539:						; raw frame tiles for transfer index $2A4; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$539..$739
DATA8_CAD739:						; raw frame tiles for transfer index $2BD; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$739..$7B9
DATA8_CAD7B9:						; raw frame tiles for transfer index $2BE; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$7B9..$839
DATA8_CAD839:						; raw frame tiles for transfer index $2BF; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$839..$8B9
DATA8_CAD8B9:						; raw frame tiles for transfer index $2C0; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$8B9..$A39
DATA8_CADA39:						; raw frame tiles for transfer index $2C1; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$A39..$AB9
DATA8_CADAB9:						; raw frame tiles for transfer index $2C2; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$AB9..$B39
DATA8_CADB39:						; raw frame tiles for transfer index $2C3; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$B39..$BB9
DATA8_CADBB9:						; raw frame tiles for transfer index $2C4; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$BB9..$CB9
DATA8_CADCB9:						; raw frame tiles for transfer index $2C5; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$CB9..$E39
DATA8_CADE39:						; raw frame tiles for transfer index $2C6; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$E39..$FB9
DATA8_CADFB9:						; raw frame tiles for transfer index $2C7; pose not traced
	incbin "../Extracted/segments/bankCA_D000.bin":$FB9..$1000
	incbin "../Extracted/segments/bankCA_E000.bin":$0..$139
