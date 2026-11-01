; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC7105
DATA8_CC7105:						; raw frame tiles for transfer index $3AB; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$105..$305
DATA8_CC7305:						; raw frame tiles for transfer index $3AC; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$305..$505
DATA8_CC7505:						; raw frame tiles for transfer index $3AD; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$505..$705
DATA8_CC7705:						; raw frame tiles for transfer index $3AE; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$705..$965
DATA8_CC7965:						; raw frame tiles for transfer index $3AF; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$965..$BC5
DATA8_CC7BC5:						; raw frame tiles for transfer index $3B0; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$BC5..$E25
DATA8_CC7E25:						; raw frame tiles for transfer index $3B1; pose not traced
	incbin "../Extracted/segments/bankCC_7000.bin":$E25..$1000
	incbin "../Extracted/segments/bankCC_8000.bin":$0..$25
