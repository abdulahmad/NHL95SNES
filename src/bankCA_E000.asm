; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAE139
DATA8_CAE139:						; raw frame tiles for transfer index $2C8; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$139..$2B9
DATA8_CAE2B9:						; raw frame tiles for transfer index $2C9; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$2B9..$3B9
DATA8_CAE3B9:						; raw frame tiles for transfer index $2CA; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$3B9..$4B9
DATA8_CAE4B9:						; raw frame tiles for transfer index $2CB; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$4B9..$6B9
DATA8_CAE6B9:						; raw frame tiles for transfer index $2CC; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$6B9..$939
DATA8_CAE939:						; raw frame tiles for transfer index $2CD; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$939..$BB9
DATA8_CAEBB9:						; raw frame tiles for transfer index $2CE; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$BB9..$E39
DATA8_CAEE39:						; raw frame tiles for transfer index $2CF; pose not traced
	incbin "../Extracted/segments/bankCA_E000.bin":$E39..$1000
	incbin "../Extracted/segments/bankCA_F000.bin":$0..$39
