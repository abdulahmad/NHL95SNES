; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C650C8
DATA8_C650C8:						; raw frame tiles for transfer index $01E; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$C8..$328
DATA8_C65328:						; raw frame tiles for transfer index $01F; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$328..$528
DATA8_C65528:						; raw frame tiles for transfer index $020; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$528..$728
DATA8_C65728:						; raw frame tiles for transfer index $022; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$728..$988
DATA8_C65988:						; raw frame tiles for transfer index $023; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$988..$B88
DATA8_C65B88:						; raw frame tiles for transfer index $026; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$B88..$D88
DATA8_C65D88:						; raw frame tiles for transfer index $027; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$D88..$F88
DATA8_C65F88:						; raw frame tiles for transfer index $028; pose not traced
	incbin "../Extracted/segments/bankC6_5000.bin":$F88..$1000
	incbin "../Extracted/segments/bankC6_6000.bin":$0..$188
