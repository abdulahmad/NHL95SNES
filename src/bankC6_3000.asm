; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C630A8
DATA8_C630A8:						; raw frame tiles for transfer index $007; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$A8..$308
DATA8_C63308:						; raw frame tiles for transfer index $008; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$308..$508
DATA8_C63508:						; raw frame tiles for transfer index $00A; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$508..$788
DATA8_C63788:						; raw frame tiles for transfer index $00B; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$788..$9E8
DATA8_C639E8:						; raw frame tiles for transfer index $00E; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$9E8..$C68
DATA8_C63C68:						; raw frame tiles for transfer index $00F; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$C68..$EC8
DATA8_C63EC8:						; raw frame tiles for transfer index $010; pose not traced
	incbin "../Extracted/segments/bankC6_3000.bin":$EC8..$1000
	incbin "../Extracted/segments/bankC6_4000.bin":$0..$128
