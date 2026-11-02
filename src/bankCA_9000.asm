; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA90B9
DATA8_CA90B9:						; raw frame tiles for transfer index $27D; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$B9..$319
DATA8_CA9319:						; raw frame tiles for transfer index $27E; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$319..$519
DATA8_CA9519:						; raw frame tiles for transfer index $27F; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$519..$779
DATA8_CA9779:						; raw frame tiles for transfer index $280; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$779..$9D9
DATA8_CA99D9:						; raw frame tiles for transfer index $281; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$9D9..$BD9
DATA8_CA9BD9:						; raw frame tiles for transfer index $282; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$BD9..$DD9
DATA8_CA9DD9:						; raw frame tiles for transfer index $283; pose not traced
	incbin "../Extracted/segments/bankCA_9000.bin":$DD9..$1000
	incbin "../Extracted/segments/bankCA_A000.bin":$0..$39
