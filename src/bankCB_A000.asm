; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBA115
DATA8_CBA115:						; raw frame tiles for transfer index $34F; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$115..$375
DATA8_CBA375:						; raw frame tiles for transfer index $350; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$375..$5D5
DATA8_CBA5D5:						; raw frame tiles for transfer index $351; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$5D5..$835
DATA8_CBA835:						; raw frame tiles for transfer index $352; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$835..$AB5
DATA8_CBAAB5:						; raw frame tiles for transfer index $353; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$AB5..$D35
DATA8_CBAD35:						; raw frame tiles for transfer index $354; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$D35..$FB5
DATA8_CBAFB5:						; raw frame tiles for transfer index $355; pose not traced
	incbin "../Extracted/segments/bankCB_A000.bin":$FB5..$1000
	incbin "../Extracted/segments/bankCB_B000.bin":$0..$235
