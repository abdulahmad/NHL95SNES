; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9D20B
DATA8_C9D20B:						; raw frame tiles for transfer index $22E; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$20B..$48B
DATA8_C9D48B:						; raw frame tiles for transfer index $22F; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$48B..$6AB
DATA8_C9D6AB:						; raw frame tiles for transfer index $230; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$6AB..$92B
DATA8_C9D92B:						; raw frame tiles for transfer index $231; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$92B..$B8B
DATA8_C9DB8B:						; raw frame tiles for transfer index $232; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$B8B..$DEB
DATA8_C9DDEB:						; raw frame tiles for transfer index $233; pose not traced
	incbin "../Extracted/segments/bankC9_D000.bin":$DEB..$1000
	incbin "../Extracted/segments/bankC9_E000.bin":$0..$4B
