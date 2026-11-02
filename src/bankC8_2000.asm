; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C82239
DATA8_C82239:						; raw frame tiles for transfer index $10D; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$239..$499
DATA8_C82499:						; raw frame tiles for transfer index $10E; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$499..$699
DATA8_C82699:						; raw frame tiles for transfer index $113; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$699..$919
DATA8_C82919:						; raw frame tiles for transfer index $114; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$919..$B99
DATA8_C82B99:						; raw frame tiles for transfer index $115; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$B99..$E19
DATA8_C82E19:						; raw frame tiles for transfer index $116; pose not traced
	incbin "../Extracted/segments/bankC8_2000.bin":$E19..$1000
	incbin "../Extracted/segments/bankC8_3000.bin":$0..$19
