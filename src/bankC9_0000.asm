; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9076B
DATA8_C9076B:						; raw frame tiles for transfer index $1D5; pose not traced
	incbin "../Extracted/segments/bankC9_0000.bin":$76B..$96B
DATA8_C9096B:						; raw frame tiles for transfer index $1D6; pose not traced
	incbin "../Extracted/segments/bankC9_0000.bin":$96B..$BCB
DATA8_C90BCB:						; raw frame tiles for transfer index $1D7; pose not traced
	incbin "../Extracted/segments/bankC9_0000.bin":$BCB..$E4B
DATA8_C90E4B:						; raw frame tiles for transfer index $1D8; pose not traced
	incbin "../Extracted/segments/bankC9_0000.bin":$E4B..$1000
	incbin "../Extracted/segments/bankC9_1000.bin":$0..$CB
