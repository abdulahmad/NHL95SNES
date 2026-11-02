; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA5139
DATA8_CA5139:						; raw frame tiles for transfer index $25F; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$139..$339
DATA8_CA5339:						; raw frame tiles for transfer index $260; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$339..$539
DATA8_CA5539:						; raw frame tiles for transfer index $261; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$539..$739
DATA8_CA5739:						; raw frame tiles for transfer index $262; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$739..$939
DATA8_CA5939:						; raw frame tiles for transfer index $263; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$939..$B39
DATA8_CA5B39:						; raw frame tiles for transfer index $264; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$B39..$D39
DATA8_CA5D39:						; raw frame tiles for transfer index $265; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$D39..$F39
DATA8_CA5F39:						; raw frame tiles for transfer index $266; pose not traced
	incbin "../Extracted/segments/bankCA_5000.bin":$F39..$1000
	incbin "../Extracted/segments/bankCA_6000.bin":$0..$139
