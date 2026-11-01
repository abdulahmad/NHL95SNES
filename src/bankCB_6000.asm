; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB60D5
DATA8_CB60D5:						; raw frame tiles for transfer index $332; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$D5..$335
DATA8_CB6335:						; raw frame tiles for transfer index $333; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$335..$535
DATA8_CB6535:						; raw frame tiles for transfer index $334; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$535..$795
DATA8_CB6795:						; raw frame tiles for transfer index $335; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$795..$9F5
DATA8_CB69F5:						; raw frame tiles for transfer index $336; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$9F5..$C55
DATA8_CB6C55:						; raw frame tiles for transfer index $337; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$C55..$E55
DATA8_CB6E55:						; raw frame tiles for transfer index $338; pose not traced
	incbin "../Extracted/segments/bankCB_6000.bin":$E55..$1000
	incbin "../Extracted/segments/bankCB_7000.bin":$0..$D5
