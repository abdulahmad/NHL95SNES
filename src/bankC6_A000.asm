; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C6A1A8
DATA8_C6A1A8:						; raw frame tiles for transfer index $04F; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$1A8..$408
DATA8_C6A408:						; raw frame tiles for transfer index $050; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$408..$688
DATA8_C6A688:						; raw frame tiles for transfer index $051; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$688..$888
DATA8_C6A888:						; raw frame tiles for transfer index $052; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$888..$A88
DATA8_C6AA88:						; raw frame tiles for transfer index $053; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$A88..$CA8
DATA8_C6ACA8:						; raw frame tiles for transfer index $054; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$CA8..$EC8
DATA8_C6AEC8:						; raw frame tiles for transfer index $055; pose not traced
	incbin "../Extracted/segments/bankC6_A000.bin":$EC8..$1000
	incbin "../Extracted/segments/bankC6_B000.bin":$0..$108
