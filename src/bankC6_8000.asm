; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C681E8
DATA8_C681E8:						; raw frame tiles for transfer index $040; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$1E8..$448
DATA8_C68448:						; raw frame tiles for transfer index $041; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$448..$6A8
DATA8_C686A8:						; raw frame tiles for transfer index $042; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$6A8..$8A8
DATA8_C688A8:						; raw frame tiles for transfer index $043; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$8A8..$A28
DATA8_C68A28:						; raw frame tiles for transfer index $044; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$A28..$C28
DATA8_C68C28:						; raw frame tiles for transfer index $045; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$C28..$E88
DATA8_C68E88:						; raw frame tiles for transfer index $046; pose not traced
	incbin "../Extracted/segments/bankC6_8000.bin":$E88..$1000
	incbin "../Extracted/segments/bankC6_9000.bin":$0..$88
