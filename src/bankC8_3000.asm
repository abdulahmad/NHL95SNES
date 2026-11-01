; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C83019
DATA8_C83019:						; raw frame tiles for transfer index $11B; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$19..$299
DATA8_C83299:						; raw frame tiles for transfer index $11C; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$299..$519
DATA8_C83519:						; raw frame tiles for transfer index $11D; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$519..$799
DATA8_C83799:						; raw frame tiles for transfer index $11E; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$799..$A19
DATA8_C83A19:						; raw frame tiles for transfer index $123; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$A19..$C39
DATA8_C83C39:						; raw frame tiles for transfer index $124; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$C39..$E99
DATA8_C83E99:						; raw frame tiles for transfer index $125; pose not traced
	incbin "../Extracted/segments/bankC8_3000.bin":$E99..$1000
	incbin "../Extracted/segments/bankC8_4000.bin":$0..$F9
