; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC4205
DATA8_CC4205:						; raw frame tiles for transfer index $396; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$205..$465
DATA8_CC4465:						; raw frame tiles for transfer index $397; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$465..$6C5
DATA8_CC46C5:						; raw frame tiles for transfer index $398; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$6C5..$8C5
DATA8_CC48C5:						; raw frame tiles for transfer index $399; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$8C5..$B45
DATA8_CC4B45:						; raw frame tiles for transfer index $39A; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$B45..$DA5
DATA8_CC4DA5:						; raw frame tiles for transfer index $39B; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$DA5..$FA5
DATA8_CC4FA5:						; raw frame tiles for transfer index $39C; pose not traced
	incbin "../Extracted/segments/bankCC_4000.bin":$FA5..$1000
	incbin "../Extracted/segments/bankCC_5000.bin":$0..$1E5
