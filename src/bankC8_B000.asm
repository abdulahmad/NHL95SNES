; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C8B199
DATA8_C8B199:						; raw frame tiles for transfer index $17D; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$199..$419
DATA8_C8B419:						; raw frame tiles for transfer index $180; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$419..$679
DATA8_C8B679:						; raw frame tiles for transfer index $181; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$679..$8F9
DATA8_C8B8F9:						; raw frame tiles for transfer index $182; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$8F9..$B79
DATA8_C8BB79:						; raw frame tiles for transfer index $184; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$B79..$DF9
DATA8_C8BDF9:						; raw frame tiles for transfer index $185; pose not traced
	incbin "../Extracted/segments/bankC8_B000.bin":$DF9..$1000
	incbin "../Extracted/segments/bankC8_C000.bin":$0..$59
