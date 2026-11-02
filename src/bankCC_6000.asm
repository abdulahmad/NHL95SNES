; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC61A5
DATA8_CC61A5:						; raw frame tiles for transfer index $3A4; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$1A5..$425
DATA8_CC6425:						; raw frame tiles for transfer index $3A5; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$425..$6A5
DATA8_CC66A5:						; raw frame tiles for transfer index $3A6; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$6A5..$8A5
DATA8_CC68A5:						; raw frame tiles for transfer index $3A7; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$8A5..$B05
DATA8_CC6B05:						; raw frame tiles for transfer index $3A8; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$B05..$D05
DATA8_CC6D05:						; raw frame tiles for transfer index $3A9; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$D05..$F05
DATA8_CC6F05:						; raw frame tiles for transfer index $3AA; pose not traced
	incbin "../Extracted/segments/bankCC_6000.bin":$F05..$1000
	incbin "../Extracted/segments/bankCC_7000.bin":$0..$105
