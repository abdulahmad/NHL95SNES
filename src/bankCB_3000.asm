; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB30D5
DATA8_CB30D5:						; raw frame tiles for transfer index $2E8; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$D5..$2D5
DATA8_CB32D5:						; raw frame tiles for transfer index $2E9; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$2D5..$4D5
DATA8_CB34D5:						; raw frame tiles for transfer index $2EA; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$4D5..$735
DATA8_CB3735:						; raw frame tiles for transfer index $2EB; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$735..$995
DATA8_CB3995:						; raw frame tiles for transfer index $2EC; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$995..$BF5
DATA8_CB3BF5:						; raw frame tiles for transfer index $2ED; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$BF5..$DF5
DATA8_CB3DF5:						; raw frame tiles for transfer index $2EE; pose not traced
	incbin "../Extracted/segments/bankCB_3000.bin":$DF5..$1000
	incbin "../Extracted/segments/bankCB_4000.bin":$0..$75
