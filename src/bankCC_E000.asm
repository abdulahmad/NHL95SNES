; Raw planar frame tiles, then the map chunk of IceRinkMap; its tiles and colours are in the next segment.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CCE1E5
DATA8_CCE1E5:						; raw frame tiles for transfer index $41E; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$1E5..$3E5
DATA8_CCE3E5:						; raw frame tiles for transfer index $41F; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$3E5..$5E5
DATA8_CCE5E5:						; raw frame tiles for transfer index $420; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$5E5..$7E5
DATA8_CCE7E5:						; raw frame tiles for transfer index $421; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$7E5..$A45
DATA8_CCEA45:						; raw frame tiles for transfer index $422; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$A45..$CA5
DATA8_CCECA5:						; raw frame tiles for transfer index $423; pose not traced
	incbin "../Extracted/segments/bankCC_E000.bin":$CA5..$EA5
IceRinkMap:							; the rink, 32 x 170 tiles (both halves); CODE_C52037 loads it
	dw IceRinkTiles-IceRinkMap-2	; map chunk length
	db $20,$AA						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $2A80						; unpacked map size
	incbin "../Extracted/segments/bankCC_E000.bin":$EAC..$1000
	incbin "../Extracted/segments/bankCC_F000.bin":$0..$E36
