; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB70D5
DATA8_CB70D5:						; raw frame tiles for transfer index $339; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$D5..$2D5
DATA8_CB72D5:						; raw frame tiles for transfer index $33A; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$2D5..$4D5
DATA8_CB74D5:						; raw frame tiles for transfer index $33B; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$4D5..$6D5
DATA8_CB76D5:						; raw frame tiles for transfer index $33C; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$6D5..$935
DATA8_CB7935:						; raw frame tiles for transfer index $33D; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$935..$B35
DATA8_CB7B35:						; raw frame tiles for transfer index $33E; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$B35..$D95
DATA8_CB7D95:						; raw frame tiles for transfer index $33F; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$D95..$F95
DATA8_CB7F95:						; raw frame tiles for transfer index $340; pose not traced
	incbin "../Extracted/segments/bankCB_7000.bin":$F95..$1000
	incbin "../Extracted/segments/bankCB_8000.bin":$0..$1F5
