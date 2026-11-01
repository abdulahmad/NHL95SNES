; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CCD265
DATA8_CCD265:						; raw frame tiles for transfer index $3F8; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$265..$465
DATA8_CCD465:						; raw frame tiles for transfer index $3F9; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$465..$6C5
DATA8_CCD6C5:						; raw frame tiles for transfer index $3FA; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$6C5..$8C5
DATA8_CCD8C5:						; raw frame tiles for transfer index $3FB; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$8C5..$B25
DATA8_CCDB25:						; raw frame tiles for transfer index $41B; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$B25..$D85
DATA8_CCDD85:						; raw frame tiles for transfer index $41C; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$D85..$FE5
DATA8_CCDFE5:						; raw frame tiles for transfer index $41D; pose not traced
	incbin "../Extracted/segments/bankCC_D000.bin":$FE5..$1000
	incbin "../Extracted/segments/bankCC_E000.bin":$0..$1E5
