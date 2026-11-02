; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C64128
DATA8_C64128:						; raw frame tiles for transfer index $012; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$128..$388
DATA8_C64388:						; raw frame tiles for transfer index $013; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$388..$588
DATA8_C64588:						; raw frame tiles for transfer index $016; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$588..$808
DATA8_C64808:						; raw frame tiles for transfer index $017; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$808..$A68
DATA8_C64A68:						; raw frame tiles for transfer index $018; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$A68..$C68
DATA8_C64C68:						; raw frame tiles for transfer index $01A; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$C68..$EC8
DATA8_C64EC8:						; raw frame tiles for transfer index $01B; pose not traced
	incbin "../Extracted/segments/bankC6_4000.bin":$EC8..$1000
	incbin "../Extracted/segments/bankC6_5000.bin":$0..$C8
